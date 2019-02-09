# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

DESCRIPTION="Fast and free multi-language code editor. "
HOMEPAGE="https://github.com/Komodo/KomodoEdit"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/Komodo/KomodoEdit.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/Komodo/KomodoEdit/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#FEATURES="-sandbox"

DEPEND="virtual/perl-File-Spec
	sys-devel/make
	x11-libs/gtk+
	x11-libs/libXt
	dev-libs/libIDL
	app-arch/zip
	media-libs/freetype
	media-libs/fontconfig
	media-libs/gstreamer
	virtual/pkgconfig
	sys-apps/dbus
	media-libs/alsa-lib
	media-sound/pulseaudio
	x11-libs/libnotify
	dev-lang/yasm
	media-libs/mesa
	sys-devel/autoconf
	!app-editors/komodo-edit-bin
	${PYTHON_DEPS}"

RDEPEND="${DEPEND}"

S="${WORKDIR}/KomodoEdit-${PV}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	"${EPYTHON}" "${S}"/mozilla/build.py configure -k 10.2 || die "Failed to configure"
}

src_compile() {
	"${EPYTHON}" "${S}"/mozilla/build.py all || die "Failed to build"
}
