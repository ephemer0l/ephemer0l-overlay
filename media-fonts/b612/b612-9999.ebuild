# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font git-r3

DESCRIPTION="font family designed and tested to be used on aircraft cockpit screens"
HOMEPAGE="http://b612-font.com"

EGIT_REPO_URI="git://git.polarsys.org/gitroot/b612/b612.git"

KEYWORDS=""

LICENSE="EPL"
SLOT="0"

FONT_SUFFEX="ttf"

S="${WORKDIR}/${P}/"
