#!/bin/bash

echo "Uninstalling..."

# uninstall gcc
if [ -d ~/gcc_ws ] ; then
  rm -rf ~/gcc_ws
  echo "Custom GCC uninstalled."
fi

# uninstall boost
if [ -d ~/boost_ws/boost_1_52_0 ] ; then
  cd ~/boost_ws/boost_1_52_0
  sudo ./b2 uninstall
  cd ~
  rm -rf ~/boost_ws
  echo "Custom boost uninstalled."
fi

# uninstall ASSIMP
if [ -d ~/assimp-3.1.1 ] ; then
  cd ~/assimp-3.1.1

  if [ -d ~/assimp-3.1.1/build ] ; then
    cd build
    sudo make uninstall
  fi

  cd ~
  rm -rf ~/assimp-3.1.1
  echo "ASSIMP uninstalled"
fi

# uninstall ODE
if [ -d ~/ode ] ; then
  cd ~/ode
  sudo make uninstall
  cd ~
  rm -rf ~/ode
  echo "ODE uninstalled."
fi

# uninstall OpenRave
if [ -d ~/openrave ] ; then
  cd ~/openrave
  sudo make uninstall
  cd ~
  rm -rf ~/openrave
  echo "OpenRave uninstalled."
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
  echo "PCL uninstalled."
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
  echo "Gurobi removed."
fi

if [ -d ~/ros_catkin_deps_ws ] ; then
  rm -rf ~/ros_catkin_deps_ws
fi  

# remove workspace
if [ -d ~/drc_workspace ] ; then
  rm -rf ~/drc_workspace
  echo "DRC workspace uninstalled."
fi

# remove libg2o
if [ -d ~/g2o ] ; then
  if [ -d ~/g2o/build ] ; then
    cd ~/g2o/build
    sudo make uninstall
  fi

  cd ~
  rm -rf ~/g2o
  echo "libg2o removed."
fi

# remove multisense
if [ -d ~/multisense_ws ] ; then
  rm -rf ~/multisense_ws
  echo "Multisense removed."
fi

# remove sbpl
if [ -d ~/sbpl ] ; then
  if [ -d ~/sbpl/src ] ; then
    cd ~/sbpl/src
    sudo make uninstall
  fi
  cd ~
  rm -rf ~/sbpl
  echo "SBPL removed."
fi

# uninstall decision making
if [ -d ~/decision_ws ] ; then
  rm -rf ~/decision_ws
  echo "ROS decision making uninstalled."
fi

if [ -d ~/octomap ] ; then
  rm -rf ~/octomap
  echo "Octomap uninstalled."
fi

if [ -d ~/octomap_msgs ] ; then
  rm -rf ~/octomap_msgs
  echo "Octomap messages uninstalled."
fi

if [ -d ~/octomap_ros ] ; then
  rm -rf ~/octomap_ros
  echo "Octomap ROS uninstalled."
fi

if [ -d ~/pcl_ros_packages ] ; then
  rm -rf ~/pcl_ros_packages
  echo "PCL ROS packages uninstalled."
fi

if [ -d ~/flycapture2-2.7.3.19-amd64 ] ; then
  cd ~/flycapture2-2.7.3.19-amd64
  ./remove_flycapture.sh
  cd ~
  rm -rf ~/flycapture2-2.7.3.19-amd64
  echo "Flycapture uninstalled"
fi

if [ -d ~/FFmpeg ] ; then
  cd ~/FFmpeg
  sudo make uninstall
  cd ~
  rm -rf ~/FFmpeg
  echo "Old ffmpeg uninstalled."
fi

echo "All components uninstalled"

exit 0
