
git reset --hard
git checkout nersc
git pull origin nersc

source /usr/common/contrib/bccp/anaconda3/bin/activate root

python extrude_recipes requirements.yml

build ()
{
    local PYTHON=$1
    
    pushd recipes
    conda build --no-test --python $PYTHON mpi4py
    for f in *; do
        conda build --no-test --skip-existing --python $PYTHON $f
    done
    
    source activate $PYTHON
    conda install --use-local --yes *
    
    popd
    
}

build 3.6
build 3.5
build 2.7
