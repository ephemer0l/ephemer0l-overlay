# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the NWA General License

EAPI=7

inherit autotools eutils git-r3

DESCRIPTION="Free mpeg commercial detector"
HOMEPAGE="http://www.kaashoek.com/comskip/"

EGIT_COMMIT="755249b8ab615909919d9a107dfb479a48623a72"
EGIT_REPO_URI="https://github.com/erikkaashoek/${PN}.git"
EGIT_BRANCH="master"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug donator gui static-libs"

DEPEND="media-video/ffmpeg
	dev-libs/argtable
	gui? ( media-libs/libsdl )"

src_prepare() {
	default
	sed -e "s#-g\ -O2#${CFLAGS}#" -i "${S}"/Makefile.am || die "sed on Makefile.am failed!"
	sed -e "s#0.81.098#${EGIT_COMMIT}#" -i "${S}"/configure.ac || die "sed on configure.ac failed!"
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
