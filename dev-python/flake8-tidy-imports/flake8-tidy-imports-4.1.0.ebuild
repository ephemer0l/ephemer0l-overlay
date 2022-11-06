# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1

DESCRIPTION="Flake8 extension that helps you write tidier imports."
HOMEPAGE="https://github.com/adamchainz/flake8-tidy-imports"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-python/attrs-19.3.0[${PYTHON_USEDEP}]
	>=dev-python/bleach-3.1.5[${PYTHON_USEDEP}]
	>=dev-python/certifi-2020.4.5.1[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.14.0[${PYTHON_USEDEP}]
	>=dev-python/chardet-3.0.4[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.9.2[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.16[${PYTHON_USEDEP}]
	>=dev-python/flake8-bugbear-20.1.4[${PYTHON_USEDEP}]
	>=dev-python/flake8-comprehensions-3.2.2[${PYTHON_USEDEP}]
	>=dev-python/flake8-3.8.2[${PYTHON_USEDEP}]
	>=dev-python/idna-2.9[${PYTHON_USEDEP}]
	>=dev-python/importlib_metadata-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/isort-4.3.21[${PYTHON_USEDEP}]
	>=dev-python/jeepney-0.4.3[${PYTHON_USEDEP}]
	>=dev-python/keyring-21.2.1[${PYTHON_USEDEP}]
	>=dev-python/mccabe-0.6.1[${PYTHON_USEDEP}]
	>=dev-python/more-itertools-8.3.0[${PYTHON_USEDEP}]
	>=dev-python/multilint-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.4[${PYTHON_USEDEP}]
	>=dev-python/pathlib2-2.3.5[${PYTHON_USEDEP}]
	>=dev-python/pkginfo-1.5.0.1[${PYTHON_USEDEP}]
	>=dev-python/pluggy-0.13.1[${PYTHON_USEDEP}]
	>=dev-python/py-1.8.1[${PYTHON_USEDEP}]
	>=dev-python/pycodestyle-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/pycparser-2.20[${PYTHON_USEDEP}]
	>=dev-python/pyflakes-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.6.1[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.4.7[${PYTHON_USEDEP}]
	>=dev-python/pytest-flake8dir-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-randomly-3.3.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-5.4.2[${PYTHON_USEDEP}]
	>=dev-python/readme_renderer-26.0[${PYTHON_USEDEP}]
	>=dev-python/requests-toolbelt-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/requests-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/secretstorage-3.1.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.46.0[${PYTHON_USEDEP}]
	>=dev-python/twine-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.25.9[${PYTHON_USEDEP}]
	>=dev-python/wcwidth-0.1.9[${PYTHON_USEDEP}]
	>=dev-python/webencodings-0.5.1[${PYTHON_USEDEP}]
	>=dev-python/zipp-3.1.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""
