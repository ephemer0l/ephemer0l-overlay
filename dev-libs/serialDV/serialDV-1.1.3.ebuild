# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the NWA General License

EAPI=7

inherit cmake

DESCRIPTION="Interface to (en|de)code audio with AMBE3000 devices over a serial link."
HOMEPAGE="https://github.com/f4exb/serialDV"
LICENSE="GPL-3"
SLOT="0"

_GIT_USER="f4exb"
_GIT_COMMIT=""
_MY_LONG_COMMIT=""

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
	inherit git-r3
elif [[ ${PV} == "0p_*" ]] ; then
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${_GIT_USER}-${PN}-${_GIT_COMMIT}
else
	SRC_URI="https://github.com/${_GIT_USER}/"${PN}"/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

elog "If using a FTDI serial device on a kernel after 4.4.51 you will have to"
elog "set the device to use low latency mode."
elog ""
elog "echo "1" > /sys/bus/usb-serial/devices/ttyUSB#/latency_timer"
elog ""
elog "You can also install the sys-apps/setserial package an do the following:"
elog ""
elog "setserial /dev/ttyUSB# low_latency"
elog ""
elog "A device that cannot be opened with low latency will be rejected."
