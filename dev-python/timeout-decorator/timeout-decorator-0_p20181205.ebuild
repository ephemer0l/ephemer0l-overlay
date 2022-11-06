# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{7,8} )
inherit distutils-r1 git-r3

DESCRIPTION="Timeout decorator for Python"
HOMEPAGE="https://github.com/pnpnpn/timeout-decorator"
EGIT_REPO_URI="https://github.com/pnpnpn/timeout-decorator.git"
EGIT_COMMIT="3c4bad7f66e1109ccdcb79c2cb62cd669b7666d8"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/requests[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure(){
	python setup.py
}
