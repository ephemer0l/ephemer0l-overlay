# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils toolchain-funcs

_GIT_USER="glftpd"
_MY_COMMIT="16dbffa"
_MY_LONG_COMMIT="16dbffad58343ee764c468d17b7332f2b2379e63"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="The powerful curses-based ftp/fxp client, shit edition"
HOMEPAGE="https://web.archive.org/web/20150402150211/http://www.geekspot.nl/?page_id=6"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ssl"

RDEPEND="ssl? ( dev-libs/openssl:0.9.8 )"
DEPEND="
	app-arch/unzip
	${RDEPEND}"

S=${WORKDIR}/${MY_P}/trunk-vanilla/

src_prepare() {
	epatch "$FILESDIR/1.11-gcc43.patch"

	# do no strip
	# look for the correct library (bug #408231)
	sed \
		-e 's|[^D]*DO.*||g' \
		-e 's|libssl.a|libssl.so|g' \
		-e 's:-O2::g' \
		-e 's:-g::g' \
		-i configure || die

	#fix permissions of configure script
	chmod +x configure

	# use CXX not CPP
	# respect LDFLAGS
	sed \
		-e 's/CPP/CXX/g' \
		-e 's|$(CXX) -o |$(CXX) $(GENTOO_LDFLAGS) -o |g' \
		-i src/Makefile.in || die
}

src_configure() {
	#note: not a proper autoconf
	./configure $(use ssl || echo --nossl) || die "configure failed"
	sed -i -e 's:$<:$(CPPFLAGS) $<:' -e 's/LINKFLAGS/LDFLAGS/g'  src/Makefile || die
}

src_compile() {
	emake GENTOO_LDFLAGS="${LDFLAGS}" CXX=$(tc-getCXX)
}

src_install() {
	dobin pftp
	dodoc .pftp/config .pftp/keymap README.MEW old/*
}

pkg_postinst() {
	einfo "In order to use pftp-shit you need to create these files:"
	einfo "    ~/.pftp/config"
	einfo "    ~/.pftp/keymap"
	einfo "Refer to the examples in /usr/share/doc/${PF} for more information."
}
