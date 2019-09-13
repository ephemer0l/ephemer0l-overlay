# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="yEnc encoder/decoder package"
HOMEPAGE="http://www.yencode.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm arm64 ppc ppc64 ~sparc x86"
IUSE="nls"

DEPEND="${RDEPEND}"

src_configure() {
	local myconf
	use nls || myconf="--disable-nls"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"
}
src_compile() {
	emake || die
}

src_install () {
	make \
		prefix='${D}'/usr \
		mandir='${D}'/usr/share/man \
		infodir='${D}'/usr/share/info \
		install || die
	dodoc AUTHORS NEWS README ChangeLog
	doman doc/ydecode.1 doc/yencode.1 doc/ypost.1 doc/ypostrc.5
}
