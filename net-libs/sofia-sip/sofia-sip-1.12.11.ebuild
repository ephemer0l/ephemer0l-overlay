# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="RFC3261 compliant SIP User-Agent library"
HOMEPAGE="http://sofia-sip.sourceforge.net/"

SRC_URI="https://sourceforge.net/projects/"${PN}"/files/"${PN}"/"${PV}"/"${PN}"-"${PV}".tar.gz/download -> "${P}".tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE="glib ipv6 ntlm sctp ssl +stun"

RDEPEND="
	glib? ( dev-libs/glib )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

src_configure() {
	sh autogen.sh
	econf \
		$(use_enable ipv6 ip6) \
		$(use_enable sctp) \
		$(use_enable stun) \
		$(use_enable ntlm) \
		$(use_with glib) \
		$(use_with ssl openssl) \
	|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ChangeLog COPYRIGHTS README TODO
}
