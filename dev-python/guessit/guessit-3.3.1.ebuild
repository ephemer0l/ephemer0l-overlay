# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="library that extracts as much information as possible from a video filename"
HOMEPAGE="https://github.com/guessit-io/guessit/ https://pypi.org/project/guessit/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
"
PDEPEND="
"
BDEPEND="${RDEPEND}
		${PDEPEND}
		dev-python/packaging
		dev-python/mkdocs
		dev-python/tox
		dev-python/pytest-runner
		dev-python/importlib_resources
		dev-python/python-dateutil
		dev-python/rebulk
		dev-python/babelfish
"
src_configure() {
	python setup.py
}
