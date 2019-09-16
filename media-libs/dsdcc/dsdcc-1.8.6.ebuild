# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the NWA General License

EAPI=7

inherit cmake-utils

DESCRIPTION="Digital Speech Decoder (DSD) rewritten as a C++ library"
HOMEPAGE="https://github.com/f4exb/dsdcc"
LICENSE=""
SLOT="0"
IUSE="mbelib"

_GIT_USER="f4exb"
_GIT_COMMIT=""
_MY_LONG_COMMIT=""

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
	inherit git-r3
elif [[ ${PV} == "0p_*" ]] ; then
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${_GIT_USER}-${PN}-${_GIT_COMMIT}
else
	SRC_URI="https://github.com/f4exb/dsdcc/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

BDEPEND="dev-libs/serialDV"
DEPEND="mbelib? ( media-libs/mbelib )"
