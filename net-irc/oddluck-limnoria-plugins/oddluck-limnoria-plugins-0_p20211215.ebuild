# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit distutils-r1 git-r3

DESCRIPTION="Limnoria plugins written or forked by oddluck"
HOMEPAGE="https://github.com/oddluck/limnoria-plugins"
EGIT_REPO_URI="https://github.com/oddluck/limnoria-plugins.git"
EGIT_COMMIT="a5dcd83d7bf4320c2c1d483b4d1d8b83b520c48a"

LICENSE="DWTFYWT-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="
	dev-python/beautifulsoup[${PYTHON_USEDEP}]
	dev-python/ftfy[${PYTHON_USEDEP}]
	dev-python/geoip2[${PYTHON_USEDEP}]
	dev-python/cobe[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	net-irc/Limnoria[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pendulum[${PYTHON_USEDEP}]
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyimgur[${PYTHON_USEDEP}]
	dev-python/pylyrics3[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
	dev-python/roman-numerals[${PYTHON_USEDEP}]
	dev-python/textdistance[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
	"

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
