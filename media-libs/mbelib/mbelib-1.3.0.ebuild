# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the NWA General License

EAPI=7

inherit cmake multilib

HOMEPAGE="https://github.com/szechyjs/mbelib"
DESCRIPTION="P25 Phase 1 and ProVoice vocoder"
LICENSE="BSD"
SLOT=0
IUSE=static-libs

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/szechyjs/mbelib.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/szechyjs/mbelib/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

src_prepare() {
	sed -i -e "s#X}/lib#X}/$(get_libdir)#" -e "s#N lib#N $(get_libdir)#" "${S}/CMakeLists.txt"
}

src_install() {
	cmake-utils_src_install
	use static-libs || rm "${ED}"/usr/$(get_libdir)/libmbe.a
}
