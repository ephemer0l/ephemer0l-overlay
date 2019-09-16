# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Unified high level API library for both signaling and I/O, for telephony boards"
HOMEPAGE="http://www.freeswitch.org/"
SRC_URI="ftp://ftp.sangoma.com/linux/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="BSD"

RDEPEND="virtual/libc
	pcap? ( >=net-libs/libpcap-1.0.0 )
	libpri? ( >=net-libs/libpri-1.4.0 )"

DEPEND="${RDEPEND}"

IUSE="libpri pcap static-libs"

src_configure() {
	econf \
		--with-modinstdir="/usr/$(get_libdir)/${PN}" \
		$(use_with pcap pcap /usr) \
		$(use_with libpri) || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO

	# remove static module files
	use static-libs || (
		for x in "${D}/usr/$(get_libdir)/${PN}/"*.{a,la}; do
			rm -f "${x}" || die "failed to remove \"${x}\""
		done
	)
}
