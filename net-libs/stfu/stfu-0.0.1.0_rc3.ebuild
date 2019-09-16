# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

FS_P='freeswitch-1.0.1'
SRC_URI="http://files.freeswitch.org/${FS_P}.tar.gz"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

subS="${FS_P}/libs/${PN}"
S="${WORKDIR}/${subS}"

src_unpack() {
	tar -xzf "${DISTDIR}/${A}" "${subS}"
}

src_compile() {
	gcc -c stfu.c -o stfu.o || die "compile failed"
}

src_install() {
	dolib stfu.o
	insinto /usr/include
	doins stfu.h
}
