#!/bin/bash

if [ -d ~/assimp-3.1.1 ] ; then
  echo "ASSIMP already installed"
  exit 0
fi

cd ~/Downloads
if [ ! -f assimp-3.1.1.zip ] ; then
  wget http://downloads.sourceforge.net/project/assimp/assimp-3.1/assimp-3.1.1.zip
fi
cd ~
unzip ~/Downloads/assimp-3.1.1.zip
rm -f ~/Downloads/assimp-3.1.1.zip
cd assimp-3.1.1
mkdir build
cd build
cmake ..
make && sudo make install

exit 0

