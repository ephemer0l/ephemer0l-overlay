# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
PYTHON_COMPAT=( python3_{7,8,9,10,11} )

inherit distutils-r1

_GIT_USER="ProgVal"
_MY_COMMIT="1389576"
_MY_LONG_COMMIT="138957676ec8c974dde1e45be81a37691f17434c"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/${_GIT_USER}/${PN}.git"
	EGIT_BRANCH="testing"
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/${_GIT_USER}/${PN}/tarball/${_MY_LONG_COMMIT} -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S=${WORKDIR}/${_GIT_USER}-${PN}-${_MY_COMMIT}
fi

DESCRIPTION="Python based extensible IRC infobot and channel bot"
HOMEPAGE="https://supybot.aperio.fr/"
LICENSE="BSD"
SLOT="0"
IUSE="crypt ssl"

RDEPEND="
	crypt? ( dev-python/python-gnupg[${PYTHON_USEDEP}] )
	ssl? ( dev-python/pyopenssl[${PYTHON_USEDEP}] )
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/ecdsa[${PYTHON_USEDEP}]
	dev-python/feedparser[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/PySocks[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	"
DEPEND="
	${RDEPEND}
	"

src_unpack() {
	if [[ ${PV} == "9999" ]]; then
		git-r3_src_unpack
	else
		unpack ${P}.tar.gz
	fi
}

python_prepare_all(){
	distutils-r1_python_prepare_all
	if python_is_python3; then
		einfo "Removing the RSS plugin because of clashes between libxml2's Python3"
		einfo "bindings and feedparser."
		rm -rf "plugins/RSS" || die
	fi
}

python_install_all() {
	distutils-r1_python_install_all
	doman man/*
}

#python_test() {
#	pushd "${T}" > /dev/null
#	PLUGINS_DIR="${BUILD_DIR}/lib/supybot/plugins"
	# recommended by upstream, unknown random failure
#	EXCLUDE_PLUGINS=( --exclude="${PLUGINS_DIR}/Scheduler" )
	# recommended by upstream, unknown random failure
#	EXCLUDE_PLUGINS+=( --exclude="${PLUGINS_DIR}/Filter" )
	# intermittent failure due to issues loading libsandbox.so from LD_PRELOAD
	# runs successfully when running the tests on the installed system
#	EXCLUDE_PLUGINS+=( --exclude="${PLUGINS_DIR}/Unix" )
#	"${PYTHON}" "${BUILD_DIR}"/scripts/supybot-test "${BUILD_DIR}/../test" \
#		--plugins-dir="${PLUGINS_DIR}" --no-network \
#		--disable-multiprocessing "${EXCLUDE_PLUGINS[@]}" \
#		|| die "Tests failed under ${EPYTHON}"
#	popd > /dev/null
#}

pkg_postinst() {
	elog "Complete user documentation is available at https://limnoria-doc.readthedocs.org/"
	elog ""
	elog "Use supybot-wizard to create a configuration file."
	elog "Run supybot </path/to/config> to use the bot."
	elog "Plugins can be found at https://github.com/ProgVal/Supybot-plugins"
}
