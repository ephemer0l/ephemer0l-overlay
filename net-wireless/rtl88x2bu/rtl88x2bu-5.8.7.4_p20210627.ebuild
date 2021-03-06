# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info linux-mod readme.gentoo-r1

DESCRIPTION="Linux kernel driver for rtl88x2bu USB WiFi chipsets"
HOMEPAGE="https://github.com/morrownr/88x2bu.git"
HASH_COMMIT="d57710b441e71c5dbdb0bc3daae05904a03b21e4"
SRC_URI="https://github.com/morrownr/88x2bu/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

#ARCH=x86_64
MODULE_NAMES="88x2bu(net/wireless:)"
BUILD_TARGETS="clean modules"
DEPEND=""

S="${WORKDIR}/88x2bu-${HASH_COMMIT}"

pkg_setup() {
	linux-mod_pkg_setup
	#compile against selected (not running) target
	BUILD_PARAMS="KVER=${KV_FULL} KSRC=${KERNEL_DIR}"
}

src_install() {
	readme.gentoo_create_doc
	readme.gentoo_print_elog
}
