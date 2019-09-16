# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This ebuild is from freeswitch overlay; Bumped by mva; 
# Distributed under the terms of the GNU General Public License 2
# see http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt for
# more information
#

EAPI="7"

IUSE="doc lua +pcap static-libs"

if [[ "${PV}" = "9999" ]]
then
	EGIT_REPO_URI="http://git.openisdn.net/libisdn.git/"
	EGIT_BOOTSTRAP="./autogen.sh"
	KEYWORDS=""
	SCM="git-2"
elif [ "${PV}" == "0_p20120626" ]; then
	_MY_COMMIT="b0af5241564af9d0e918717260ee049d31bbc604"
	EGIT_REPO_URI="http://git.openisdn.net/libisdn.git/"
	KEYWORDS="~amd64 ~x86"
	#S=${WORKDIR}/${_GIT_USER}-${PN}-${_GIT_COMMIT}
else
	SRC_URI="http://files.openisdn.net/releases/${P}.tar.xz"
fi

inherit flag-o-matic ${SCM}

DESCRIPTION="ISDN (Q.931; PRI/BRI) protocol stack"
HOMEPAGE="http://www.openisdn.net/"

SLOT="0"

LICENSE="BSD"

DOCS=( "${S}/CREDITS" "${S}/TODO" )

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.61
	>=sys-devel/automake-1.10
	doc? ( app-doc/doxygen )
	lua? ( dev-lang/lua )
	pcap? ( >=net-libs/libpcap-1.0 )"

src_configure() {
	local myconf=""

	if [ -n "${FREETDM_SOURCE_DIR}" ]
	then
		myconf="${myconf} --with-freetdm=${FREETDM_SOURCE_DIR}"
	fi

	econf \
		$(use_with lua) \
		$(use_with pcap) \
		$(use_enable static-libs static) \
		${myconf} || die "econf failed"
}

src_compile() {
	emake || die "emake failed"

	if use doc ; then
		einfo "Building API documentation..."
		emake doxygen || die "building API docs failed"
	fi
}

src_install() {
	default_src_install

	if use doc ; then
		einfo "Installing ${PN} API documentation into \"${ROOT}usr/share/doc/${PVF}/html\""
		dohtml -r docs/html/
	fi
}
