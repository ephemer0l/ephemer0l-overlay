# Copyright 2019 Gentoo Author ephemer0l
# Distributed under the terms of the NWA General License

EAPI=8

PYTHON_COMPAT=( python3_{7,8,9,10} )
PYTHON_REQ_USE="test"

inherit distutils-r1 python-r1

HOMEPAGE="https://github.com/sabnzbd/sabyenc"
DESCRIPTION="Python yEnc package optimized for use within SABnzbd"

_GIT_USER="sabnzbd"
_GIT_COMMIT="2c17091"
_MY_LONG_COMMIT="2c1709145d76ab5faeacea3af2c8926f50e02e9f"

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

LICENSE="LGPL-3"
SLOT="0"
IUSE="test"

BDEPEND="test? (
	dev-python/chardet[${PYTHON_USEDEP}]
	)"
