# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="UNIX client interface to the Winlink 2000 ham radio email system"
HOMEPAGE="https://sourceforge.net/projects/paclink-unix/"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${PN}/${P}/${P}.tar.gz/download -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="mail-mta/sendmail
	sys-libs/db:*
	dev-libs/glib
	dev-libs/gmime:2.6
	media-radio/ax25-tools"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/${P}-fix-install-path.patch" )

src_configure() {
	./configure
}

src_compile() {
	make
}

src_install() {
	cp "${S}/wl2k.conf.dist ${S}/wl2k.conf"
	insinto /etc
	doins "${S}/wl2k.conf"

	dobin "${S}/lzhuf_1"
	dobin "${S}/wl2kax25"
	dobin "${S}/wl2kax25d"
	dobin "${S}/wl2kserial"
	dobin "${S}/wl2ktelnet"

	insinto /usr/share/sendmail-cf/m4
	doins	"${S}/wl2k.m4"

	insinto /usr/libexec
	doins	"${S}/mail.wl2k"

	doman "${S}/doc/*"

	dodoc AUTHORS NEWS README
}
