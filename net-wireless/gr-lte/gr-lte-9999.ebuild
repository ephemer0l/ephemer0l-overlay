# Copyright 1999-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=8

PYTHON_COMPAT=( python{2_7,3_{8,9,10,11}} )
inherit cmake git-r3

DESCRIPTION="GNU Radio block for LTE signals"
HOMEPAGE="https://github.com/kit-cel/gr-lte"

EGIT_REPO_URI="https://github.com/kit-cel/gr-lte.git"
EGIT_BRANCH="master"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE=""
DEPEND=">=net-wireless/gnuradio-3.7.0:=
	dev-libs/boost:=
	>=sci-libs/fftw-3.3.4:=
	dev-util/cppunit
	dev-lang/swig:*"

RDEPEND="${DEPEND}"

src_configure() {
	sed -i '0,/include\/lte/s/include\/lte/include\/gnuradio\/lte/' "${WORKDIR}"/"${P}"/CMakeLists.txt || die 'sed failed'
	cmake-utils_src_configure
}
