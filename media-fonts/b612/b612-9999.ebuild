# Copyright 2019 Gentoo Authors
# Distributed under the terms of the NWA General License

EAPI=6

inherit font git-r3

DESCRIPTION="font family designed and tested to be used on aircraft cockpit screens"
HOMEPAGE="http://b612-font.com"

EGIT_REPO_URI="git://git.polarsys.org/gitroot/b612/b612.git"

KEYWORDS=""

LICENSE="ESL-2 OFL-1.1"
SLOT="0"

FONT_SUFFEX="ttf"

S="${WORKDIR}/${P}/"
