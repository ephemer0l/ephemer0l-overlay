# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 python-utils-r1

PYTHON_COMPAT=( python{2_7,3_{6,7}} )

DESCRIPTION="Targeted evil twin attacks against WPA2-Enterprise networks"
HOMEPAGE="https://github.com/s0lst1c3/eaphammer"

_GIT_USER="s0lst1c3"
_MY_COMMIT="779c823"
_MY_LONG_COMMIT="779c8239178a17a5bc8964f4a651f6be6599b815"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${_GIT_USER}-${PN}-${_GIT_COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="systemd networkmanager"

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/tqdm
	net-dns/dnsmasq
	net-libs/libnfnetlink
	dev-libs/libnl:3
	net-wireless/hostapd
	net-analyzer/dsniff
	www-servers/apache
	net-misc/networkmanager
	"

src_prepare() {
	if use systemd; then
		sed -i s/True/False/ "${WORKDIR}"/config.py || die 'sed failed'
	fi

	sed -i s/network-manager/NetworkManager/ "${WORKDIR}"/config.py || die 'sed failed'
}
