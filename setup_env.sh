#!/bin/bash
echo $PATH

VENV=scenarios
PYVER=3.5


unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    DEPARRAY=(numpy=1.11 scipy=0.19.1 matplotlib=2.0.2 rasterio=1.0a2 pandas=0.20.3 h5py=2.7.0 gdal=2.1.4 pytest=3.2.0 pytest-cov=2.5.1 cartopy=0.15.1 fiona=1.7.8 numexpr=2.6.2 configobj=5.0.6 decorator=4.1.2 versioneer==0.18)
elif [[ "$unamestr" == 'FreeBSD' ]] || [[ "$unamestr" == 'Darwin' ]]; then
    DEPARRAY=(numpy=1.13.1 scipy=0.19.1 matplotlib=2.0.2 rasterio=1.0a9 pandas=0.20.3 h5py=2.7.0 gdal=2.1.4 pytest=3.2.0 pytest-cov=2.5.1 cartopy=0.15.1 fiona=1.7.8 numexpr=2.6.2 configobj=5.0.6 decorator=4.1.2 versioneer==0.18)
fi

# turn off whatever other virtual environment user might be in
source deactivate

# remove any previous virtual environments called pager
CWD=`pwd`
cd $HOME;
conda remove --name $VENV --all -y
cd $CWD

conda create --name $VENV --yes python=$PYVER ${DEPARRAY[*]}

# Activate the new environment
source activate $VENV

# pip installs of those things that are not available via conda.

# OpenQuake v2.5.0
curl --max-time 60 --retry 3 -L https://github.com/gem/oq-engine/archive/v2.5.0.zip -o openquake.zip
pip -v install --no-deps openquake.zip
rm openquake.zip

# get MapIO
curl --max-time 60 --retry 3 -L https://github.com/usgs/MapIO/archive/master.zip -o mapio.zip
pip -v install --no-deps mapio.zip
rm mapio.zip

# get impactutils
curl --max-time 60 --retry 3 -L https://github.com/usgs/earthquake-impact-utils/archive/master.zip -o impact.zip
pip -v install --no-deps impact.zip
rm impact.zip

# get shakelib
curl --max-time 60 --retry 3 -L https://github.com/usgs/shakelib/archive/master.zip -o shakelib.zip
pip -v install --no-deps shakelib.zip
rm shakelib.zip

# get shakemap
curl --max-time 60 --retry 3 -L https://github.com/usgs/shakemap/archive/master.zip -o shakelib.zip
pip -v install --no-deps shakelib.zip
rm shakelib.zip


#pip install sphinx_rtd_theme

# tell the user they have to activate this environment
echo "Type 'source activate scenarios' to use this new virtual environment."
