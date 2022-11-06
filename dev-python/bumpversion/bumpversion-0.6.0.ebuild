# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8,9} pypy )

inherit distutils-r1

DESCRIPTION="Version-bump your software with a single command!"
HOMEPAGE="http://pypi.python.org/pypi/bumpversion https://github.com/peritus/bumpversion"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"

DEPEND="
    dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
        dev-python/pytest[${PYTHON_USEDEP}]
    )"


DOCS=( README.rst )

python_test() {
	py.test || die "Tests fail with ${EPYTHON}"
}
