# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{6,7}} )

inherit distutils-r1

HOMEPAGE="https://github.com/sabnzbd/sabyenc"
DESCRIPTION="Python yEnc package optimized for use within SABnzbd"

_GIT_USER="sabnzbd"
_GIT_COMMIT="c233dba"
_MY_LONG_COMMIT="c233dbaeaff6f3a1398cd25800092bf771a00bb6"

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
SLOT=0

USE="test"
