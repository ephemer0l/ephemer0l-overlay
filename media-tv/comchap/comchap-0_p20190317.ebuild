# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Commercial detection script and add chapters"
HOMEPAGE="https://github.com/BrettSheleski/comchap"

_GIT_USER="BrettSheleski"
_GIT_COMMIT="bc03ed0"
_MY_LONG_COMMIT="bc03ed03d47ac5b29b6c65d4b698dc7865809d49"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

S="${WORKDIR}/${_GIT_USER}-${PN}-${_GIT_COMMIT}"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="media-tv/Comskip
	${DEPEND}"

src_install() {
	insinto	/usr/bin
	doins  -r comchap
	doins -r comcut
	dodoc README.md usage.txt
}
