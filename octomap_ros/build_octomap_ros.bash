#!/bin/bash
if [ -d ~/octomap_ros ] ; then
  echo "octomap_ros already installed"
  exit 0
fi

mkdir -p ~/octomap_ros/src
cd ~/octomap_ros/src
source ~/.bashrc
catkin_init_workspace .
git clone git@github.com:OctoMap/octomap_ros.git -b hydro-devel
cd ..
catkin_make -Dpcl_conversions_DIR="/home/$USER/pcl_ros_packages/devel/share/pcl_conversions/cmake" -Dpcl_msgs_DIR="/home/$USER/pcl_ros_packages/devel/share/pcl_msgs/cmake" -Dpcl_ros_DIR="/home/$USER/pcl_ros_packages/devel/share/pcl_ros/cmake"

COUNT=$(grep -a "source /home/$USER/octomap_ros/devel/setup.bash" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo "source /home/$USER/octomap_ros/devel/setup.bash" >> ~/.bashrc
fi

if [ ! -e /opt/ros/hydro/include/octomap_ros ] ; then
  sudo ln -s /home/$USER/octomap_ros/src/octomap_ros/include/octomap_ros /opt/ros/hydro/include/octomap_ros
fi

exit 0

