# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools libtool

FS_P='freeswitch-1.0.1'
SRC_URI="http://files.freeswitch.org/${FS_P}.tar.gz"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MPL-1.1"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"

subS="${FS_P}/libs/${PN}"
S="${WORKDIR}/${subS}"

src_unpack() {
	tar -xzf "${DISTDIR}/${A}" "${subS}"
	cd "${S}"
}

src_configure() {
	autoconf &>/dev/null # autoconf errors the first time
	eautoreconf
	econf $(use_enable debug) || die "econf failed"
}
