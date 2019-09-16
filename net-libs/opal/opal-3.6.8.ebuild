# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools eutils flag-o-matic java-pkg-opt-2 toolchain-funcs

HTMLV="3.6.7" # There is no 3.6.8 release of htmldoc
DESCRIPTION="C++ class library normalising numerous telephony protocols"
HOMEPAGE="http://www.opalvoip.org/"

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.code.sf.net/p/opalvoip/opal"
elif [[ "${PV}" = "0_p20190904" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.code.sf.net/p/opalvoip/opal"
	EGIT_COMMIT="570c3d37ea757c7171fda4cf2eda77968a5bee97"
else
	SRC_URI="mirror://sourceforge/opalvoip/${P}.tar.bz2
	doc? ( mirror://sourceforge/opalvoip/${PN}-${HTMLV}-htmldoc.tar.bz2 )"
fi

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="+audio capi celt debug doc dtmf examples fax ffmpeg h224 h281 h323 iax
ilbc ipv6 ivr ixj java ldap lid +plugins sbc sip sipim srtp ssl static-libs
stats swig theora +video vpb vxml wav x264 x264-static xml"

REQUIRED_USE="x264-static? ( x264 )
	h281? ( h224 )"

RDEPEND="<net-libs/ptlib-2.10.8[stun,debug=,audio?,dtmf?,ipv6?,ldap?,ssl?,video?,vxml?,wav?,xml?]
	>=media-libs/speex-1.2_beta
	fax? ( net-libs/ptlib[asn] )
	h323? ( net-libs/ptlib[asn] )
	ivr? ( net-libs/ptlib[http,xml,vxml] )
	java? ( >=virtual/jre-1.4 )
	plugins? (
		media-sound/gsm
		capi? ( net-dialup/capi4k-utils )
		celt? ( media-libs/celt )
		ffmpeg? ( virtual/ffmpeg[encode] !!>=media-libs/libav-9 )
		ixj? ( sys-kernel/linux-headers )
		ilbc? ( dev-libs/ilbc-rfc3951 )
		sbc? ( media-libs/libsamplerate )
		theora? ( media-libs/libtheora )
		x264? (	virtual/ffmpeg
			media-libs/x264 ) )
	srtp? ( net-libs/libsrtp )
	vxml? ( net-libs/ptlib[http,vxml] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gcc-3
	java? ( swig? ( dev-lang/swig )
		>=virtual/jdk-1.4 )"

# NOTES:
# ffmpeg[encode] is for h263 and mpeg4
# ssl, xml, vxml, ipv6, dtmf, ldap, audio, wav, and video are use flags
#   herited from ptlib: feature is enabled if ptlib has enabled it
#   however, disabling it if ptlib has it looks hard (coz of buildopts.h)
#   forcing ptlib to disable it for opal is not a solution too
#   atm, accepting the "auto-feature" looks like a good solution
#   (asn is used for fax and config _only_ for examples)
# OPALDIR should not be used anymore but if a package still need it, create it

pkg_setup() {
	# workaround for bug 282838
	append-flags "-fno-visibility-inlines-hidden"

	# Upstream fixed this in trunk
	# http://opalvoip.svn.sourceforge.net/viewvc/opalvoip?view=revision&revision=25165
	append-flags -D__STDC_CONSTANT_MACROS #324323

	# need >=gcc-3
	if [[ $(gcc-major-version) -lt 3 ]]; then
		eerror "You need to use gcc-3 at least."
		eerror "Please change gcc version with 'gcc-config'."
		die "You need to use gcc-3 at least."
	fi

	java-pkg-opt-2_pkg_setup
}

src_prepare() {
	# remove visual studio related files from samples/
	if use examples; then
		rm -f samples/*/*.vcproj
		rm -f samples/*/*.sln
		rm -f samples/*/*.dsp
		rm -f samples/*/*.dsw
	fi

	# upstream patch 2808915
	epatch "${FILESDIR}"/${PN}-3.6.4-jdkroot.patch

	epatch "${FILESDIR}"/${P}-build-fix.patch #343041
	epatch "${FILESDIR}"/${P}-ldflags.patch
	epatch "${FILESDIR}"/${P}-lid-plugins-ldflags.patch #397681

	# h224 really needs h323 ?
	# TODO: get a confirmation in ml
	sed -i -e "s:\(.*HAS_H224.*\), \[OPAL_H323\]:\1:" configure.ac \
		|| die "sed failed"

	eaclocal
	eautoconf

	# in plugins
	cd plugins/
	eaclocal
	eautoconf
	cd ..

	# disable srtp if srtp is not enabled (prevent auto magic dep)
	# upstream bug 2686485 (fixed in 3.7)
	if ! use srtp; then
		sed -i -e "s/OPAL_SRTP=yes/OPAL_SRTP=no/" configure \
			|| die "patching configure failed"
	fi

	# disable theora if theora is not enabled (prevent auto magic dep)
	# upstream bug 2686488 (fixed in 3.7)
	if ! use theora; then
		sed -i -e "s/HAVE_THEORA=yes/HAVE_THEORA=no/" plugins/configure \
			|| die "patching plugins/configure failed"
	fi

	# disable mpeg4 and h263p if ffmpeg is not enabled (prevent auto magic dep)
	# upstream bug 2686495 (fixed in 3.7)
	if ! use ffmpeg; then
		sed -i -e "s/HAVE_H263P=yes/HAVE_H263P=no/" plugins/configure \
			|| die "patching plugins/configure failed"
		sed -i -e "s/HAVE_MPEG4=yes/HAVE_MPEG4=no/" plugins/configure \
			|| die "patching plugins/configure failed"
	fi

	# disable celt if celt is not enabled (prevent auto magic dep)
	# already in repository
	if ! use celt; then
		sed -i -e "s/HAVE_CELT=yes/HAVE_CELT=no/" plugins/configure \
			|| die "sed failed"
	fi

	# fix gsm wav49 support check, upstream bug 2686500 (fixed in 3.7)
	if use plugins; then
		sed -i -e "s:gsm\.h:gsm/gsm.h:" plugins/configure \
			|| die "patching plugins/configure failed"
	fi

	# fix automatic swig detection, upstream bug 2712521 (upstream reject it)
	if ! use swig; then
		sed -i -e "/^SWIG=/d" configure || die "patching configure failed"
	fi

	use ilbc || { rm -r plugins/audio/iLBC/ || die "removing iLBC failed"; }

	java-pkg-opt-2_src_prepare
}

src_configure() {
	local forcedconf=""

	# fix bug 277233, upstream bug 2820939
	if use fax; then
		forcedconf="${forcedconf} --enable-statistics"
	fi

	# --with-libavcodec-source-dir should _not_ be set, it's for trunk sources
	# versioncheck: check for ptlib version
	# shared: should always be enabled for a lib
	# localspeex, localspeexdsp, localgsm, localilbc: never use bundled libs
	# samples: only build some samples, useless
	# libavcodec-stackalign-hack: prevent hack (default disable by upstream)
	# default-to-full-capabilties: default enable by upstream
	# aec: atm, only used when bundled speex, so it's painless for us
	# zrtp doesn't depend on net-libs/libzrtpcpp but on libzrtp from
	# 	http://zfoneproject.com/ wich is not in portage
	# msrp: highly experimental
	# spandsp: doesn't work with newest spandsp, upstream bug 2796047
	# g711plc: force enable
	# rfc4103: not really used, upstream bug 2795831
	# t38, spandsp: merged in fax
	# h450, h460, h501: merged in h323 (they are additional features of h323)
	econf \
		--enable-versioncheck \
		--enable-shared \
		--disable-zrtp \
		--disable-localspeex \
		--disable-localspeexdsp \
		--disable-localgsm \
		--disable-localilbc \
		--disable-samples \
		--disable-libavcodec-stackalign-hack \
		--enable-default-to-full-capabilties \
		--enable-aec \
		--disable-msrp \
		--disable-spandsp \
		--enable-g711plc \
		--enable-rfc4103 \
		$(use_enable debug) \
		$(use_enable capi) \
		$(use_enable fax) \
		$(use_enable fax t38) \
		$(use_enable h224) \
		$(use_enable h281) \
		$(use_enable h323) \
		$(use_enable h323 h450) \
		$(use_enable h323 h460) \
		$(use_enable h323 h501) \
		$(use_enable iax) \
		$(use_enable ivr) \
		$(use_enable ixj) \
		$(use_enable java) \
		$(use_enable lid) \
		$(use_enable plugins) \
		$(use_enable sbc) \
		$(use_enable sip) \
		$(use_enable sipim) \
		$(use_enable stats statistics) \
		$(use_enable video) $(use_enable video rfc4175) \
		$(use_enable vpb) \
		$(use_enable x264 h264) \
		$(use_enable x264-static x264-link-static) \
		${forcedconf}
}

src_compile() {
	local makeopts=""

	use debug && makeopts="debug"

	emake ${makeopts} || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# Get rid of static libraries if not requested
	# There seems to be no easy way to disable this in the build system
	if ! use static-libs; then
		rm -v "${D}"/usr/lib*/*.a || die
	fi

	if use doc; then
		dohtml -r "${WORKDIR}"/html/* docs/* || die "dohtml failed"
	fi

	# ChangeLog is not standard
	dodoc ChangeLog-${PN}-v${PV//./_}.txt || die "dodoc failed"

	if use examples; then
		local exampledir="/usr/share/doc/${PF}/examples"
		local basedir="samples"
		local sampledirs="`ls ${basedir} --hide=configure* \
			--hide=opal_samples.mak.in`"

		# first, install files
		insinto ${exampledir}/
		doins ${basedir}/{configure*,opal_samples*} \
			|| die "doins failed"

		# now, all examples
		for x in ${sampledirs}; do
			insinto ${exampledir}/${x}/
			doins ${basedir}/${x}/* || die "doins failed"
		done

		# some examples need version.h
		insinto "/usr/share/doc/${PF}/"
		doins version.h || die "doins failed"
	fi
}

pkg_postinst() {
	if use examples; then
		ewarn "All examples have been installed, some of them will not work on your system"
		ewarn "it will depend of the enabled USE flags in ptlib and opal"
	fi

	if ! use plugins || ! use audio || ! use video; then
		ewarn "You have disabled audio, video or plugins USE flags."
		ewarn "Most audio/video features or plugins have been disabled silently"
		ewarn "even if enabled via USE flags."
		ewarn "Having a feature enabled via USE flag but disabled can lead to issues."
	fi
}
