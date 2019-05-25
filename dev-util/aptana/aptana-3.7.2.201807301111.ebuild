# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
inherit eutils

_GIT_USER="aptana"
_MY_COMMIT="1c513af"
_MY_LONG_COMMIT="1c513af3de3cea226fdd38794d5bc1dd703c7adc"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/"${_GIT_USER}"/studio3.git"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/"${_GIT_USER}"/studio3/tarball/"${_MY_LONG_COMMIT}" -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="The leading eclipse IDE for Ajax and today's web platforms"
HOMEPAGE="https://github.com/aptana/studio3"
LICENSE="EPL-1.0"
SLOT="3"
RESTRICT="mirror"
IUSE=""

RDEPEND="media-libs/libjpeg-turbo
	>=virtual/jre-1.5
	media-libs/libpng:1.2
	x11-libs/gtk+:2
	sys-apps/net-tools"

src_unpack(){
	echo "nothing to extract"
	unpack ${A}
	cd "${S}"
	mv "${WORKDIR}/Aptana_Studio_3" "${S}"
}

src_install(){
	einfo "Installing Aptana"
	dodir "/opt/${PN}"
	local dest="${D}/opt/${PN}"
	cp -pPR configuration/ features/ plugins/ "${dest}" || die "Failed to install Files"
	insinto "/opt/${PN}"
	doins libcairo-swt.so icon.xpm about.html AptanaStudio3.ini full_uninstall.txt version.txt
	exeinto "/opt/${PN}"
	doexe AptanaStudio3

	dodir /opt/bin
	echo "#!/bin/sh" > ${T}/AptanaStudio
	echo "/opt/${PN}/AptanaStudio3" >> ${T}/AptanaStudio
	dobin "${T}/AptanaStudio"

	make_desktop_entry "AptanaStudio" "Aptana Studio" "/opt/${PN}/icon.xpm" "Development"
}
