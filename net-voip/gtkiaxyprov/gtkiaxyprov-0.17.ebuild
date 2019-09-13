# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools subversion

DESCRIPTION="GTK Utility to provision an IAXy Ethernet-to-telephone adapter from Digium"
HOMEPAGE="https://my.digium.com/en/supportcenter/documentation/viewdocs/S100I"
SRC_URI="http://svn.digium.com/svn/gtkiaxyprov"
ESVN_REPO_URI="http://svn.digium.com/svn/gtkiaxyprov/"
ESVN_PROJECT="iaxyprov"
ESVN_REVISION="17"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${DEPEND}
	x11-libs/gtk+"

src_configure() {
	cd "${WORKDIR}/${PN}-${PV}/trunk"
	./configure || die
}

src_compile() {
	cd "${WORKDIR}/${PN}-${PV}/trunk"
	make || die
}

src_install() {
	dobin "${WORKDIR}/${PN}-${PV}/trunk/src/gtkiaxyprov"
}
