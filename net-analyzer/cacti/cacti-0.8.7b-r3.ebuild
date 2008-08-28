# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti/cacti-0.8.7b-r2.ebuild,v 1.5 2008/04/27 20:01:28 maekke Exp $

EAPI=1

inherit eutils webapp depend.apache depend.php

# Support for _p* in version.
MY_P=${P/_p*/}
HAS_PATCHES=1

DESCRIPTION="a complete frontend to rrdtool"
HOMEPAGE="http://www.cacti.net/"
SRC_URI="http://www.cacti.net/downloads/${MY_P}.tar.gz
	plugins? ( http://cactiusers.org/downloads/cacti-plugin-arch.tar.gz )"

# patches
if [ "${HAS_PATCHES}" == "1" ] ; then
	UPSTREAM_PATCHES="upgrade_from_086k_fix
					snmp_auth_none_notice
					reset_each_patch"
	for i in $UPSTREAM_PATCHES ; do
		SRC_URI="${SRC_URI} http://www.cacti.net/downloads/patches/${PV/_p*}/${i}.patch"
	done
fi

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+plugins +snmp"

DEPEND=""

want_apache
need_php_cli
need_php_httpd

RDEPEND="!apache2? ( www-servers/lighttpd )
	snmp? ( net-analyzer/net-snmp )
	net-analyzer/rrdtool
	dev-php/adodb
	virtual/mysql
	virtual/cron"

src_unpack() {
	if [ "${HAS_PATCHES}" == "1" ] ; then
		unpack ${MY_P}.tar.gz
		[ ! ${MY_P} == ${P} ] && mv ${MY_P} ${P}
		# patches
		for i in ${UPSTREAM_PATCHES} ; do
			EPATCH_OPTS="-p1 -d ${S} -N" epatch "${DISTDIR}"/${i}.patch
		done ;
	else
		unpack ${MY_P}.tar.gz
	fi
	if use plugins; then
		unpack cacti-plugin-arch.tar.gz
		cd "${S}"
		epatch "${WORKDIR}"/cacti-plugin-arch/cacti-plugin-0.8.7b-PA-v2.1.diff
		cp -f "${WORKDIR}"/cacti-plugin-arch/pa.sql "${S}"
	fi

	sed -i -e \
		's:$config\["library_path"\] . "/adodb/adodb.inc.php":"adodb/adodb.inc.php":' \
		"${S}"/include/global.php
}

pkg_setup() {
	webapp_pkg_setup
	has_php
	require_php_with_use cli mysql xml session pcre sockets
}

src_install() {
	webapp_src_preinst

	rm LICENSE README
	dodoc docs/{CHANGELOG,CONTRIB,INSTALL,README,REQUIREMENTS,UPGRADE}
	rm -rf docs
	rm -rf lib/adodb

	edos2unix `find -type f -name '*.php'`

	dodir ${MY_HTDOCSDIR}
	cp -r . "${D}"${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/rra
	webapp_serverowned ${MY_HTDOCSDIR}/log/cacti.log
	webapp_configfile ${MY_HTDOCSDIR}/include/config.php
	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
}
