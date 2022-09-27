# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 python-r1 xdg

DESCRIPTION="Display Calibration and Characterization powered by Argyll CMS"
HOMEPAGE="https://displaycal.net"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_BRANCH="main"
	EGIT_REPO_URI="https://github.com/eoyilmaz/displaycal-py3.git"
	KEYWORDS=""
else
	MY_PN="DisplayCAL"
	SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="chromecast xinerama"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	dev-python/build[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	chromecast? ( dev-python/pychromecast[${PYTHON_USEDEP}] )
	dev-python/wxpython[${PYTHON_USEDEP}]
	dev-python/pkgconfig[${PYTHON_USEDEP}]
	media-gfx/argyllcms
	xinerama? ( x11-libs/libXinerama )
	x11-libs/libXxf86vm"

RDEPEND="${DEPEND}
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
	"

src_prepare() {
	touch "${S}/misc/debian.rules"

	sed -e '/if which/s#xdg-icon-resource#\0-non-existant#' \
		-e '/if which/s#xdg-desktop-menu#\0-non-existant#' \
		-i DisplayCAL/postinstall.py || die

	sed -e '/Encoding=UTF-8/d' -i misc/*.desktop  || die

	sed -e 's/x\-world\/x\-vrml\;//g' \
		-i misc/displaycal-vrml-to-x3d-converter.desktop || die

	distutils-r1_src_prepare
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
