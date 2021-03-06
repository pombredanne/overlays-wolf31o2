# Copyright 1999-2009 Gentoo Foundation ; 2009 Chris Gianelloni
# Distributed under the terms of the GNU General Public License v2
# This ebuild generated by g-cpan 0.15.0 
# Converted to EAPI=2 by Chris Gianelloni

EAPI="2"

inherit perl-module

DESCRIPTION="log to files which rotate/archive themselves"
HOMEPAGE="http://search.cpan.org/search?query=Log-Dispatch-FileRotate&mode=dist"
SRC_URI="mirror://cpan/authors/id/M/MA/MARKPF/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 x86"
RESTRICT="primaryuri"

DEPEND="!perl-gcpan/Log-Dispatch-FileRotate
	dev-perl/Params-Validate
	perl-modules/Date-Manip
	dev-perl/log-dispatch
	dev-perl/Log-Log4perl
	dev-lang/perl"
RDEPEND="${DEPEND}"
