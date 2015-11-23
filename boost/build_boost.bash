#!/bin/bash

if [ -d ~/boost_ws ] ; then
  echo "Boost 1.52.0 is already installed."
  exit 0
fi

sudo apt-get install --reinstall libboost-all-dev libboost-dev libogre-1.9-dev

mkdir ~/boost_ws

# make install locations
mkdir -p /home/$USER/local/include
mkdir -p /home/$USER/local/lib

cd ~/Downloads
if [ ! -f ~/Downloads/boost_1_52_0.tar.gz ] ; then
  wget http://downloads.sourceforge.net/project/boost/boost/1.52.0/boost_1_52_0.tar.gz
fi
cd ~/boost_ws
tar xvf ~/Downloads/boost_1_52_0.tar.gz
rm -f ~/Downloads/boost_1_52_0.tar.gz

cd ~/boost_ws/boost_1_52_0

# patch a file so it works on newer compilers
#patch boost/config/stdlib/libstdcpp3.hpp < ${SCRIPT_DIR}/boost/threads.patch
#patch boost/thread/xtime.hpp < ${SCRIPT_DIR}/boost/xtime.hpp.patch

# bootstrap that shit
./bootstrap.sh

# run the build
./b2 -a
sudo ./b2 install --prefix=/usr --exec-prefix=/usr/lib/x86_64-linux-gnu --libdir=/usr/lib/x86_64-linux-gnu

exit 0

