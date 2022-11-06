# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit pax-utils

DESCRIPTION="free VoIP softphone for non-commercial use"
HOMEPAGE="https://www.zoiper.com/en/voip-softphone"

_MY_PV="${PN}5"
_MY_PN="${PN}5_${PV}_x86_64"

SRC_URI="https://www.zoiper.com/en/voip-softphone/download/${_MY_PV}/for/linux -> ${_MY_PN}.tar.xz"

KEYWORDS="~amd64"
LICENSE=""
SLOT="5"
IUSE="video"
RESTRICT="fetch mirror strip"

RDEPEND="${DEPEND}
	>=sys-devel/gcc-6.0.0
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	video? ( media-libs/libv4l )"

S="${WORKDIR}/Zoiper5"

pkg_nofetch() {
	einfo "Please download "${PN}"5_"${PV}"_x86_64.tar.xz from:"
	einfo "https://www.zoiper.com/en/voip-softphone/download/current"
	einfo "and place this file in ${DISTDIR}"
}

src_install() {
	pax-mark -m "${S}/zoiper"
	insinto "${ESYSROOT}/opt/Zoiper5"
	doins -r "${S}"
}
