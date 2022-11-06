# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_8 )
inherit distutils-r1 git-r3

DESCRIPTION="Official Imgur python client library (deprecated)"
HOMEPAGE="https://github.com/Imgur/imgurpython"
EGIT_REPO_URI="https://github.com/Imgur/imgurpython.git"
EGIT_COMMIT="48abc45a143ee9d2485c22a63b7cd55701d8163c"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/requests[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""
