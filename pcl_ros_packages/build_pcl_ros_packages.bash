#!/bin/bash

if [ -d ~/pcl_ros_packages ] ; then
  echo "PCL ROS packages are already installed."
  exit 0
fi

cd ~
mkdir -p ~/pcl_ros_packages/src
cd ~/pcl_ros_packages/src
source ~/.bashrc
catkin_init_workspace .
git clone git@github.com:ros-perception/pcl_conversions.git -b hydro-devel
git clone git@github.com:ros-perception/perception_pcl.git -b hydro-devel
git clone git@github.com:ros-perception/pcl_msgs.git -b hydro-devel
cd ..
catkin_make

cp ~/pcl_ros_packages/devel/share/pcl_msgs/cmake ~/pcl_ros_packages/src/pcl_msgs/

COUNT=$(grep -a "source /home/$USER/pcl_ros_packages/devel/setup.bash" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo "source /home/$USER/pcl_ros_packages/devel/setup.bash"
fi

exit 0

