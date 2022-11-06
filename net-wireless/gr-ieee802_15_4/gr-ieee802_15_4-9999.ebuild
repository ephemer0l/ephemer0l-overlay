# Copyright 1999-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=8

PYTHON_COMPAT=( python{2_7,3_{8,9,10,11}} )
inherit cmake git-r3

DESCRIPTION="GNU Radio block for IEEE 802.15.4 ZigBee Transceiver"
HOMEPAGE="http://www.ccs-labs.org/software/gr-ieee802-15-4/"

EGIT_REPO_URI="https://github.com/bastibl/gr-ieee802-15-4.git"
EGIT_BRANCH="master"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="doc"
DEPEND=">=net-wireless/gnuradio-3.7.0:=
	dev-libs/boost:=
	dev-util/cppunit
	dev-lang/swig:*
	dev-python/matplotlib
	net-wireless/gr-foo"

RDEPEND="${DEPEND}"

src_configure() {
	sed -i "0,/include\/ieee802_15_4/s/include\/ieee802_15_4/include\/gnuradio\/ieee802_15_4/" "${WORKDIR}/${P}/CMakeLists.txt" || die "sed failed"
	local mycmakeargs=(
		-DWITH_ENABLE_DOXYGEN=YES="$(usex doc)"
	)
	cmake-utils_src_configure
}
