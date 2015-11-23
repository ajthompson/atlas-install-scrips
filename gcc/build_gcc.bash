#!/bin/bash

# That's right. We're building god-damn gcc from source

if [ -d ~/gcc_ws ] ; then
  echo "We've already built gcc"
  exit 0
fi

sudo apt-get install libgmp-dev libgmp10-doc libmpfr-dev libmpfrc++-dev libmpfr-doc libmpc-dev texinfo -y

mkdir -p ~/gcc_ws/src
svn checkout svn://gcc.gnu.org/svn/gcc/trunk ~/gcc_ws/src
cd ~/gcc_ws/src
svn co svn://gcc.gnu.org/svn/gcc/tags/gcc_4_6_3_release
cd ~/gcc_ws
mkdir ~/gcc_ws/build
mkdir ~/gcc_ws/install
cd ~/gcc_ws/build
~/gcc_ws/src/configure --with-pkgversion='GCC-ROS-HYDRO' --prefix="/home/$USER/gcc_ws/install" --program-prefix="ros" --disable-multilib
make -j8 && make install

exit 0
