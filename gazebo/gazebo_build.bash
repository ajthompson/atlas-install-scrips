#!/bin/bash

if [ -d /home/$USER/gazebo_build ] ; then  # assume already installed
  echo "Gazebo 6 has already been installed by the script"
  exit 0
fi

# Install gazebo6 from source
GAZEBO_MAJOR_VERSION=4

# values to add to bashrc
LIBRARY_PATH_EXPORT='export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH'
PATH_EXPORT='export PATH=/usr/local/bin:$PATH'
PKG_CONFIG_PATH_EXPORT='export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH'

# install dependencies
# add ppas
sudo apt-add-repository -y ppa:dartsim
sudo apt-add-repository -y ppa:openrave/release
sudo apt-get update

# install packages
sudo apt-get install -y build-essential cmake debhelper mesa-utils cppcheck xsltproc python-psutil python mercurial libboost-system-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev libboost-iostreams-dev libtinyxml-dev ruby1.9.1-dev ruby1.9.1 libxml2-utils ruby-ronn robot-player-dev* collada-dom2.4-dp libbullet-dev libbullet-extras-dev libbulletml-dev

# create directory
mkdir ~/gazebo_build
cd ~/gazebo_build

# build and install ignition math
hg clone https://bitbucket.org/ignitionrobotics/ign-math ~/gazebo_build/ign-math
cd ~/gazebo_build/ign-math
hg up ign-math2
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make -j4 && sudo make install

# build and install sdformat
hg clone https://bitbucket.org/osrf/sdformat ~/gazebo_build/sdformat
cd ~/gazebo_build/sdformat
hg up sdf3
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make -j4 && sudo make install

# build and install gazebo
hg clone https://bitbucket.org/osrf/gazebo ~/gazebo_build/gazebo
cd ~/gazebo_build/gazebo
hg up gazebo4
mkdir build
cd build
cmake ..
make -j4 && sudo make install

# add path's to bashrc
COUNT=$(grep -a "LD_LIBRARY_PATH=/usr/local/lib" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then # not in file
  echo "Adding ${LIBRARY_PATH_EXPORT} to bashrc"
  echo "$LIBRARY_PATH_EXPORT" >> ~/.bashrc
fi

COUNT=$(grep -a "PATH=/usr/local/bin" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then # not in file
  echo "Adding ${PATH_EXPORT} to bashrc"
  echo "$PATH_EXPORT" >> ~/.bashrc
fi

COUNT=$(grep -a "PKG_CONFIG_PATH=/usr/local/lib/pkgconfig" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then # not in file
  echo "Adding ${PKG_CONFIG_PATH_EXPORT} to bashrc"
  echo "$PKG_CONFIG_PATH_EXPORT" >> ~/.bashrc
fi

exit 0

