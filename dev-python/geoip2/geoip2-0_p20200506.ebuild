# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1 git-r3

DESCRIPTION="Python code for GeoIP2 webservice client and database reader "
HOMEPAGE="https://github.com/maxmind/GeoIP2-python"
EGIT_REPO_URI="https://github.com/maxmind/GeoIP2-python.git"
EGIT_COMMIT="1bcd28986cd1dbc874ced96e88c8871ff3d65d9b"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	>=dev-python/maxminddb-1.5.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.2.25[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""
