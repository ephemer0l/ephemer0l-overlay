# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="pure python module that will identify a file based off it’s magic numbers."
HOMEPAGE="https://github.com/cdgriffith/puremagic https://pypi.org/project/puremagic/"
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
