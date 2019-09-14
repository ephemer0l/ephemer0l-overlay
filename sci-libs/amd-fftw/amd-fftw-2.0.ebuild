# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit distutils-r1

DESCRIPTION="FFTW code optimized for AMD based processors"
HOMEPAGE="https://github.com/amd/amd-fftw"

_GIT_USER="amd"
_GIT_COMMIT="eac74f1"
_MY_LONG_COMMIT="eac74f1ceba4289cc0253c3105bf743b1589cfdd"

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
