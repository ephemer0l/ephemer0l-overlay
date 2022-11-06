# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="GTK based graphical interface compatible with Modem manager"
HOMEPAGE="https://sourceforge.net/projects/modem-manager-gui/"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${P}.tar.gz/download -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="spell"
KEYWORDS="~amd64 ~x86"

DEPEND="
	net-misc/modemmanager
	x11-libs/gtk+
	dev-libs/glib
	sys-libs/gdbm
	app-text/po4a
	dev-util/itstool
	spell? ( app-text/gtkspell:3= )
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}/"

src_configure() {
	./configure || die
}

src_compile() {
	make || die
}

#src_install() {
#	doman "${S}"/man/<lang>/modem-manager-gui.1
#	dodoc AUTHORS Changelog
#}
