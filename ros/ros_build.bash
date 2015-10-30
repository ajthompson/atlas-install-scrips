#!/bin/bash
if [ -d /home/$USER/ros_catkin_ws ] ; then
  echo "ROS Hydro already installed"
  exit 0
fi

# install dependencies
sudo apt-get install -y python-pip
sudo pip install -U rosdep rosinstall_generator wstool rosinstall

# initialize rosdep
sudo rosdep init
rosdep update

# build the catkin packages
mkdir ~/ros_catkin_ws
cd ~/ros_catkin_ws

rosinstall_generator desktop_full --rosdistro hydro --deps --wet-only --tar > hydro-desktop-full-wet.rosinstall
wstool init -j8 src hydro-desktop-full-wet.rosinstall

# install dependencies with rosdep
# ignore any errors about opencv2, we'll install our own later
rosdep install --from-paths src --ignore-src --rosdistro hydro -y -r

# remove opencv2 and gazebo_ros_pkgs folder so it doesn't try to build it
# we'll install our own
rm -rf src/opencv2
rm -rf src/gazebo_ros_pkgs

./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release -j8

# source the install
COUNT=$(grep -a "source ~/ros_catkin_ws/install_isolated/setup.bash" ~/.bashrc | wc -l)
if [ COUNT -eq 0 ] ; then
  echo "source ~/ros_catkin_ws/install_isolated/setup.bash" >> ~/.bashrc 
fi

exit 0
