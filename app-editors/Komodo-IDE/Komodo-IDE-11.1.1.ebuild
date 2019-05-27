# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python{2_7,3_{6,7}} )
inherit eutils python-single-r1 pax-utils

MY_BUILD="91089"

DESCRIPTION="Advanced IDE and editor for dynamic and Web languages"
HOMEPAGE="https://www.activestate.com/komodo-ide"
LICENSE="MPL-1.1
	MIT
	Boost-1.0
	CC-BY-2.5
	CC-BY-3.0
	SilverCity
	LGPL-2.1
	LGPL-3
	PSF-2
	Apache-2.0
	OFL-1.1
"
SRC_URI="x86? ( http://downloads.activestate.com/Komodo/releases/${PV}/${PN}-${PV}-${MY_BUILD}-linux-x86.tar.gz )
	amd64? ( http://downloads.activestate.com/Komodo/releases/${PV}/${PN}-${PV}-${MY_BUILD}-linux-x86_64.tar.gz )"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RESTRICT="strip mirror"

IUSE="pax_kernel"

RDEPEND="
	virtual/jpeg
	virtual/libc
	x11-libs/gtk+
	x11-libs/pango
	x11-base/xorg-server
	x11-libs/gdk-pixbuf
	gnome-base/libgnomeui
	gnome-base/libgnome"

QA_PREBUILT="*"
QA_FLAGS_IGNORED="*"
QA_PRESTRIPPED="*"

src_unpack() {
	if use amd64; then
		S="${WORKDIR}"/"${PN}"-"${PV}"-"${MY_BUILD}"-linux-x86_64
	fi

	if use x86; then
		S="${WORKDIR}"/"${PN}"-"${PV}"-"${MY_BUILD}"-linux-x86
	fi
}

src_install() {
	if use pax_kernel; then
		pax-mark m "${S}"/INSTALLDIR/lib/mozilla/komodo
	fi

	insinto /opt/${PN}
	doins -r "${S}"/INSTALLDIR/share
	mv "${S}"/INSTALLDIR/lib "${ED}opt/${PN}/" || die "Installation failed"

	make_wrapper komodo-ide "${EPREFIX}"/opt/"${PN}"/lib/mozilla/komodo "${EPREFIX}"/opt/"${PN}"/lib/mozilla /usr/bin

	make_desktop_entry \
		""${EPREFIX}"/usr/bin/komodo-ide" \
		"Komodo Edit "${PV}"" \
		""${EPREFIX}"/opt/"${PN}"/share/icons/komodo48.png" \
		"Development;IDE;TextEditor" \
		|| die "make_desktop_entry failed"
}
