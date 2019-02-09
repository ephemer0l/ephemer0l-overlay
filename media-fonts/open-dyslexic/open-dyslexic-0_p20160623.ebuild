# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

DESCRIPTION="opensource font for dyslexics and for high readability"
HOMEPAGE="https://github.com/antijingoist/open-dyslexic"

_GIT_USER="antijingoist"
_MY_COMMIT=03aa683
_MY_LONG_COMMIT=03aa68333abaef14718091a46bff52794b34cf39


if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/open-dyslexic.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BitstreamCyberbit"
SLOT="0"

FONT_SUFFEX="ttf"

S="${WORKDIR}/${_GIT_USER}-${PN}-${_MY_COMMIT}/"
