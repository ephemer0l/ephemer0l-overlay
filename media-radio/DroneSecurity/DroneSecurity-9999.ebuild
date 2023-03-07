# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8,9,10,11} )

inherit git-r3 python-r1

DESCRIPTION="Drone-ID Receiver for DJI OcuSync 2.0"
HOMEPAGE="https://github.com/RUB-SysSec/DroneSecurity"
EGIT_REPO_URI="https://github.com/RUB-SysSec/DroneSecurity.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="spectrum-display"

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/bitarray[${PYTHON_USEDEP}]
	dev-python/crcmod[${PYTHON_USEDEP}]
	dev-python/cycler[${PYTHON_USEDEP}]
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/kiwisolver[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	spectrum-display? ( net-wireless/inspectrum[${PYTHON_USEDEP}] )
	net-wireless/uhd"
BDEPEND=""
