#!/bin/bash

export ROS_INSTALL_DIR=/opt/ros/hydro

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

# install ros_gazebo_pkgs from source
#./ros_gazebo_pkgs/build_ros_gazebo_pkgs.bash
#source ~/.bashrc

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

# install libg2o
./libg2o/install_libg2o.bash
source ~/.bashrc

# install multisense
./multisense/build_multisense.bash
source ~/.bashrc

# install SBPL
./sbpl/build_sbpl.bash
source ~/.bashrc

# setup workspace
./workspace/workspace_setup.bash
source ~/.bashrc

