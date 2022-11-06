# Copyright 2014-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1 git-r3

DESCRIPTION="Fixes some problems with Unicode text after the fact"
HOMEPAGE="https://pypi.org/project/ftfy/
https://github.com/LuminosoInsight/python-ftfy"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
EGIT_REPO_URI="https://github.com/LuminosoInsight/python-ftfy.git"
EGIT_COMMIT="c2186c76bec6b615fecb18d66315d908a1a379c1"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/wcwidth[${PYTHON_USEDEP}]"

DOCS=( CHANGELOG.md LICENSE.txt README.md )
