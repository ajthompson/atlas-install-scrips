#!/bin/bash

if [ -d ~/ros_catkin_deps_ws ] ; then
  echo "ROS catkin dependencies have already been installed"
  exit 0
fi

mkdir -p ~/ros_catkin_deps_ws/src
cd ~/ros_catkin_deps_ws/src
source ~/.bashrc
catkin_init_workspace
cd ~/ros_catkin_deps_ws
catkin_make

COUNT=$(grep -a "source ~/ros_catkin_deps_ws/devel/setup.bash" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo "source ~/ros_catkin_deps_ws/devel/setup.bash" >> ~/.bashrc
fi

source ~/.bashrc

cd ~/ros_catkin_deps_ws/src
git clone git@github.com:ros-perception/image_common.git -b hydro-devel

# build the packages
cd ~/ros_catkin_deps_ws
catkin_make

exit 0

