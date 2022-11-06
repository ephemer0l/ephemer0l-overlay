# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1 git-r3

DESCRIPTION="Limnoria plugins written or forked by ProgVal"
HOMEPAGE="https://github.com/ProgVal/Supybot-plugins"
EGIT_REPO_URI="https://github.com/ProgVal/Supybot-plugins.git"
EGIT_COMMIT="2b82465ba14c58e6ef14c82e0db4de854611b528"

LICENSE=""
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
	rm README.md
	rm requirements.txt
}

src_install() {
	python_version
	# Copy Things over
	dodir /usr/lib/python${PYVER}/site-packages/supybot/plugins/
	cd ${S}
	cp -R * ${D}/usr/lib/python${PYVER}/site-packages/supybot/plugins/
}
