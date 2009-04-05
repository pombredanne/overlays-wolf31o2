# Copyright 2008-2009 Chris Gianelloni
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils cacti-plugins

SRC_URI="${CACTI_PLUG_BASE}/${CACTI_PLUG_NAME}-${PV}.tar.gz"

LICENSE="GPL-2"

MYSQL_SCRIPTS="${CACTI_PLUG_HOME}/discover.sql"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PVR}/*.patch || die
}