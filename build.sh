#!/bin/bash
case "$SHED_BUILDMODE" in
    toolchain)
        SHEDPKG_PREFIX='/tools'
        ;;
    *)
        SHEDPKG_PREFIX='/usr'
        ;;
esac

./configure --prefix=$SHEDPKG_PREFIX || return 1
make -j $SHED_NUMJOBS || return 1
make DESTDIR="$SHED_FAKEROOT" install || return 1

if [ "$SHED_BUILDMODE" != 'toolchain' ]; then
    mkdir -v "${SHED_FAKEROOT}/bin"
    mv -v "${SHED_FAKEROOT}/usr/bin/gzip" "${SHED_FAKEROOT}/bin"
fi
