# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools eutils toolchain-funcs webapp

#WEBAPP_DEPEND=">=app-admin/webapp-config-1.50.15"
WEBAPP_MANUAL_SLOT="yes"
WEBAPP_OPTIONAL="yes"

DESCRIPTION=""
HOMEPAGE=""

_GIT_USER="LX3JL"
_MY_COMMIT="b3360b6"
_MY_LONG_COMMIT="b3360b66e2dfcf21c9ddb2af542a9882aa2079a5"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

IUSE="ambed"

DEPEND=""
BRDEPEND="need_httpd
	${DEPEND}"

if [[ ${PV} == "9999" ]] ; then
	S="${WORKDIR}/${P}"
else
	S="${WORKDIR}/${_GIT_USER}-${PN}-${_MY_COMMIT}/${PN}"
fi

pkg_setup() {
	webapp_pkg_setup
}

#src_configure() {
#	if use ambed ; then
#	    sed -i 's:^CFLAGS*:${CFLAGS}=:' "${S}/ambed/makefile"
#	    sed -i 's:^LDFLAGS*:${LDFLAGS}=:' "${S}/ambed/makefile"
#        sed -i 's:^CFLAGS*:${CFLAGS}=:' "${S}/ambedtest/makefile"
#        sed -i 's:^LDFLAGS*:${LDFLAGS}=:' "${S}/ambedtest/makefile"
#	fi

#	sed -i 's:^CFLAGS=*:${CFLAGS}=:' "${S}/src/makefile"
#	sed -i 's:^LDFLAGS=*:${LDFLAGS}= -Wl,--unresolved-symbols=ignore-in-object-files:' "${S}/src/makefile"
#}

src_compile() {
	if use ambed ; then
		cd '${S}/ambed'
		emake || die "Failed to build ambed"
	cd '${S}/ambedtest'
		emake || die "Failed to build ambedtest"
	fi

	cd '${S}/src'
	emake || die "Failed to build ${P}"
}

src_install() {
	webapp_src_preinst
	dobin '${S}/ambedtest/ambedtest'

	dobin '${S}/src/xlxd'

	dodir '${ED}/etc/xlxd'
	insinto '${ED}/etc/xlxd'
	doins '${S}/config/xlxd.*'

	doinitd '${S}/scripts/xlxd'

	webapp_src_preinst
	insinto '${MY_HTDOCSDIR#${EPREFIX}}'
	doins -r '${S}/dashboard/'
	webapp_configfile '${MY_HTDOCSDIR#${EPREFIX}}'/foo/bar.php
	webapp_serverowned '${MY_HTDOCSDIR#${EPREFIX}}'/foo/bar.php
	webapp_postinst_txt en '${FILESDIR}'/postinstall-en-3.1.txt
	webapp_src_install
}
