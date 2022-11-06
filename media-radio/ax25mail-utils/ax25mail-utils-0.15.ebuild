# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="A set of utilities for packet radio mail exchange with the BBS"
HOMEPAGE="https://sourceforge.net/projects/ax25mail/"
SRC_URI="https://sourceforge.net/projects/ax25mail/files/${PN}/${PV}/${PN}-${PV}.tar.gz/download -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="media-radio/ax25-tools"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=( "${FILESDIR}/${P}-fix-paths.patch" )

#S=${WORKDIR}/linpac-${PV}/

src_configure() {
#	filter-flags -flto=* -floop-nest-optimize -fgraphite-identity
	./configure
}

src_compile() {
#	filter-flags -flto -floop-nest-optimize
	make
#	rm -r "${S}"/contrib/packaging/ || die
}

#src_install() {
#	cp "${S}/wl2k.conf.dist ${S}/wl2k.conf"
#	insinto /etc/ax25
#	doins "${S}/etc/ax25/*"

#	dobin "${S}/msgcleanup"
#	dobin "${S}/axgetmsg"
#	dobin "${S}/axgetmail"
#	dobin "${S}/axgetlist"
#	dobin "${S}/update_routes"
#	dobin "${S}/home_bbs"
#	dobin "${S}/ulistd"

#	insinto /usr/share/sendmail-cf/m4
#	doins	"${S}/wl2k.m4"

#	insinto /usr/libexec
#	doins	"${S}/mail.wl2k"

#	doman "${S}/man/*"

#	dodoc BUGS NEWS README ChangeLog
#}
