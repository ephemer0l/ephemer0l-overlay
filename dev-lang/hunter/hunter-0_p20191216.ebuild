# Copyright 2019 Gentoo Authors
# Distributed under the terms of the NWA General License

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="CMake driven cross-platform package manager for C/C++"
HOMEPAGE="https://github.com/ruslo/hunter/"

EGIT_REPO_URI="https://github.com/cpp-pm/hunter.git"
EGIT_COMMIT="2af4113d79c2551bf6ea9ec9cde5460fbbb9f096"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmake"
