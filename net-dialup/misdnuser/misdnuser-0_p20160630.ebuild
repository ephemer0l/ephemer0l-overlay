# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

IUSE="+capi static-libs"

inherit eutils autotools

DESCRIPTION="mISDN (modular ISDN) kernel link library and includes"
HOMEPAGE="http://www.mISDN.org/"

EGIT_REPO_URI="git://git.misdn.eu/mISDNuser.git"
EGIT_COMMIT="a29326031eb1198b8609b4bc378afffaa4d86446"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sys-libs/ncurses:0
	capi? ( >=net-dialup/capi4k-utils-3.2.0
		!!>=net-dialup/capi4k-utils-20050718
		>=media-libs/spandsp-0.0.6_pre12 )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/mISDNuser"

PATCHES=( "${FILESDIR}/${P}-udev-rulesd.patch" )
DOCS=( "AUTHORS" "COPYING.LIB" "LICENSE" "NEWS" "README" )

src_configure() {
	eautoreconf
	# install example applications too, contains some useful stuff like misdntestlayer1
	econf \
		$(use_enable capi) \
		$(use_enable static-libs static) \
		--with-mISDN_group=dialout \
		--enable-example || die "econf failed"
}

src_install() {
	base_src_install

	use capi && \
		newinitd "${FILESDIR}/mISDNcapid.initd" mISDNcapid

	if ! use static-libs ; then
		# remove all .la files
		find "${D}" -name "*.la" -delete
	elif use capi ; then
		# remove capi plugin .la files
		find "${D}/usr/$(get_libdir)/capi/" -name "*.la" -delete
	fi

}
