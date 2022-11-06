# Copyright 2018-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{8,9,10,11}} )
inherit python-single-r1 scons-utils toolchain-funcs

DESCRIPTION="The Powder Toy is a free physics sandbox"
HOMEPAGE="https://powdertoy.co.uk/"

_GIT_USER="ThePowderToy"
_GIT_PACKAGE="The-Powder-Toy"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/"${_GIT_PACKAGE}".git"
	KEYWORDS=""
	inherit git-r3
else
SRC_URI="https://github.com/"${_GIT_USER}"/"${_GIT_PACKAGE}"/archive/refs/tags/snapshot-"${PV}".tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
#	SRC_URI="https://github.com/"${_GIT_USER}"/"${_GIT_PACKAGE}"/archive/v"${PV}".tar.gz -> ${P}.tar.gz"
#	KEYWORDS="~amd64 ~x86"
#fi

LICENSE="GPL-3"
SLOT="0"
IUSE="cpu_flags_x86_mmxext cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3
	debug fftw opengl opengl-particles save-renderer static-libs"

REQUIRED_USE="${PYTHON_REQUIRED_USE}
	opengl-particles? ( opengl )
	cpu_flags_x86_sse3?  ( cpu_flags_x86_sse2 cpu_flags_x86_sse cpu_flags_x86_mmxext )
	cpu_flags_x86_sse2?  ( cpu_flags_x86_sse cpu_flags_x86_mmxext )
	cpu_flags_x86_sse?  ( cpu_flags_x86_mmxext )"

DEPEND="
	fftw? ( sci-libs/fftw:3.0[threads] )"

BDEPEND="
	dev-lang/lua:0
	media-libs/libsdl2
	dev-util/scons
	opengl? ( virtual/opengl )"

S=${WORKDIR}/${_GIT_PACKAGE}-${PV}/

src_prepare() (
	sed -e s/LINKFLAGS/LDFLAGS/g -i "${S}"/SConscript || die
	eapply_user
)

src_configure() {
	tc-export CC CXX LD STRIP
	MYSCONS=( ${MAKEOPTS} --release
		$(usex debug --debugging --wall)
		$(usex fftw ''  --nofft)
		$(usex opengl --opengl)
		$(usex opengl-particles --opengl-renderer)
		$(usex save-renderer --renderer)
		$(usex cpu_flags_x86_mmxext --sse)
		$(usex cpu_flags_x86_sse --sse2)
		$(usex cpu_flags_x86_sse2 --sse3)
		$(usex static-libs --static)
		)
}

src_compile() {
	escons "${MYSCONS[@]}"
}

src_install() {
	escons "${MYSCONS[@]}" DESTDIR="${D}" install
}
