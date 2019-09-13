# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools subversion

DESCRIPTION="Utility to provision an IAXy Ethernet-to-telephone adapter from Digium"
HOMEPAGE="https://my.digium.com/en/supportcenter/documentation/viewdocs/S100I"
SRC_URI="http://svn.digium.com/svn/iaxyprov"
ESVN_REPO_URI="http://svn.digium.com/svn/iaxyprov/"
ESVN_PROJECT="iaxyprov"
ESVN_REVISION="17"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
RDEPEND="${DEPEND}"

src_compile() {
	cd "${WORKDIR}/${PN}-${PV}/trunk"
	make || die
}

src_install() {
	dodoc "${WORKDIR}/${PN}-${PV}/trunk/iaxy.conf.sample"
	if use debug; then
		dobin "${WORKDIR}/${PN}-${PV}/trunk/iaxydebug"
	fi
	dobin "${WORKDIR}/${PN}-${PV}/trunk/iaxyprov"
}
