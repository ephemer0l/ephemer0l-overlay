# Copyright 2021 Gentoo Authors
# Distributed under the terms of the NWA General License

EAPI=7

inherit cmake git-r3

DESCRIPTION="CMake driven cross-platform package manager for C/C++"
HOMEPAGE="https://github.com/ruslo/hunter/"

EGIT_REPO_URI="https://github.com/cpp-pm/hunter.git"
EGIT_COMMIT="6d5c915689c911371771d8f9103fda5f3923ca5c"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmake"
