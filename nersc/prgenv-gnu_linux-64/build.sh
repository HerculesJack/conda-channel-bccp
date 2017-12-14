#!/bin/bash

install $RECIPE_DIR/mpicc $PREFIX/bin/
install $RECIPE_DIR/mpicxx $PREFIX/bin/
install $RECIPE_DIR/mpifort $PREFIX/bin/
install $RECIPE_DIR/mpif77 $PREFIX/bin/
install $RECIPE_DIR/mpif90 $PREFIX/bin/

mkdir -p $PREFIX/etc/conda/activate.d
install ${RECIPE_DIR}/activate-nersc-prgenv-gnu.sh $PREFIX/etc/conda/activate.d