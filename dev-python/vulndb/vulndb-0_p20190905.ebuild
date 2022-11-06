# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} )

inherit distutils-r1 git-r3

DESCRIPTION="Python SDK to access the vulnerability database"
HOMEPAGE="https://github.com/vulndb/python-sdk/"

EGIT_REPO_URI="https://github.com/vulndb/python-sdk.git"

LICENSE="vulndb"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/nose
	dev-python/pylint
	>=dev-python/setuptools-git-1.1
	"
RDEPEND="${DEPEND}"
