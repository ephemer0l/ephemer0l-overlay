# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1

DESCRIPTION="A plugin for Flake8 finding likely bugs and design problems in your program."
HOMEPAGE="https://github.com/PyCQA/flake8-bugbear"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/flake8[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""
