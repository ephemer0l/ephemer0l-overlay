# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Traceback fiddling library"
HOMEPAGE="https://github.com/ionelmc/python-tblib"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/ionelmc/python-tblib"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/ionelmc/python-tblib/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}/python-${P}

DEPEND=""
RDEPEND="${DEPEND}"
