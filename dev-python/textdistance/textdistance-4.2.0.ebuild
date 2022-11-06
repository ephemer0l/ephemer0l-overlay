# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1

DESCRIPTION="Compute distance between the two texts."
HOMEPAGE="https://github.com/life4/textdistance"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/flake8-bugbear[${PYTHON_USEDEP}]
	dev-python/pep8-naming[${PYTHON_USEDEP}]
	dev-python/flake8-commas[${PYTHON_USEDEP}]
	dev-python/flake8-quotes[${PYTHON_USEDEP}]
	dev-python/flake8-blind-except[${PYTHON_USEDEP}]
	dev-python/flake8-logging-format[${PYTHON_USEDEP}]
	dev-python/flake8-pep3101[${PYTHON_USEDEP}]
	dev-python/flake8-string-format[${PYTHON_USEDEP}]
	dev-python/flake8-mutable[${PYTHON_USEDEP}]
	dev-python/flake8-tidy-imports[${PYTHON_USEDEP}]
	dev-python/pep8-naming[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""
