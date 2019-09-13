# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools eutils

DESCRIPTION="Free mpeg commercial detector"
HOMEPAGE="http://www.kaashoek.com/comskip/"

_GIT_USER="erikkaashoek"
_GIT_COMMIT="14dffb2"
_MY_LONG_COMMIT="14dffb241fac0126e261d4ff5bf929479e2592b6"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${_GIT_USER}-${PN}-${_GIT_COMMIT}
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug donator gui static-libs"

DEPEND="media-video/ffmpeg
	dev-libs/argtable
	gui? ( media-libs/libsdl )"

src_prepare() {
	default
	sed -e "s#-g\ -O2#${CFLAGS}#" -i "${S}"/Makefile.am || die "sed on Makefile.am failed!"
	sed -e "s#0.81.098#${PV}#" -i "${S}"/configure.ac || die "sed on configure.ac failed!"
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}" econf \
		$(use_enable debug) \
		$(use_enable donator) \
		$(use_enable gui) \
		$(use_enable static-libs static)
}

src_compile() {
	emake || die "Make failed!"
}
