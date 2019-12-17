# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="A DataObjects Adapter for DataMapper"
HOMEPAGE="http://datamapper.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

ruby_add_bdepend "doc? ( >=dev-ruby/jeweler-1.6.4 >=dev-ruby/rake-0.9.2 >=dev-ruby/yard-0.8.7.3 )"

ruby_add_rdepend ">=dev-ruby/data_objects-0.10.6 >=dev-ruby/dm-core-1.2.0"
