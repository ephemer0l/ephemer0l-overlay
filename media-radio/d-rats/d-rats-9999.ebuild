# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

if [[ ${PV} == "99999999" ]] ; then
	VCS=git-r3
	EGIT_REPO_URI="https://gitlab.openquad.net/kc9qen/d-rats.git"
	KEYWORDS=""
elif [[ ${PV} == "9999" ]] ; then
	VCS=mercurial
	EHG_REPO_URI="http://d-rats.com/hg/d-rats.hg"
	EHG_REVISION="current-beta"
	KEYWORDS=""
else
	VCS=mercurial
	EHG_REPO_URI="http://d-rats.com/hg/d-rats.hg"
	EHG_REVISION="release_0_3_3"
	KEYWORDS="~amd64 ~x86"
fi

inherit distutils-r1 ${VCS}

DESCRIPTION="A Communications Tool For D-STAR"
HOMEPAGE="http://www.d-rats.com/"

LICENSE="GPL-3"
SLOT="0"
IUSE="spell"

DEPEND=""
RDEPEND="${DEPEND}
	spell? ( app-text/aspell )
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-libs/libxslt
	dev-python/pygtk"

PATCHES=( "${FILESDIR}/${PN}-change.xdg.desktop.location.patch" )

src_prepare() {
#	ver="hg id -i -r0 ${EHG_STORE_DIR}"
#	echo "DRATS_VERSION = ${PV}" >  "${WORKDIR}"/"${P}"/d_rats/version.py || die
#	sed -e 's/$/${WORKDIR}/${P}/d_rats/version.py' ${ver} || die
#	${ver} | sed s/$/ "${WORKDIR}/${P}/d_rats/version.py"
#	sed -n  "DRATS_VERSION\s=\s${ver}w" "${WORKDIR}/${P}/d_rats/version.py"

if [[ ${PV} == "999*" ]] ; then
	echo "DRATS_VERSION = ${PV}" >  "${WORKDIR}"/"${P}"/d_rats/version.py || die
fi
	sed -i -e "/share\/doc\/d-rats/d" setup.py || die
	distutils-r1_src_prepare
}

python_test() {
	pushd tests > /dev/null
	"${PYTHON}" run_tests || die
	popd > /dev/null
}
