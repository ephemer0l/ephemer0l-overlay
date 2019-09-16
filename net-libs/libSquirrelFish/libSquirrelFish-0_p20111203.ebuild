# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This ebuild is from freeswitch overlay; Bumped by mva; 
# Distributed under the terms of the GNU General Public License 2
# see http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt for
# more information
#

EAPI="7"

inherit autotools

DESCRIPTION="Stand-alone version of the WebKit JavaScript engine"
HOMEPAGE="http://oss.axsentis.de/"

if [[ "${PV}" = "9999" ]]; then
	inherit git-2
	EGIT_REPO_URI="https://oss.axsentis.de/git/libSquirrelFish.git"
elif [[ "${PV}" = "0_p*" ]]; then
	inherit git-2
	EGIT_REPO_URI="https://oss.axsentis.de/git/libSquirrelFish.git"
	EGIT_COMMIT="839eadf406d3b3a75e40a6b5d5088e47007ae27c"
else
	SRC_URI=""
fi

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="virtual/libc
	dev-libs/icu"

DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	dev-lang/perl"

S="${WORKDIR}/${PN}"

src_unpack() {
	if [[ "${PV}" = "9999" ]]; then
		git-2_src_unpack
	else
		default_src_unpack
	fi
}

src_configure() {
	# eautoreconf doesn't work here,
	# aclocal dies with a circular dependency error
	AT_M4DIR="Source/autotools" eautoreconf
}

src_compile() {
	emake DESTDIR="${D}" install || die "make install failed"
}

src_install() {
	# install docs
	dodoc Source/JavaScriptCore/{COPYING.LIB,AUTHORS,THANKS}
}
