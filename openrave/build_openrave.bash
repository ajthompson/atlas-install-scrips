#!/bin/bash

if [ -d ~/openrave ] ; then
  echo "Openrave already installed"
  exit 0
fi

cd ~
git clone --branch latest_stable https://github.com/rdiankov/openrave.git
cp ~/openrave/openrave-config.cmake.in ~/openrave/openrave-config.cmake
cd openrave
mkdir build
cd build
cmake .. 
cd ..
make && sudo make install

