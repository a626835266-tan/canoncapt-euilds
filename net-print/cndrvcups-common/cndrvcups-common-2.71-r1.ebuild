# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib eutils

DESCRIPTION="Common files for the Canon CUPS Capt driver"
HOMEPAGE="http://www.canon.com/"
SRC_URI="http://gdlp01.c-wss.com/gds/6/0100004596/05/linux-capt-drv-v271-uken.tar.gz"

LICENSE="CANON"
SLOT="0"
KEYWORDS="~amd64 ~x86"

MY_P=${P/_p/-}-1

MY_PV="$(ver_rs 1- '')"
SOURCES_NAME="linux-capt-drv-v${MY_PV}-uken"
SRC_URI="http://gdlp01.c-wss.com/gds/6/0100004596/05/linux-capt-drv-v271-uken.tar.gz"

DEPEND=">=net-print/cups-1.1.17
        >=x11-libs/gtk+-2.4.0
        >=gnome-base/libglade-2.4.0"


S=${WORKDIR}/${SOURCES_NAME}/Src/cndrvcups-common-3.21

PATCHES=(
	"${FILESDIR}/cndrvcups-common-3.21-fix-cngplp.patch"
)


src_unpack() {

    if [ "${A}" != "" ]; then
        unpack ${A}
        cd "${WORKDIR}/linux-capt-drv-v271-uken/Src/"
        unpack ./cndrvcups-common-3.21-1.tar.gz
        cd "${WORKDIR}/linux-capt-drv-v271-uken/"

		S=${WORKDIR}/${SOURCES_NAME}
    fi
}

src_prepare() {

	    eapply "${FILESDIR}"/cndrvcups-common-3.21-fix-cngplp.patch
		eapply_user

		S=${WORKDIR}/${SOURCES_NAME}/Src/cndrvcups-common-3.21
}


src_compile() {
		emake -j1 gen
}

src_install() {

		emake -j1 DESTDIR="${D}" install
		dodoc README LICENSE-EN.txt
}
