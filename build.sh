#!/bin/bash
case "$SHED_BUILD_MODE" in
    toolchain)
        SHED_PKG_PREFIX='/tools'
        ;;
    *)
        SHED_PKG_PREFIX='/usr'
        ;;
esac

./configure --prefix=$SHED_PKG_PREFIX &&
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install || exit 1

if [ "$SHED_BUILD_MODE" != 'toolchain' ]; then
    mkdir -v "${SHED_FAKE_ROOT}/bin"
    mv -v "${SHED_FAKE_ROOT}/usr/bin/gzip" "${SHED_FAKE_ROOT}/bin"
fi
