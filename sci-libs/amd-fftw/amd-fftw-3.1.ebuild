# Copyright 2019 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=8

DESCRIPTION="FFTW code optimized for AMD based processors"
HOMEPAGE="https://github.com/amd/amd-fftw"

_GIT_USER="amd"
_GIT_COMMIT="2b0bbb5"
_MY_LONG_COMMIT="2b0bbb5924c9e31cb58f34e10832d236bbc51af6"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${_GIT_USER}-${PN}-${_GIT_COMMIT}
fi

LICENSE="GPL"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/ocaml
	dev-ml/ocamlbuild
	dev-util/indent"
