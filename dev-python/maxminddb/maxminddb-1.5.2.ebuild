# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1 git-r3

DESCRIPTION="Python MaxMind DB reader extension"
HOMEPAGE="https://github.com/maxmind/MaxMind-DB-Reader-python"
EGIT_REPO_URI="https://github.com/maxmind/MaxMind-DB-Reader-python.git"
EGIT_COMMIT="f5b8b4bafabc06504e2ee2e0571f2d8571db17bb"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
