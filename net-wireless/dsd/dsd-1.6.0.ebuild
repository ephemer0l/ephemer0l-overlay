# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Digital Speech Decoder"
HOMEPAGE="https://github.com/szechyjs/dsd"
LICENSE="BSD"
SLOT="0"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/szechyjs/dsd.git"
	KEYWORDS=""
	inherit git-r3
	DEPEND="=media-libs/mbelib-9999"

else
	SRC_URI="https://github.com/szechyjs/dsd/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="${DEPEND}
	>=sci-libs/itpp-4.3.1
	media-libs/libsndfile
	sci-libs/fftw:3.0
"

src_prepare() {
	sed -i \
		-e "s#DEST_BASE=/usr/local#DEST_BASE=${ED}/usr/#" \
		-e "s#CFLAGS =#CFLAGS ?=#" \
		-e 's#$(CFLAGS)#$(CFLAGS) $(LDFLAGS)#' \
		-e '#CFLAGS ?=#a LDFLAGS?=#' \
		Makefile
}

src_install() {
	dodir /usr/bin
	default
}
