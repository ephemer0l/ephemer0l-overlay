# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="Multiplatform library for linking to Asterisk PBX servers"
HOMEPAGE="https://sourceforge.net/projects/iaxclient/"
LICENSE="GPL-2 LGPL-2"

# I dont know how to use versionator...
#MY_PV=""${ver_get_version_components 1 2}"beta"${ver_get_version_components 3}""
#MY_PN=""${PN}"/files/"${PN}"/"${MY_PV}}/"${PN}"-"${MY_PV}"
SRC_URI="https://sourceforge.net/projects/iaxclient/files/iaxclient/2.1beta3/iaxclient-2.1beta3.tar.gz/download -> "${P}".tar.gz"
#SRC_URI="https://sourceforge.net/projects/"${MY_PN}".tar.gz/download -> "${P}".tar.gz"

SLOT="0"
KEYWORDS="~arm ~x86"
IUSE="ogg theora"

RESTRICT="mirror"  # libgsm is included in tarball

DEPEND='
	>=media-libs/portaudio-19_alpha0
	media-sound/gsm
	>=media-libs/speex-1.2_alpha0
	ogg? ( >=media-libs/libogg-1.1.3 )
	theora? ( >=media-libs/libtheora-1.0_alpha7 )
	media-video/ffmpeg
'
# NOTE: bundled libiax2 is FORKED :<
# NOTE: for some reason, ffmpeg isn't really optional
# TODO: ilbc, oggz, vidcap(last dep required for video)
RDEPEND="${DEPEND} "'
'

S="${WORKDIR}/${MyP}"

PATCHES="${FILESDIR}/${MyPN}-lib-only.patch"

src_unpack() {
	unpack ${A}
}

src_prepare() {
	sed -i 's:ffmpeg/:libavcodec/:' lib/codec_ffmpeg.c
}

src_configure() {
	eautoreconf
	append-flags -I/usr/include/iax
	econf \
		--disable-video \
		$(use_with ogg) \
		$(use_with theora) \
		--disable-clients \
		|| die 'econf failed'
}

src_compile() {
	emake || die 'emake failed'
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
}
