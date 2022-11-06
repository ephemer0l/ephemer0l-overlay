# Copyright 1999-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=8

DESCRIPTION="A multitalented APRS / DPRS / APRSIS "i-gate" For Amature Radio"
HOMEPAGE="http://wiki.ham.fi/Aprx.en"

EGIT_MIRROR_URI="https://github.com/PhirePhly/aprx/releases"
EGIT_REPO_URI="https://github.com/PhirePhly/aprx.git"
EGIT_CLONE_TYPE="mirror"

#inherit subversion multilib
inherit multilib git-r3

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
