# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# This ebuild generated by g-cpan 0.15.0

inherit perl-module

DESCRIPTION="an object for all network related stuff"
HOMEPAGE="http://search.cpan.org/search?query=Net-Packet-Target&mode=dist"
SRC_URI="mirror://cpan/authors/id/G/GO/GOMOR/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 x86"

DEPEND=">=perl-modules/Class-Gomor-1.01
	>=perl-modules/Net-Packet-3.26
	dev-lang/perl"
