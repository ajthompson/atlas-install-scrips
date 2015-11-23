#!/bin/bash

if [ -d ~/octomap ] ; then
  echo "Octomap already installed."
  exit 0
fi

cd ~
git clone git@github.com:OctoMap/octomap.git
cd octomap
git checkout v1.6.8
mkdir build
cd build
cmake ..
make

exit 0

