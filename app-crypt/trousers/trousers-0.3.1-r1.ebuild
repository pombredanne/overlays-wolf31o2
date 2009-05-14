# Copyright 1999-2009 Gentoo Foundation ; 2009 Chris Gianelloni
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=1

inherit autotools base eutils linux-info

DESCRIPTION="open-source TCG Software Stack (TSS) v1.2 implementation"
HOMEPAGE="http://trousers.sf.net"
SRC_URI="mirror://sourceforge/trousers/${P}.tar.gz"
LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gmp +gtk ssl"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/openssl-0.9.7
	gtk? ( >=x11-libs/gtk+-2 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PDEPEND="ssl? ( app-crypt/openssl-tpm-engine )"

PATCHES=(	"${FILESDIR}/${PN}-0.2.3-nouseradd.patch"
		"${FILESDIR}/${P}-qa.patch"
		"${FILESDIR}/${P}-gcc43.patch"	)

pkg_setup() {
	# Check for driver (not sure it can be an rdep, because ot depends on the
	# version of virtual/linux-sources... Is that supported by portage?)
	linux-info_pkg_setup
	local tpm_kernel_version tpm_kernel_present tpm_module
	kernel_is ge 2 6 12 && tpm_kernel_version="yes"
	linux_chkconfig_present TCG_TPM && tpm_kernel_present="yes"
	has_version app-crypt/tpm-emulator && tpm_module="yes"
	if [ -n "${tpm_kernel_present}" ] ; then
		einfo "Good, you seem to have in-kernel TPM support."
	elif [ -n "${tpm_module}" ] ; then
		einfo "Good, you seem to have TPM support with the external module."
		if [ -n "${tpm_kernel_version}" ] ; then
			elog
			elog "Note that since you have a >=2.6.12 kernel, you could use"
			elog "the in-kernel driver instead of (CONFIG_TCG_TPM)."
		fi
	elif [ -n "${tpm_kernel_version}" ] ; then
		eerror
		eerror "To use this package, you will have to activate TPM support"
		eerror "in your kernel configuration. That's at least CONFIG_TCG_TPM,"
		eerror "plus probably a chip specific driver (like CONFIG_TCG_ATMEL)."
		eerror
	else
		eerror
		eerror "To use this package, you should install a TPM driver."
		eerror "You can have the following options:"
		eerror "  - install app-crypt/tpm-emulator"
		eerror "  - switch to a >=2.6.12 kernel and compile the kernel module"
		eerror
	fi

	# New user/group for the daemon
	enewgroup tss
	enewuser tss -1 -1 /var/lib/tpm tss
}

src_unpack() {
	base_src_unpack

	sed -e "s/-Werror //" -i configure.in
	eautoreconf
}

src_compile() {
	local __myconf=$(use_with gmp)
	if ! use gtk ; then
		__myconf="${__myconf} --with-gui=none"
	fi
	econf ${__myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	keepdir /var/lib/tpm
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NICETOHAVES README* TODO doc/*
	newinitd "${FILESDIR}/tcsd.initd" tcsd
	newconfd "${FILESDIR}/tcsd.confd" tcsd
}
