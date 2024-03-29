# Copyright 1999-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=8

inherit cmake

HOMEPAGE="http://gnss-sdr.org/"
DESCRIPTION="Global Navigation Satellite System Software Defined Receiver"
LICENSE="GPL-3"
SLOT=0
IUSE="array debug doc gn3s opencl pdf rtl-sdr tcmalloc"
REQUIRED_USE="pdf? ( doc )"

_GIT_USER="gnss-sdr"
_MY_LONG_COMMIT="31c6b6bc1da77c9589a04d52a38d2d20edacf06e"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="-* ~amd64 ~x86"
fi

#S=${WORKDIR}/${P}

DEPEND="
	net-wireless/uhd
	>=net-wireless/gnuradio-3.7.4.1[uhd,trellis,filter,analog]
	sci-libs/armadillo[lapack,blas]
	dev-libs/openssl:0.9.8
	doc? ( app-doc/doxygen )
	pdf? ( app-doc/doxygen[latex] )
	dev-libs/boost[threads]
	>=sys-devel/gcc-4.7.0:4.7[fortran]
	tcmalloc? ( dev-util/google-perftools )
	dev-cpp/glog[gflags]
	"
#	    dev-cpp/glog[gflags]
#	    dev-cpp/gtest
#		sys-devel/clang?

RDEPEND="${DEPEND}"

src_prepare() {
	if KEYWORDS="~amd64" ; then
		 epatch "${FILESDIR}"/x86_64-gfortran-path.patch
	fi
	if KEYWORDS="~x86" ; then
		epatch "${FILESDIR}"/x86-gfortran-path.patch
	fi
}

src_configure() {
	local mycmakeargs=(
		-DLOCAL_GFLAGS=/usr/${get_libdir}/
		-DLOCAL_GLOG=/usr/${get_libdir}/
		$(cmake-utils_use_enable gn3s ENABLE_GN3S)
		$(cmake-utils_use_enable array ENABLE_ARRAY)
		$(cmake-utils_use_enable rtl-sdr ENABLE_RTLSDR)
		$(cmake-utils_use_enable opencl ENABLE_OPENCL)
		$(cmake-utils_use_enable tcmalloc ENABLE_GPERFTOOLS)
		$(cmake-utils_use_enable doc HAVE_DOT)
		$(cmake-utils_use_enable pdf GENERATE_PDF_DOCUMENTATION)
		)
	use debug && mycmakeargs="${mycmakeargs} -DCMAKE_BUILD_TYPE=Debug"
	use tcmalloc && mycmakeargs="${mycmakeargs} \
				-DGPERFTOOLS_LIBRARIES=
				-DGPERFTOOLS_INCLUDE_DIR="
	cmake-utils_src_configure
}

# Fix the following when using local gflags,gloog, and gtest.
#-- Cannot find Root directory of gflags
#--  gflags library has not been found.
#--  gflags will be downloaded and built automatically 
#--  when doing 'make'. 
#-- glog library found at /usr/lib64/libglog.so
#-- Found Glog: /usr/lib64/libglog.so  
#--  glog library has not been found
#--  or it is likely not linked to gflags.
#--  glog will be downloaded and built automatically 
#--  when doing 'make'.
