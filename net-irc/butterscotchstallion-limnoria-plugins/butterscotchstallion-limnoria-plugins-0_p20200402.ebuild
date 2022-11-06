# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1 git-r3

DESCRIPTION="A smattering of Limnoria plugins written by butterscotchstallion"
HOMEPAGE="https://github.com/butterscotchstallion/limnoria-plugins"

KEYWORDS="amd64 x86"
IUSE=""

SLOT="0"

DEPEND="
	dev-python/html5lib
	dev-python/lxml
	dev-python/beautifulsoup
	dev-python/jinja
	dev-python/imgurpython 
	dev-python/requests
	dev-python/timeout-decorator
	dev-python/certifi
	dev-python/pytz"
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
    einfo "Nothing to Compile"
}

src_install() {
    python_version
    # Copy Things over
    dodir /usr/lib/python${PYVER}/site-packages/supybot/plugins/
    cd ${S}
    cp -R * ${D}/usr/lib/python${PYVER}/site-packages/supybot/plugins/
}

