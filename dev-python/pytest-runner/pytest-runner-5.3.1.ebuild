# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Setup scripts to add setup.py test support for pytest runner"
HOMEPAGE="https://github.com/pytest-dev/pytest-runner/ https://pypi.org/project/pytest-runner/"
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
"
