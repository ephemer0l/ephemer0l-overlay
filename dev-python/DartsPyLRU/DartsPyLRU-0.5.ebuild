# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

HOMEPAGE="https://pypi.python.org/pypi/darts.util.lru"

DESCRIPTION="Simple dictionary with LRU behaviour"

LICENSE="MIT"

SLOT=0

_GIT_USER="deterministic-arts"
_MY_COMMIT="5ef01b1"
_MY_LONG_COMMIT="5ef01b189b10bf814d9c0c0e3d98caaa791cb081"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${_GIT_USER}-${PN}-${_MY_COMMIT}
fi

python_test() {
	test.py || die
}
