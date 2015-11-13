#!/bin/bash

# check if a workspace exists
if [ -d ~/g2o ] ; then
  echo "Libg2o workspace already exists"
  exit 0
fi

cd ~
git clone git@github.com:RainerKuemmerle/g2o.git
cd g2o
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/opt/ros/hydro
make && sudo make install

exit 0
