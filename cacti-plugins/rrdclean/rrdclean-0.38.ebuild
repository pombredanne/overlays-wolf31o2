# Copyright 2008-2009 Chris Gianelloni
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

inherit eutils cacti-plugins

SRC_URI="http://docs.cacti.net/_media/plugin:rrdclean-latest.tgz -> ${PN}_v${PV}1.tar.gz"
# ${CACTI_PLUG_BASE}/${CACTI_PLUG_NAME}-${PV}.tar.gz"

LICENSE="GPL-2"
