# Copyright 1999-2007 Gentoo Foundation ; 2008-2009 Chris Gianelloni
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit autotools

MY_P="${P/-tpm-/_tpm_}"

DESCRIPTION="an OpenSSL engine that uses private keys stored in TPM hardware"
HOMEPAGE="http://trousers.sourceforge.net"
SRC_URI="mirror://sourceforge/trousers/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=dev-libs/openssl-0.9.8
	>=app-crypt/trousers-0.2.8"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Let's put this engine with the others...
	sed -i -e "s:@libdir@/openssl/engines:@libdir@/engines:" Makefile.am
	eautoreconf
}

src_compile() {
	econf --with-openssl=/usr || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc openssl.cnf.sample README
}
