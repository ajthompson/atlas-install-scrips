#!/bin/bash

echo "Uninstalling..."

# uninstall ASSIMP
if [ -d ~/assimp-3.1.1 ] ; then
  cd ~/assimp-3.1.1

  if [ -d ~/assimp-3.1.1/build ] ; then
    cd build
    sudo make uninstall
  fi

  cd ~
  rm -rf ~/assimp-3.1.1
fi

# uninstall ODE
if [ -d ~/ode ] ; then
  cd ~/ode
  sudo make uninstall
  cd ~
  rm -rf ~/ode
fi

# uninstall OpenRave
if [ -d ~/openrave ] ; then
  cd ~/openrave
  sudo make uninstall
  cd ~
  rm -rf ~/openrave
fi

# uninstall PCL
if [ -d ~/pcl ] ; then
  cd ~/pcl

  if [ -d ~/pcl/build ] ; then
    cd build
    sudo make uninstall
  fi

  cd ~
  rm -rf ~/pcl
fi

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
  sudo rm -rf /home/$USER/ros_catkin_ws
fi

if [ -d /opt/ros/hydro ] ; then
  if [ -h /opt/ros/hydro/setup.bash ] ; then
    echo "ROS setup symlink detected. Removing"
    sudo rm /opt/ros/hydro/setup.bash
  fi

  echo "ROS /opt/ directory detected. Deleting"
  sudo rm -rf /opt/ros/hydro
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

# uninstall gurobi
if [ -d /opt/gurobi605 ] ; then
  sudo rm -rf /opt/gurobi605
fi

if [ -d ~/ros_catkin_deps_ws ] ; then
  rm -rf ~/ros_catkin_deps_ws
fi

if [ -d ~/openrave ] ; then
  

# remove workspace
if [ -d ~/drc_workspace ] ; then
  rm -rf ~/drc_workspace
fi

# remove gurobi
if [ -d ~/g2o ] ; then
  if [ -d ~/g2o/build ] ; then
    cd ~/g2o/build
    sudo make uninstall
  fi

  cd ~
  rm -rf ~/g2o
fi

# remove multisense
if [ -d ~/multisense_ws ] ; then
  rm -rf ~/multisense_ws
fi

# remove sbpl
if [ -d ~/sbpl ] ; then
  if [ -d ~/sbpl/src ] ; then
    cd ~/sbpl/src
    sudo make uninstall
  fi
  cd ~
  rm -rf ~/sbpl
fi

echo "All components uninstalled"

exit 0
