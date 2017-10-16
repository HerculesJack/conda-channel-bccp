#!/bin/bash

# Determine the directory containing this script
if [[ -n $BASH_VERSION ]]; then
    _SCRIPT_LOCATION=${BASH_SOURCE[0]}
    _SHELL="bash"
elif [[ -n $ZSH_VERSION ]]; then
    _SCRIPT_LOCATION=${funcstack[1]}
    _SHELL="zsh"
else
    echo "Only bash and zsh are supported"
    return 1
fi

_BCCP_DIR=$(dirname "$_SCRIPT_LOCATION")

if ! [ $# == 1 ]; then
    (>&2 echo "Error: expect one argument.")
    (>&2 echo "    (Got $@)")
    return 1
fi

case $1 in
    2.7 | 3.6 | 3.5 )
    ;;

    *)
    (>&2 echo "give a Python version number 2.7, 3.5 or 3.6")
    (>&2 echo "    (Got $1)")
    return 1
    ;;
esac 

source $_BCCP_DIR/anaconda3/bin/activate $1
source $_BCCP_DIR/python-mpi-bcast/activate.sh /dev/shm/local "srun -n $SLURM_JOB_NUM_NODES"

bcast $_BCCP_DIR/python-mpi-bcast/nersc/${NERSC_HOST}/system-libraries.tar.gz \
      $_BCCP_DIR/anaconda3/envs/bccp-anaconda-$1.tar.gz
