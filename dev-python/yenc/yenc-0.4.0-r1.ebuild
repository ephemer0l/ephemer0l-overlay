# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python{2_7,3_{8,9,10,11}} )

inherit eutils python-r1

DESCRIPTION="A fairly simple module, it provide only raw yEnc encoding/decoding"
HOMEPAGE="http://www.golug.it/yenc.html"
SRC_URI="http://www.golug.it/pub/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

PATCHES=( "${FILESDIR}/${PN}-remove-cflags.patch" )

python_test() {
	PYTHONPATH="$(ls -d build/lib.*)" \
		"${PYTHON}" test/test.py || die "Test failed."
}

src_install() {
	python-distutils-ng_src_install

	dodoc doc/${PN}-draft.1.3.txt
}
