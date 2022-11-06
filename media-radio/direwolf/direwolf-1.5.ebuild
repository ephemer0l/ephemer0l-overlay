# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Software "soundcard" modem/TNC and APRS encoder/decoder."
HOMEPAGE="https://github.com/wb2osz/direwolf"

_GIT_USER="wb2osz"
_MY_COMMIT="a1e2d1c"
_MY_LONG_COMMIT="a1e2d1c3a88723e41efaf44a10f6374e6dfdd8df"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
