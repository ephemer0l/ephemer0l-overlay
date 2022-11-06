# Copyright 1999-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=8

PYTHON_COMPAT=( python{2_7,3_{8,9,10,11}} )
inherit cmake git-r3

DESCRIPTION="GNU Radio block for Digital Speech Decoder"
HOMEPAGE="https://github.com/argilo/gr-dsd"

EGIT_REPO_URI="https://github.com/argilo/gr-dsd.git"
EGIT_BRANCH="master"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="doc"
DEPEND=">=net-wireless/gnuradio-3.7.0:=
	dev-libs/boost:=
	media-libs/libsndfile
	dev-util/cppunit
	sci-libs/itpp
	>=dev-libs/log4cpp-1.1:=
	dev-lang/swig:*
	doc? ( app-doc/doxygen )"

RDEPEND="${DEPEND}"

src_configure() {
	sed -i "0,/include\/dsd/s/include\/dsd/include\/gnuradio\/dsd/" "${WORKDIR}/${P}/CMakeLists.txt" || die "sed failed"
	local mycmakeargs=(
		-DWITH_ENABLE_DOXYGEN=YES="$(usex doc)"
	)
	cmake-utils_src_configure
}
