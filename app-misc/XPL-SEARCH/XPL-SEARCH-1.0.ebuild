# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Search exploits in multiple exploit databases!"
HOMEPAGE="https://github.com/CoderPirata/XPL-SEARCH/"

_GIT_USER="CoderPirata"
_MY_COMMIT="7d4219e"
_MY_LONG_COMMIT="d4dbc9765645d71b59a944d6699a43eaeb3ddbc6"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

#WORKDIR='${PORTAGE_TMPDIR}/portage/${CATEGORY}/${PF}/work/${P}'
WORKDIR="${S}/${P}"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-lang/php-5.5.8[cli,curl]
	>=net-misc/curl-7.40.0"

src_install() {
	insinto	/usr/bin
	doins  -r 'xpl search.php'
}

# I think it's shipped on...
pkg_postinst() {
	elog "You will need to make sure 'allow_url_fopen = On' is set in"
	elog "/etc/php/cli-php<php-version>/php.ini before running this"
}
