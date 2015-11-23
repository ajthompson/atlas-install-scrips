#!/bin/bash

if [ -d ~/octomap_msgs ] ; then
  echo "Octomap_msgs already installed."
  exit 0
fi

cd ~
mkdir octomap_msgs
cd ~/octomap_msgs
mkdir src
cd src
source ~/.bashrc
catkin_init_workspace .
git clone git@github.com:OctoMap/octomap_msgs.git -b hydro-devel
cd ..
catkin_make

COUNT=$(grep -a "source /home/$USER/octomap_msgs/devel/setup.bash" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo "source /home/$USER/octomap_msgs/devel/setup.bash" >> ~/.bashrc
fi

#if [ ! -e /opt/ros/hydro/include/octomap_ros ] ; then
#  sudo ln -s /opt/ros/hydro/include/octomap_msgs /opt/ros/hydro/include/octomap_ros
#fi

exit 0

