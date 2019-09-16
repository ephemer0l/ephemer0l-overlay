# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_REVISION="rev767"

DESCRIPTION="Gaming network-bringing together XBox (360,XBox), Playstation (2,3,PSP) users"
HOMEPAGE="http://www.teamxlink.co.uk/"

SRC_URI="http://cdn.teamxlink.co.uk/binary/"${P}"-"${MY_REVISION}".headless.el6.i686.tar.gz -> "${P}".tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install () {
	dobin "${WORKDIR}"/"${P}"/kaiengine
}
