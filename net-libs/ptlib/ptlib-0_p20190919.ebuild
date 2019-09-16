# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Network focused portable C++ class library providing high level functions"
HOMEPAGE="http://www.opalvoip.org/"

EGIT_REPO="https://sourceforge.net/p/opalvoip/ptlib/ci/master/tree/"
EGIT_COMMIT="ff50e6db5f3f08e7b6dd95d8bb926a99a2b29666"
#SRC_URI="mirror://sourceforge/opalvoip/${P}.tar.bz2
#	doc? ( mirror://sourceforge/opalvoip/${P}-htmldoc.tar.bz2 )"

LICENSE="MPL-1.0"
SLOT="0/${PV}"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
# default enabled are features from 'minsize', the most used according to ptlib
IUSE="alsa +asn +audio debug doc +dtmf examples ffmpeg ftp +http ipv6
jabber ldap lua mail odbc oss pulseaudio remote sasl sdl serial
shmvideo snmp soap socks ssl static-libs +stun telnet tts v4l +video
vxml wav xml xmlrpc"

CDEPEND="
	audio? ( alsa? ( media-libs/alsa-lib ) )
	ldap? ( net-nds/openldap )
	lua? ( dev-lang/lua:* )
	odbc? ( dev-db/unixODBC )
	pulseaudio? ( media-sound/pulseaudio )
	sasl? ( dev-libs/cyrus-sasl:2 )
	sdl? ( media-libs/libsdl )
	ssl? ( dev-libs/openssl )
	video? ( v4l? ( media-libs/libv4l ) )
	xml? ( dev-libs/expat )
	!!dev-libs/pwlib"
RDEPEND="${CDEPEND}
	ffmpeg? ( virtual/ffmpeg )"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	sys-devel/bison
	sys-devel/flex
	video? ( v4l? ( sys-kernel/linux-headers ) )"

# NOTES:
# media-libs/libdc1394:2 should be supported but headers location have changed
# tools/ directory is ignored
# avc plugin is disabled to fix bug 276514, see upstream bug 2821744

REQUIRED_USE="sdl? ( video )
	jabber? ( xml )
	vxml? ( http tts xml )
	xmlrpc? ( http xml )
	soap? ( http xml )"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.10.9-svn_revision_override.patch"

	if ! use telnet; then
		epatch "${FILESDIR}/${PN}-2.10.9-disable-telnet-symbols.patch"
	fi

	# remove visual studio related files from samples/
	if use examples; then
		rm -f samples/*/*.vcproj
		rm -f samples/*/*.sln
		rm -f samples/*/*.dsp
		rm -f samples/*/*.dsw
	fi

	if [[ ! -z ${TARGET+set} ]]; then
		ewarn "TARGET variable is set. Removing as it would break the build, bug #465722."
		unset TARGET
	fi
}

src_configure() {
	local myconf=""

	# plugins are disabled only if ! audio and ! video
	if ! use audio && ! use video; then
		myconf+=" --disable-plugins"
	else
		myconf+=" --enable-plugins"
	fi

	# minsize: presets of features (overwritten by use flags)
	# atomicity: there is no reason to disable this feature
	# internalregex: we want to use system one
	# sunaudio and bsdvideo are respectively for SunOS and BSD's
	# appshare, vfw: only for windows
	# samples: no need to build samples
	# avc: disabled, bug 276514, upstream bug 2821744
	# mlib: SUN mediaLibs. Not in tree.
	# pipechan, configfile, resolver, url: force enabling
	econf ${myconf} \
		--disable-minsize \
		--enable-atomicity \
		--disable-internalregex \
		--disable-sunaudio \
		--disable-bsdvideo \
		--disable-appshare \
		--disable-vfw \
		--disable-samples \
		--disable-avc \
		--disable-mlib \
		--enable-configfile \
		--enable-pipechan \
		--enable-resolver \
		--enable-url \
		$(use_enable audio) \
		$(use_enable alsa) \
		$(use_enable asn) \
		$(use_enable debug exceptions) \
		$(use_enable debug memcheck) \
		$(use_enable debug tracing) \
		$(use_enable dtmf) \
		--disable-esd \
		$(use_enable ffmpeg ffvdev) \
		$(use_enable ftp) \
		$(use_enable http) \
		$(use_enable http httpforms) \
		$(use_enable http httpsvc) \
		--disable-dc \
		$(use_enable ipv6) \
		$(use_enable jabber) \
		$(use_enable ldap openldap) \
		$(use_enable lua) \
		$(use_enable mail pop3smtp) \
		$(use_enable pulseaudio pulse) \
		$(use_enable odbc) \
		$(use_enable oss) \
		$(use_enable remote remconn) \
		$(use_enable sasl) \
		$(use_enable sdl) \
		$(use_enable serial) \
		$(use_enable shmvideo) \
		$(use_enable snmp) \
		$(use_enable soap) \
		$(use_enable socks) \
		$(use_enable ssl openssl) \
		$(use_enable stun) \
		$(use_enable telnet) \
		$(use_enable tts) \
		--disable-v4l \
		$(use_enable v4l v4l2) \
		$(use_enable video) $(use_enable video vidfile) \
		$(use_enable vxml) \
		$(use_enable wav wavfile) \
		$(use_enable xml expat) \
		$(use_enable xmlrpc)
}

src_compile() {
	local makeopts="opt"
	tc-env_build

	use debug && makeopts="debug"

	emake ${makeopts}
}

src_install() {
	local makeopts=""

	use debug && makeopts="DEBUG=1"

	emake DESTDIR="${D}" ${makeopts} install

	# Get rid of static libraries if not requested
	# There seems to be no easy way to disable this in the build system
	if ! use static-libs; then
		rm -v "${D}"/usr/lib*/*.a || die
	fi

	if use doc; then
		dohtml -r "${WORKDIR}"/html/*
	fi

	dodoc History.txt ReadMe.txt

	if use examples; then
		local exampledir="/usr/share/doc/${PF}/examples"
		local basedir="samples"

		insinto ${exampledir}
		docompress -x ${exampledir}
		doins -r ${basedir}/*
	fi
}

pkg_postinst() {
	if use examples; then
		ewarn "All examples have been installed, some of them will not work on your system"
		ewarn "it will depend of the enabled USE flags."
		ewarn "To test examples, you have to run PTLIBDIR=/usr/share/ptlib make"
	fi

	if ! use audio || ! use video; then
		ewarn "You have disabled audio or video USE flags."
		ewarn "Most audio/video have been disabled silently even if enabled via USE flags."
		ewarn "Having a feature enabled via use flag but disabled can lead to issues."
	fi

	ewarn "If you've just removed pwlib to install ptlib, some packages will be broken."
	ewarn "Please use 'revdep-rebuild' from app-portage/gentoolkit to check."
	ewarn "If some packages need pwlib, consider removing ptlib and re-installing pwlib"
	ewarn "or help us to make them live together."
}
