# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils autotools

DESCRIPTION="Packaged version of iLBC codec from the WebRTC project"
HOMEPAGE="https://webrtc.github.io/webrtc-org/license/ilbc-freeware/"

MY_PN="ilbc"
MY_P="${MY_PN}-${PV}"

SRC_URI="http://files.freeswitch.org/downloads/libs/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~x86"

# Code was relicensed to BSD (see https://webrtc.org/license/ilbc-freeware/)
LICENSE="BSD"
SLOT="0"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	eapply_user
	eautoreconf
}

src_compile() {
	emake
}
