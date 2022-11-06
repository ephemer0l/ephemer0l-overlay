# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1

DESCRIPTION="Run multiple python linters easily"
HOMEPAGE="https://github.com/adamchainz/multilint"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ISC"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPS="
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/bleach[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	virtual/python-cffi[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/check-manifest[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/flake8-bugbear[${PYTHON_USEDEP}]
	dev-python/flake8[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]
	>=dev-python/isort-4.3.21[${PYTHON_USEDEP}]
	dev-python/jeepney[${PYTHON_USEDEP}]
	dev-python/mccabe[${PYTHON_USEDEP}]
	dev-python/modernize[${PYTHON_USEDEP}]
	>=dev-python/more-itertools-8.3.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.4[${PYTHON_USEDEP}]
	dev-python/pep517[${PYTHON_USEDEP}]
	>=dev-python/pluggy-0.13.1[${PYTHON_USEDEP}]
	dev-python/py[${PYTHON_USEDEP}]
	>=dev-python/pycodestyle-2.6.0[${PYTHON_USEDEP}]
	dev-python/pycparser[${PYTHON_USEDEP}]
	>=dev-python/pyflakes-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.4.7[${PYTHON_USEDEP}]
	>=dev-python/pytest-5.4.3[${PYTHON_USEDEP}]
	dev-python/readme_renderer[${PYTHON_USEDEP}]
	dev-python/requests-toolbelt[${PYTHON_USEDEP}]
	>=dev-python/requests-2.23.0[${PYTHON_USEDEP}]
	>=dev-python/secretstorage-3.1.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/toml-0.10.1[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.46.1[${PYTHON_USEDEP}]
	>=dev-python/twine-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.25.9[${PYTHON_USEDEP}]
	>=dev-python/wcwidth-0.2.3[${PYTHON_USEDEP}]
	dev-python/webencodings[${PYTHON_USEDEP}]
	>=dev-python/zipp-3.1.0[${PYTHON_USEDEP}]"
