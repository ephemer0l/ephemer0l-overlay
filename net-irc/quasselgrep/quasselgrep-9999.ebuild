# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )

inherit distutils-r1

DESCRIPTION="Tool for searching quassel logs from the commandline"
HOMEPAGE="https://github.com/fish-face/quasselgrep"

if [[ "${PV}" == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/fish-face/quasselgrep"
	inherit git-r3
	KEYWORDS=""
else
	MY_COMMIT=8de6c631cdfe742ab31efc22a1a08b51e8d5a26a
	SRC_URI="https://github.com/fish-face/"${PN}"/tarball/"${MY_COMMIT}" -> "${P}".tar.gz"
	S=""${WORKDIR}"/fish-face-"${PN}"-"${MY_COMMIT:0:7}""
	KEYWORDS="~amd64 ~x86"
#else
#	SRC_URI="https://github.com/fish-face/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
#	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="sqlite postgres"

DEPEND="${RDEPEND}"
RDEPEND="sqlite? ( "dev-lang/python[sqlite]" )
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	postgres? ( dev-python/psycopg:2[${PYTHON_USEDEP}] )"

src_configure() {
	# https://github.com/fish-face/quasselgrep/pull/15
	sed -i 's/pycrypto/pycryptodome/g' "${S}"/setup.py || die "sed failed"
}
