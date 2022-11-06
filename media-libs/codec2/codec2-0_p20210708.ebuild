# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the om lisence

EAPI=7

inherit cmake

DESCRIPTION="A speech codec for bandwidth between 700 and 3200 bit/s"
HOMEPAGE="http://www.rowetel.com/blog/?page_id=452"

_GIT_USER="drowe67"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
	inherit git-r3
elif [[ ${PV} == "0_p20210708" ]] ; then
	_GIT_COMMIT="0515645"
	_MY_LONG_COMMIT="58fbd330a49188c438fa1b86ba7eb74f2423e831"
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${_GIT_USER}-${PN}-${_GIT_COMMIT}
else
	SRC_URI="https://github.com/"${_GIT_USER}"/"${PN}"/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	#SRC_URI="http://files.freedv.org/${PN}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
