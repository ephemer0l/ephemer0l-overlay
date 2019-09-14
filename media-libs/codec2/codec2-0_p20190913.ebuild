# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A speech codec for bandwidth between 700 and 3200 bit/s"
HOMEPAGE="http://www.rowetel.com/blog/?page_id=452"

_GIT_USER="drowe67"

if [[ ${PV} == "9999" ]] ; then
    EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/${PN}.git"
    EGIT_BRANCH="master"
    KEYWORDS=""
    inherit git-r3
elif [[ ${PV} == "0_p20190913" ]] ; then
	_GIT_COMMIT="171530c"
	_MY_LONG_COMMIT="171530c8b0517789a54cdb42d3cfef34a7a5031c"
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
