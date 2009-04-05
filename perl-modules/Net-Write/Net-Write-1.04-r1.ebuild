# Copyright 1999-2009 Gentoo Foundation ; 2009 Chris Gianelloni
# Distributed under the terms of the GNU General Public License v2
# This ebuild generated by g-cpan 0.15.0 
# Converted to EAPI=2 by Chris Gianelloni

EAPI="2"

inherit perl-module

DESCRIPTION="portable interface to open and send raw data to network"
HOMEPAGE="http://search.cpan.org/search?query=Net-Write&mode=dist"
SRC_URI="mirror://cpan/authors/id/G/GO/GOMOR/${P}.tar.gz"
SRC_TEST="do"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 x86"
RESTRICT="primaryuri"

DEPEND="!perl-gcpan/Net-Write
	dev-perl/Socket6
	perl-modules/Class-Gomor
	dev-perl/Net-Pcap
	dev-lang/perl"
