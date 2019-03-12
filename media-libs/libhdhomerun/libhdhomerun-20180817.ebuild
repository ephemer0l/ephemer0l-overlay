# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="SiliconDust HDHomeRun Utilties"
HOMEPAGE="http://www.silicondust.com/support/hdhomerun/downloads/linux/"
SRC_URI="http://download.silicondust.com/hdhomerun/${PN}_${PV}.tgz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="strip"

S="${WORKDIR}/${PN}"

#src_prepare() {
#	epatch "${FILESDIR}/dont-strip.patch"
#}
src_compile() {
	make || die
}

src_install() {
	dobin hdhomerun_config
	dolib.so libhdhomerun.so
}
