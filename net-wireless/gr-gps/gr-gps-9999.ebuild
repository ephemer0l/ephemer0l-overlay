# Copyright 1999-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=8

PYTHON_COMPAT=( python{2_7,3_{8,9,10,11}} )
inherit cmake git-r3

DESCRIPTION="GNU Radio block for a GPS receiver"
HOMEPAGE="https://github.com/slaaja/gr-gps"

EGIT_REPO_URI="https://github.com/slaaja/gr-gps.git"
EGIT_BRANCH="master"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="doc"
DEPEND=">=net-wireless/gnuradio-3.7.0:=
	dev-libs/boost:=
	dev-util/cppunit
	dev-lang/swig:*"

RDEPEND="${DEPEND}"

src_configure() {
	sed -i '0,/include\/gps/s/include\/gps/include\/gnuradio\/gps/' "${WORKDIR}"/"${P}"/CMakeLists.txt || die 'sed failed'
	cmake-utils_src_configure
}
