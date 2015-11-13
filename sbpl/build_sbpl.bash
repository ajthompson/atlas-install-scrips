#!/bin/bash

if [ -d ~/sbpl ] ; then
  echo "SBPL already installed"
  exit 0
fi

cd ~
git clone git@github.com:sbpl/sbpl.git
cd sbpl
mkdir build
cd build
cmake .. && sudo make install

#mkdir -p ~/sbpl_ws
#cd ~/sbpl_ws/src
#source ~/.bashrc
#catkin_init_workspace .
#git clone git@github.com:sbpl/sbpl.git
#cd ..
#catkin_make

#COUNT=$(grep -a "source /home/$USER/sbpl_ws/devel/setup.bash" ~/.bashrc | wc -l)
#if [ $COUNT -eq 0 ] ; then
#  echo "source /home/$USER/sbpl_ws/devel/setup.bash" >> ~/.bashrc
#fi

exit 0

