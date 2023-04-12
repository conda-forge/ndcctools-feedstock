#! /bin/bash

DISABLED_SYS=$(echo --without-system-{parrot,prune,umbrella,weaver})
DISABLED_LIB=$(echo --with-{readline,fuse,perl}-path\ no)

./configure --debug --prefix "${PREFIX}" --with-base-dir "${PREFIX}" ${DISABLED_LIB} ${DISABLED_SYS}

echo ==config.mk==
cat config.mk

make -j${CPU_COUNT}
make install

if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != 1 ]]
then
    if ! make test
    then
        echo ==cctools.test.fail==
        cat cctools.test.fail
        exit 1
    else
        exit 0
    fi
fi
