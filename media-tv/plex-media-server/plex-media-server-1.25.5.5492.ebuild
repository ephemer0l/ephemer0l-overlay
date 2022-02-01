# Copyright 1999-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=8

inherit readme.gentoo-r1 multiprocessing systemd unpacker

MY_PV="${PV}-12f6b8c83"
MY_URI="https://downloads.plex.tv/plex-media-server-new"

DESCRIPTION="Free media library that is intended for use with a plex client"
HOMEPAGE="https://www.plex.tv/"
SRC_URI="
	amd64? ( ${MY_URI}/${MY_PV}/debian/plexmediaserver_${MY_PV}_amd64.deb )
	x86? ( ${MY_URI}/${MY_PV}/debian/plexmediaserver_${MY_PV}_i386.deb )"
S="${WORKDIR}"

LICENSE="Plex"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="mirror bindist" # public releases can drop mirror per bug #600696

DEPEND="
	acct-group/plex
	acct-user/plex"
RDEPEND="${DEPEND}"

QA_PREBUILT="*"
QA_MULTILIB_PATHS=(
	"usr/lib/plexmediaserver/.*"
	"usr/lib/plexmediaserver/lib/.*"
	"usr/lib/plexmediaserver/Resources/Python/lib/python2.7/.*"
	"usr/lib/plexmediaserver/Resources/Python/lib/python2.7/lib-dynload/_hashlib.so"
)

_PLUGINS="export PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="
_CONFIG_FILE="${S}/usr/lib/plexmediaserver/lib/plexmediaserver.default"

src_prepare() {
	eapply_user

	# Set Plugin threads from MAKEOPTS
	sed -i -e 's/#"${_PLUGINS}".*/"${_PLUGINS}"'$(makeopts_jobs)'/g' "${_CONFIG_FILE}" || die

	# Get MAKEOPTS and add job number for threading comskip
	sed -i '/^thread_count=/{h;s/=.*/='$(makeopts_jobs)'/};${x;/^$/{s//thread_count='$(makeopts_jobs)'/;H};x}' \
		${S}/usr/lib/plexmediaserver/Resources/comskip.ini || die
}

src_install() {
	# Remove Debian specific files
	rm -r "usr/share/doc" || die

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

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
