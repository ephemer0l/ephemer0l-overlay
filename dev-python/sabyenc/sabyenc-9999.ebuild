# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit distutils-r1

HOMEPAGE="https://github.com/sabnzbd/sabyenc"

DESCRIPTION="Python yEnc package optimized for use within SABnzbd"

LICENSE="GNU-3"

SLOT=0

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/sabnzbd/sabyenc"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/sabnzbd/sabyenc/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
