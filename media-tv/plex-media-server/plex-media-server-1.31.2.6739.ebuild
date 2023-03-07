# Copyright 1999-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=8

inherit multiprocessing readme.gentoo-r1 systemd unpacker

DBREPAIR_VERSION="0.6.5"
MY_PV="${PV}-a87e876bd"
MY_URI="https://downloads.plex.tv/plex-media-server-new"
DBR_URI="https://github.com/ChuckPa/PlexDBRepair/archive/refs/tags"
DBR_SHORT=""${DBR_URI}"/v"${DBREPAIR_VERSION}".tar.gz"

DESCRIPTION="Free media library that is intended for use with a plex client"
HOMEPAGE="https://www.plex.tv/"
SRC_URI="
	amd64? ( "${MY_URI}/${MY_PV}"/debian/plexmediaserver_"${MY_PV}"_amd64.deb )
	x86? ( "${MY_URI}/${MY_PV}"/debian/plexmediaserver_"${MY_PV}"_i386.deb )
	"${DBR_SHORT}" -> PlexDBRepair-"${DBREPAIR_VERSION}".tar.gz"
S="${WORKDIR}"

LICENSE="Plex"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist mirror" # public releases can drop mirror per bug #600696
IUSE="experimental"

DEPEND="
	acct-group/plex
	acct-user/plex"
RDEPEND="${DEPEND}"
#	media-video/plex-ffmpeg"

QA_PREBUILT="*"
QA_MULTILIB_PATHS=(
	"usr/lib/plexmediaserver/.*"
	"usr/lib/plexmediaserver/lib/.*"
	"usr/lib/plexmediaserver/Resources/Python/lib/python2.7/.*"
	"usr/lib/plexmediaserver/Resources/Python/lib/python2.7/lib-dynload/_hashlib.so"
)

_CPU_CORES="export PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="
_CONFIG_FILE="${S}/usr/lib/plexmediaserver/lib/plexmediaserver.default"

src_prepare() {
	eapply_user

	# Set Plugin threads from MAKEOPTS
	sed -i -e 's/#"${_CPU_CORES}".*/"${_CPU_CORES}"'$(makeopts_jobs)'/g' "${_CONFIG_FILE}" || die

	# Get MAKEOPTS and add job number for threading comskip
	sed -i '/^thread_count=/{h;s/=.*/='$(makeopts_jobs)'/};${x;/^$/{s//thread_count='$(makeopts_jobs)'/;H};x}' \
		"${S}"/usr/lib/plexmediaserver/Resources/comskip.ini || die

	if USE experimental; then
		# increse sql cache size to speed up DB
		sed -i -e "'s/cache_size=2000/cache_size=8192/' '${S}/usr/lib/plexmediaserver/Plex Media Server'" || die
	fi
}

src_install() {
	# Remove Debian specific files
	rm -r "usr/share/doc" || die

	# Remove shipped Plex Transcoder for source based replacement
#	rm usr/lib/plexmediaserver/lib/libswscale.so.5
#	rm usr/lib/plexmediaserver/lib/libavfilter.so.7
#	rm usr/lib/plexmediaserver/lib/libavcodec.so.58
#	rm usr/lib/plexmediaserver/lib/libswresample.so.3
#	rm usr/lib/plexmediaserver/lib/libavformat.so.58
#	rm usr/lib/plexmediaserver/lib/libavutil.so.56

	# Copy main files over to image and preserve permissions so it is portable
	cp -rp usr/ "${ED}" || die

	# Add user config file
	mkdir -p "${ED}/etc/default" || die
	cp usr/lib/plexmediaserver/lib/plexmediaserver.default "${ED}"/etc/default/plexmediaserver || die

	keepdir /var/lib/plexmediaserver
	fowners plex:plex /var/lib/plexmediaserver

	newinitd usr/lib/plexmediaserver/lib/plexmediaserver.init "${PN}"

	systemd_dounit "${ED}"/usr/lib/plexmediaserver/lib/plexmediaserver.service
	keepdir /var/lib/plexmediaserver

	# Adds the precompiled plex libraries to the revdep-rebuild's mask list
	# so it doesn't try to rebuild libraries that can't be rebuilt.
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/80plexmediaserver

	if USE experimental; then
		dosbin "${WORKDIR}"/PlexDBRepair-"${DBREPAIR_VERSION}"/DBRepair.sh
		dodoc "${WORKDIR}"/PlexDBRepair-"${DBREPAIR_VERSION}"/README.md
	fi

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog

	if USE experimental; then
		elog "If updating from a version prior to 1.29.1.6276, there was some \
			DB changes made with the 'experamental' use flag enabled,"
		elog "you need to run the following manualy as your plex user ( #su - plex -s /bin/bash )"
		elog "to update	plex databases for the new larger cache size for improved performance."
		elog "Plex service needs to be stopped before running the folowing:"

		elog '/usr/lib/plexmediaserver/Plex\ SQLite /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/com.plexapp.plugins.library.db "PRAGMA page_size=65536" "PRAGMA journal_mode=DELETE" "VACUUM" "PRAGMA journal_mode=WAL" "PRAGMA optimize"'

		elog '/usr/lib/plexmediaserver/Plex\ SQLite /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/com.plexapp.plugins.library.blobs.db "PRAGMA page_size=65536" "PRAGMA journal_mode=DELETE" "VACUUM" "PRAGMA journal_mode=WAL" "PRAGMA optimize"'

		elog 'There is a DB repair script installed in "/usr/sbin/DBRepair.sh".'
		elog 'Run it as root user to fix any database issues.'
		elog 'This is an experamental script from upstream.'
	fi
}
