#!/bin/bash

# check if it is already installed
if [ -d ~/ros_gazebo_pkgs_ws ] ; then
  echo "ros_gazebo_pkgs has already been installed" 
  exit 0
fi

# create directory and catkin workspace
mkdir -p ~/ros_gazebo_pkgs_ws/src
cd ~/ros_gazebo_pkgs_ws/src
source ~/.bashrc
catkin_init_workspace
cd ~/ros_gazebo_pkgs_ws
catkin_make

# add setup.bash to bashrc
COUNT=$(grep -a "source ~/ros_gazebo_pkgs_ws/devel/setup.bash" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then # not in file
  echo "source ~/ros_gazebo_pkgs_ws/devel/setup.bash" >> ~/.bashrc
fi

source ~/.bashrc

# clone repository and dependencies
cd ~/ros_gazebo_pkgs_ws/src
git clone https://github.com/ros-simulation/gazebo_ros_pkgs.git -b hydro-devel
git clone https://github.com/ros-controls/control_toolbox.git -b hydro-devel
git clone https://github.com/ros-controls/realtime_tools.git -b hydro-devel
git clone https://github.com/ros-controls/ros_control.git -b hydro-devel

# build the packages
cd ~/ros_gazebo_pkgs_ws
catkin_make

exit 0
