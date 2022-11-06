# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the NWA General License

EAPI=7

inherit unpacker

DESCRIPTION="A P2P (player-to-player) network that offers LAN based gaming - with chat rooms."
HOMEPAGE="https://www.teamxlink.co.uk/"
LICENSE="none"
SLOT="0"

_GIT_USER="Team-XLink"
_MY_HASH="539601682"
_MY_URI="https://github.com/${_GIT_USER}/releases/releases/download"
SRC_URI="${_MY_URI}/${PV}/xlinkkai_${PV}-${_MY_HASH}_amd64.deb -> ${P}.deb"
KEYWORDS="~amd64"

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	insinto etc/
	doins "${S}/etc/kaiengine.conf"

	dosbin "${S}/usr/sbin/kaiengine"
}
