# Copyright 1999-2022 Gentoo Author ephemer0l
# Distributed under the terms of the NWA License

EAPI=7

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 eutils git-r3 python-r1

DESCRIPTION="Tool for searching quassel logs from the commandline"
HOMEPAGE="https://github.com/fish-face/quasselgrep"

if [[ "${PV}" == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/65278/quasselgrep.git"
	KEYWORDS=""
else
	EGIT_REPO_URI="https://github.com/65278/quasselgrep.git"
	EGIT_COMMIT="9b6b0bc1252daa6e574363d87d04eebd981215a5"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="postgres sqlite"

RDEPEND="sqlite? ( dev-lang/python[sqlite] )
	dev-python/future[${PYTHON_USEDEP}]
	postgres? ( dev-python/psycopg:2[${PYTHON_USEDEP}] )
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]"
