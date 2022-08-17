
DISABLED_SYS=$(echo --without-system-{parrot,prune,umbrella,weaver,dataswarm})
DISABLED_LIB=$(echo --with-{readline,fuse}-path\ no)


if [[ "$PY3K" == 1 ]]; then
    PYTHON_OPT="--with-python3-path"
else
    PYTHON_OPT="--with-python2-path"
fi

PERL_PATH="no"

./configure --debug --prefix "${PREFIX}" --with-base-dir "${PREFIX}" ${PYTHON_OPT} "${PREFIX}" --with-perl-path "${PERL_PATH}" ${DISABLED_LIB} ${DISABLED_SYS}

echo ==config.mk==
cat config.mk

make -j${CPU_COUNT}
make install

if ! make test
then
    echo ==cctools.test.fail==
    cat cctools.test.fail
    exit 1
else
    exit 0
fi

