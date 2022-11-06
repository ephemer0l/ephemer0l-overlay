# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A multi-platform port of UZ7HO's SoundModem"
HOMEPAGE="http://www.cantab.net/users/john.wiseman/Documents/QtSoundModem.html"
SRC_URI="http://www.cantab.net/users/john.wiseman/Downloads/Beta/QtSMSource.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sci-libs/fftw:*
	dev-qt/qtserialport"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_configure(){
	qmake -project QtSoundModem.pro || die echo "qmake faild"
}

src_compile(){
	make || die echo "make failed"
}
