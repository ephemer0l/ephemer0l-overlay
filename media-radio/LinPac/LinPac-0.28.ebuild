# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic libtool multilib

DESCRIPTION="Console-oriented amateur radio AX.25 keyboard to keyboard chat and PBBS program"
HOMEPAGE="https://sourceforge.net/projects/linpac/"
SRC_URI="https://sourceforge.net/projects/linpac/files/${PN}/${PV}/linpac-${PV}.tar.gz/download -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/ncurses
	media-radio/ax25-apps
	media-radio/ax25-tools
	media-radio/ax25mail-utils"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/${P}-fix-install-paths.patch"
	"${FILESDIR}/${P}-fix-ncurses-lib.patch" )

S=${WORKDIR}/linpac-${PV}/

src_configure() {
	filter-flags -flto=* -floop-nest-optimize -fgraphite-identity
	./configure --libdir=/usr/$(get_libdir)
}

#src_compile() {
#	make
#}
