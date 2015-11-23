#!/bin/bash

export ROS_INSTALL_DIR=/opt/ros/hydro
export SCRIPT_DIR=$(pwd)

# install gcc
./gcc/build_gcc.bash
source ~/.bashrc

# install boost
./boost/build_boost.bash
source ~/.bashrc

# install ASSIMP from source
./assimp/build_assimp.bash
source ~/.bashrc

# install ODE from source
./ode/build_ode.bash
source ~/.bashrc

# install openrave from source
./openrave/build_openrave.bash
source ~/.bashrc

# install PCL from source
./pcl/build_pcl.bash
source ~/.bashrc

# build gazebo from source
./gazebo/gazebo_build.bash
source ~/.bashrc

# install ros from source
./ros/ros_build.bash
source ~/.bashrc

# install opencv2 from source
./opencv2/build_opencv2.bash
source ~/.bashrc

# install drcsim from source
./drcsim/build_drcsim.bash
source ~/.bashrc

# install gurobi
./gurobi/install_gurobi.bash
source ~/.bashrc

# install libg2o
./libg2o/install_libg2o.bash
source ~/.bashrc

# install multisense
./multisense/build_multisense.bash
source ~/.bashrc

# install SBPL
./sbpl/build_sbpl.bash
source ~/.bashrc

# install ROS decision making
./decision_making/build_decision_making.bash
source ~/.bashrc

# install octomap
./octomap/build_octomap.bash
source ~/.bashrc

# install octomap_msgs
./octomap_msgs/build_octomap_msgs.bash
source ~/.bashrc

# install octomap_ros
./octomap_ros/build_octomap_ros.bash
source ~/.bashrc

# install PCL ROS packages
./pcl_ros_packages/build_pcl_ros_packages.bash
source ~/.bashrc

# install flycapture
./flycapture/install_flycapture.bash
source ~/.bashrc

# install old ffmpeg
./ffmpeg/build_ffmpeg.bash
source ~/.bashrc

# setup workspace
./workspace/workspace_setup.bash
source ~/.bashrc

