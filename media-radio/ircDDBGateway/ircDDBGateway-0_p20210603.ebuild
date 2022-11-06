# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="The ircDDB Gateway for D-Star"
HOMEPAGE="https://github.com/g4klx/ircDDBGateway"
EGIT_REPO_URI="https://github.com/g4klx/ircDDBGateway.git"
EGIT_COMMIT="380c0941e7724a320ce66dcd78ef4292c5943c17"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="x11-libs/wxGTK"
