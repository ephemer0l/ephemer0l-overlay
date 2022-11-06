# Copyright 1999-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=8

inherit cmake
#multilib

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/freedv/freedv.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/freedv/freedv/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS=""
fi

DESCRIPTION="HF Digital Voice for Radio Amateurs"
HOMEPAGE="http://freedv.org/tiki-index.php"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/libsndfile
	x11-libs/gtk+:2
	media-libs/libsamplerate
	media-libs/alsa-lib"

RDEPEND="${DEPEND}"

#src_prepare() {
#    sed -i -e "s#X}/lib#X}/$(get_libdir)#" -e "s#N lib#N $(get_libdir)#" "${S}/CMakeLists.txt"
#}

src_configure() {
	local mycmakeargs=(
		BUILD_DIR=${WORKDIR}/${P}_build
		)
	cmake-utils_src_configure
}
