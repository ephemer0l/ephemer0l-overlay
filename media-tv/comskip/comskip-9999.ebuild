# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils

DESCRIPTION="Free mpeg commercial detector"
HOMEPAGE="http://www.kaashoek.com/comskip/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/erikkaashoek/Comskip.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/erikkaashoek/Comskip/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE=""
SLOT="0"
IUSE="debug donator gui static-libs"

DEPEND="media-video/ffmpeg
	dev-libs/argtable
	gui? ( media-libs/libsdl )"

S="${WORKDIR}"/"${P}"

src_prepare() {
	default
	sed -e "s#-g\ -O2#${CFLAGS}#" -i "${S}"/Makefile.am || die "sed on Makefile.am failed!"
	sed -e "s#0.81.098#${PV}#" -i "${S}"/configure.ac || die "sed on configure.ac failed!"
#	epatch "${FILESDIR}"/custom_cflags.patch
#	epatch "${FILESDIR}"/fix_version.patch
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
