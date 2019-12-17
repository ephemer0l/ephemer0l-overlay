# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils systemd unpacker user

DESCRIPTION="A free media library that is intended for use with a plex client"
HOMEPAGE="https://www.plex.tv/"

_COMMIT="cacaa3be8"
MY_PV="${PV}-${_COMMIT}"

#URI="https://downloads.plex.tv/plex-media-server-new"
URI="https://artifacts.plex.tv/plex-media-server-experimental/"
SRC_URI="
	amd64? ( ${URI}/${MY_PV}/debian/plexmediaserver_${MY_PV}_amd64.deb )
	x86? ( ${URI}/${MY_PV}/debian/plexmediaserver_${MY_PV}_i386.deb )"

LICENSE="PLEX"
SLOT="0"
KEYWORDS="-*"
RESTRICT="mirror bindist strip"
IUSE="custom-ffmpeg system-openssl"

RDEPEND="
	custom-ffmpeg? ( media-video/plex-ffmpeg[amr,amrenc,appkit,bluray,bs2b,bzip2,chromaprint,codec2,cpudetection,dav1d,encode,dav1d,gpl,fdk,fontconfig,frei0r,fribidi,gmp,iconv,kvazaar,ladspa,libaom,libaribb24,libass,libdrm,libilbc,librtmp,libsoxr,libv4l,libxml2,lv2,lzma,mmal,mp3,network,opengl,opus,pic,postproc,sdl,srt,static-libs,theora,threads,twolame,v4l,vaapi,vdpau,vidstab,vorbis,vpx,wavpack,webp,x264,x265,xvid,zimg,zlib,zvbi] )
	system-openssl? ( dev-libs/openssl )
	"

QA_PREBUILT="*"
QA_MULTILIB_PATHS=( "usr/lib/plexmediaserver/lib/.*"
	"usr/lib/plexmediaserver/Resources/Python/lib/python2.7/.*"
	"usr/lib/plexmediaserver/Resources/Python/lib/python2.7/lib-dynload/_hashlib.so" )

PATCHES=( "${FILESDIR}/add_gentoo_profile_as_platform_version.patch"
	"${FILESDIR}/plex-media-server-LD_CONFIG.patch" )

S="${WORKDIR}"

pkg_setup() {
	enewgroup plex
	enewuser plex -1 /bin/bash /var/lib/plexmediaserver "plex,video"
}

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	# Move the config to the correct place
	local config_vanilla="/etc/default/plexmediaserver"
	local config_path="/etc/plex"
	dodir "${config_path}"
	insinto "${config_path}"
	doins "${config_vanilla#/}"
	sed -e "s#${config_vanilla}#${config_path}/$(basename "${config_vanilla}")#g" \
		-i "${S}"/usr/sbin/start_pms || die

	# Remove Debian specific files
	rm -r "${S}/usr/share/doc" || die

	# Remove shipped openssl library
	if use system-openssl; then
		rm -f usr/lib/plexmediaserver/libssl.so.1.0.0 || die
	fi

	# Remove shipped ffmpeg
	if use custom-ffmpeg; then
#		rm "usr/lib/plexmediaserver/Plex Transcoder" || die echo "Plex Transcoder missing"
		rm "usr/lib/plexmediaserver/lib/libavfilter.so.7" || die echo "libavfilter.so.7 missing"
		rm "usr/lib/plexmediaserver/lib/libavformat.so.58" || die echo "libavformat.so.58 missing"
		rm "usr/lib/plexmediaserver/lib/libavcodec.so.58" || die echo "libavcodec.so.58 missing"
		rm "usr/lib/plexmediaserver/lib/libswresample.so.3" || die echo "libswresample.so.3 missing"
		rm "usr/lib/plexmediaserver/lib/libswscale.so.5" || die echo "libswscale.so.5 missing"
		rm "usr/lib/plexmediaserver/lib/libavutil.so.56" || die echo "libavutil.so.56 missing"
	fi


	# Copy main files over to image and preserve permissions so it is portable
	cp -rp usr/ "${ED}" || die

	# Make sure the logging directory is created
	keepdir /var/log/pms
	fowners plex:plex /var/log/pms

	keepdir /var/lib/plexmediaserver
	fowners plex:plex /var/lib/plexmediaserver

	doinitd "${FILESDIR}/init.d/${PN}"
	doconfd "${FILESDIR}/conf.d/${PN}"

	systemd_dounit "${FILESDIR}"/systemd/"${PN}".service

	keepdir /var/lib/plexmediaserver
#	echo "export LD_LIBRARY_PATH=\"${EPREFIX}/usr/lib/plexmediaserver/lib\"" \
#		> ${ED}/var/lib/plexmediaserver/.bash_profile || die

	# Adds the precompiled plex libraries to the revdep-rebuild's mask list
	# so it doesn't try to rebuild libraries that can't be rebuilt.
	dodir /etc/revdep-rebuild
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/etc/revdep-rebuild/80plexmediaserver

	#fix-gnustack -f "${ED%/}/usr/lib/plexmediaserver/lib/libgnsdk_dsp.so.3.10.1" || die

	pax-mark m "${ED%/}/usr/lib/plexmediaserver/Plex Script Host" || die
#	pax-mark m "${ED%/}/usr/lib/plexmediaserver/Plex Media Scanner" || die
}

pkg_postinst() {
	einfo ""
	elog "Plex Media Server is now installed. Please check the configuration file"
	elog "it can be found in /etc/plex/plexmediaserver to verify the default settings."
	elog "To start the Plex Server, run 'rc-config start plex-media-server'"
	elog "You will then be able to access your library at http://localhost:32400/manage"
}