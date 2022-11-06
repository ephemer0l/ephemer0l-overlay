# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Library and applications to access GSM mobile phones"
HOMEPAGE="http://www.pxh.de/fs/gsmlib/"

EGIT_REPO_URI="https://github.com/vbouchaud/gsmlib.git"
EGIT_COMMIT="cd5442de07cfe052316ede58640ef81b20627276"

IUSE=""
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="amd64 ~ia64 ppc ppc64 sparc x86"

RESTRICT="test"

PATCHES=""${FILESDIR}/${P%_pre*}-include-gcc34-fix.patch"
	"${FILESDIR}/${P%_pre*}-gcc41.patch"
	"${FILESDIR}/${P%_pre*}-gcc43.patch""

S="${WORKDIR}/${PN}-${PV%_pre*}"

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
