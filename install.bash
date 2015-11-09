#!/bin/bash

export ROS_INSTALL_DIR=/opt/ros/hydro


# build gazebo from source
./gazebo/gazebo_build.bash
source ~/.bashrc

# install ros from source
./ros/ros_build.bash
source ~/.bashrc

# install ros_gazebo_pkgs from source
./ros_gazebo_pkgs/build_ros_gazebo_pkgs.bash
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

# install WPI Atlas dependencies
#./rosinstall_pkgs/rosinstall_deps.bash
#./catkin_deps/install_catkin_deps.bash
#source ~/.bashrc

# setup workspace
./workspace/workspace_setup.bash
source ~/.bashrc

