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
if [ -d /home/$USER/ros_catkin_ws ] ; then
  echo "ROS folder detected, removing"
  rm -rf /home/$USER/ros_catkin_ws
fi

if [ -d /opt/ros/hydro ] ; then
  if [ -h /opt/ros/hydro/setup.bash ] ; then
    echo "ROS setup symlink detected. Removing"
    sudo rm /opt/ros/hydro/setup.bash
  fi
fi

# uninstall ros_gazebo_pkgs
if [ -d /home/$USER/ros_gazebo_pkgs_ws ] ; then
  echo "ros_gazebo_pkgs detected, removing"
  rm -rf /home/$USER/ros_gazebo_pkgs_ws
fi

# uninstall opencv
if [ -d /home/$USER/opencv_ws ] ; then
  if [ -d /home/$USER/opencv_ws/build ] ; then
    echo "OpenCV installed. Uninstalling"
    cd /home/$USER/opencv_ws/build
    sudo make uninstall
  fi

  echo "OpenCV folder found. Removing"
  sudo rm -rf /home/$USER/opencv_ws
fi

if [ -d /home/$USER/drcsim_ws ] ; then
  echo "DRCsim folder found. Removing"
  rm -rf /home/$USER/drcsim_ws
fi

echo "All components uninstalled"

exit 0
