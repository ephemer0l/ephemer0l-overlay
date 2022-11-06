# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python{2_7,3_{8,9,10,11}} )

inherit distutils-r1

DESCRIPTION="Python SDK to access the vulnerability database"
HOMEPAGE="https://github.com/vulndb/python-sdk/"
SRC_URI="https://pypi.python.org/packages/source/v/vulndb/vulndb-0.0.19.tar.gz"

LICENSE="vulndb"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/nose
	dev-python/pylint
	>=dev-python/setuptools-git-1.1
	"
RDEPEND="${DEPEND}"
