#!/bin/bash

if [ -d ~/multisense_ws ] ; then
  echo "Multisense already installed"
  exit 0
fi

mkdir -p ~/multisense_ws/src
cd ~/multisense_ws/src
source ~/.bashrc
catkin_init_workspace .
hg clone ssh://hg@bitbucket.org/crl/multisense_ros
cd ..
catkin_make

COUNT=$(grep -a "source /home/$USER/multisense_ws/devel/setup.bash" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo "source /home/$USER/multisense_ws/devel/setup.bash" >> ~/.bashrc
fi

exit 0

