# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-info linux-mod readme.gentoo-r1

DESCRIPTION="Linux kernel driver for rtl88x2bu USB WiFi chipsets"
HOMEPAGE="https://github.com/morrownr/88x2bu.git"
#HASH_COMMIT="6c2ca754ec23dcf67993f036e76cce562e1e329d"
#SRC_URI="https://github.com/morrownr/88x2bu/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/morrownr/88x2bu-20210702.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

MODULE_NAMES="88x2bu(net/wireless:)"
BUILD_TARGETS="clean modules"
BUILD_PARAMS="KVER=${KV_FULL} KSRC=${KERNEL_DIR}"
DEPEND=""

#S="${WORKDIR}/88x2bu-${HASH_COMMIT}"

pkg_setup() {
	linux-mod_pkg_setup
}

src_install() {
	linux-mod_src_install

	readme.gentoo_create_doc
	readme.gentoo_print_elog
}

pkg_postinst() {
	linux-mod_pkg_postinst
}
