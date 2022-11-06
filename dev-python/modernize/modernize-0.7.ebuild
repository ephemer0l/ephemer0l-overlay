# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_8 )
inherit distutils-r1

DESCRIPTION="Modernizes Python code for eventual Python 3 migration. Built on top of 2to3. "
HOMEPAGE="https://github.com/python-modernize/python-modernize"
SRC_URI="https://github.com/python-modernize/python-modernize/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="PSF"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
