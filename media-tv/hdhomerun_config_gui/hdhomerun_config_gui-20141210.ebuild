# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="SiliconDust HDHomeRun Configuration Utiltiy"
HOMEPAGE="http://www.silicondust.com/support/hdhomerun/downloads/linux/"
SRC_URI="http://download.silicondust.com/hdhomerun/${PN}_${PV}.tgz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=media-libs/libhdhomerun-20141210"
RDEPEND="
	>=x11-libs/gtk+-2.18.3 <x11-libs/gtk+-3.12.2
	${DEPEND}"

S="${WORKDIR}/${PN}"

#src_prepare() {
#    epatch "${FILESDIR}/dont-strip.patch"
#}

#src_configure() {
#    :
#}

src_install() {
	#dobin hdhomerun_config
	#dolib libhdhomerun.so
	insinto /usr/include/hdhomerun-gui
	doins *.h
}
