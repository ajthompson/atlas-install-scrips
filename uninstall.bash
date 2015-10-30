#!/bin/bash

echo "Uninstalling..."
# uninstall gazebo
if [ -d /home/$USER/gazebo_build ] ; then
  echo "Gazebo folder detected"
  # uninstall gazebo6
  if [ -d /home/$USER/gazebo_build/gazebo/build ] ; then
    echo "Gazebo build folder detected. Uninstalling"
    cd /home/$USER/gazebo_build/gazebo/build
    sudo make uninstall
  fi

  # uninstall ignition math
  if [ -d /home/$USER/gazebo_build/ign-math/build ] ; then
    echo "Ignition math build folder detected. Uninstalling"
    cd /home/$USER/gazebo_build/ign-math/build
    sudo make uninstall
  fi

  # uninstall sdformat
  if [ -d /home/$USER/gazebo_build/sdformat/build ] ; then
    echo "Sdformat build folder detected. Uninstalling"
    cd /home/$USER/gazebo_build/sdformat/build
    sudo make uninstall
  fi

  cd /home/$USER
  echo "Removing gazebo folder"
  rm -rf /home/$USER/gazebo_build
fi

# uninstall ros
echo "Uninstalling ROS"
if [ -d /home/$USER/ros_catkin_ws ] ; then
  echo "ROS folder detected, removing"
  rm -rf /home/$USER/ros_catkin_ws
fi

exit 0
