#!/bin/bash

if [ -d ~/ros_packages ] ; then
  echo "ROS packages already installed"
  exit 0
fi

mkdir ~/ros_packages

rosinstall ~/ros_packages /opt/ros/hydro

COUNT=$(grep -a 'source ~/ros_packages/setup.bash' ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo 'source ~/ros_packages/setup.bash' >> ~/.bashrc
fi

PACKAGES="image-common"
# roslocate the packages

for package in $PACKAGES
do
  roslocate info $package > ${package}.rosinstall
  rosinstall ~/ros_packages ${package}.rosinstall
done

exit 0
