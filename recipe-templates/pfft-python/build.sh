#!/bin/bash

if [ `uname` == Darwin ]; then
	export LIBS="-Wl,-rpath,$CONDA_PREFIX/lib"
#    export CXXFLAGS=$CFLAGS
fi

#export LIBS="$LIBS -lm" # because the compat fails fftw3's -lm check

export OMPI_CPPFLAGS=$CPPFLAGS
export OMPI_LDFLAGS=$LDFLAGS
export OMPI_LIBS=$LIBS
export OMPI_CC=$CC
export MPICH_CC=$CC
export OMPI_CFLAGS=$CFLAGS
export OMPI_CXX=$CXX
export MPICH_CXX=$CXX
export OMPI_CXXFLAGS=$CXXFLAGS
export OMPI_FC=$FC
export MPICH_FC=$FC
export OMPI_FCFLAGS=$FCFLAGS

$PYTHON setup.py install 

if [[ $OSTYPE != darwin* ]]; then
    cp $RECIPE_DIR/../../check-glibc.sh .
    bash check-glibc.sh $SP_DIR/pfft || exit 1
fi
