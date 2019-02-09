# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

USE_RUBY="ruby20 ruby21"
inherit ruby-fakegem eutils

DESCRIPTION="Browser exploitation framework"
HOMEPAGE="http://beefproject.com/"
SRC_URI="https://github.com/beefproject/beef/archive/${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite[-postgres,-mysql] postgres[-sqlite,-mysql] mysql[-sqlite,-postgres] test twitter"

DEPEND+=""
RDEPEND+="net-analyzer/metasploit"

#ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

ruby_add_rdepend "
	=dev-ruby/eventmachine-1.0.3*
	www-servers/thin
	=dev-ruby/sinatra:1.4
	=dev-ruby/rack:1.5
	dev-ruby/em-websocket
	dev-ruby/uglifier
	dev-ruby/ansi
    dev-ruby/term-ansicolor
    dev-ruby/dm-core
    dev-ruby/json
	dev-ruby/data_objects
	?sqlite ( dev-ruby/dm-sqlite-adapter )
	?postgres ( dm-postgres-adapter  )
	?mysql ( dm-mysql-adapter )
    dev-ruby/parseconfig
	dev-ruby/erubis
    dev-ruby/dm-migrations
    dev-ruby/msfrpc-client
	?twitter ( dev-ruby/twitter  )
	>=dev-ruby/rubyzip:1
	>=dev-ruby/rubydns-0.7.0
	dev-ruby/geoip
	?test ( 
	dev-ruby/test-unit
	dev-ruby/curb
	dev-ruby/selenium-webdriver
	dev-ruby/capybara
	dev-ruby/rest-client
	)
	"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	#upstream smoked something here
	mv "beef-${P}" "${P}"
	cd "${S}"
	einfo `pwd`
}

src_prepare() {
	epatch "${FILESDIR}/${PV}_unbundler.patch"
	rm {Gemfile*,.gitignore,install*,update-beef}
	#enable metasploit
	sed -i -e '/metasploit\:/ { n ; s/false/true/ }' config.yaml || die "failed to sed"
	sed -i -e 's/55552/55553/' extensions/metasploit/config.yaml || die "failed to sed"
	sed -i -e 's/"abc123"/"secure"/' extensions/metasploit/config.yaml || die "failed to sed"
	sed -i -e "s|'osx', path: '/opt/local/msf/'|'pentoo', path: '/usr/lib/metasploit/'|" extensions/metasploit/config.yaml || die "failed to sed"
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dosbin "${FILESDIR}"/beef
}
