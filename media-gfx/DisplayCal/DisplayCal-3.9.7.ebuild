# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 python-r1 xdg

DESCRIPTION="Display Calibration and Characterization powered by Argyll CMS"
HOMEPAGE="https://displaycal.net"

if [[ ${PV} == "9999" ]] ; then
	inherit subversion
#	ESVN_REPO_URI="svn://svn.code.sf.net/p/dispcalgui/code/trunk dispcalgui-code,\
	ESVN_REPO_URI="https://sourceforge.net/p/dispcalgui/code/HEAD/tree/ dispcalgui-code"
	KEYWORDS=""
	S="dispcalgui-code"
else
	MY_PN="DisplayCAL"
	SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="chromecast tests xinerama"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	chromecast? ( dev-python/pychromecast[${PYTHON_USEDEP}] )
	tests? ( dev-python/pytest-faulthandler[${PYTHON_USEDEP}] )
	dev-python/wxpython[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	media-gfx/argyllcms
	x11-apps/xrandr
	x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )
	x11-libs/libXxf86vm"

RDEPEND="${DEPEND}
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
	"

src_prepare() {
	touch "${S}/misc/debian.rules"

	sed -e '/if os.path.isdir/s#/etc/udev/rules.d\|/etc/hotplug#\0-non-existant#' \
		-i DisplayCAL/setup.py || die

	sed -e '/if which/s#xdg-icon-resource#\0-non-existant#' \
		-e '/if which/s#xdg-desktop-menu#\0-non-existant#' \
		-i DisplayCAL/postinstall.py || die

	sed -e '/Encoding=UTF-8/d' -i misc/*.desktop  || die

	sed -e 's/x\-world\/x\-vrml\;//g' \
		-i misc/displaycal-vrml-to-x3d-converter.desktop || die

	distutils-r1_src_prepare
}

#src_compile() {
#	python setup.py || die
#	python setup.py build_ext -i || die
#}

#python_test() {
#	pushd tests > /dev/null
#	"${PYTHON}" run_tests || die
#	popd > /dev/null
#}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
