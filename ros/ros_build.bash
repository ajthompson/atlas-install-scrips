#!/bin/bash
if [ -d /home/$USER/ros_catkin_ws ] ; then
  echo "ROS Hydro already installed"
  exit 0
fi

# install dependencies
sudo apt-get install -y python-pip python-rosdep python-rosinstall-generator python-wstool python-rosinstall build-essential

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

# clone in dependencies to build
sudo ./src/catkin/bin/catkin_make_isolated --install --install-space ${ROS_INSTALL_DIR} -DCMAKE_BUILD_TYPE=Release -j8

# source the install
COUNT=$(grep -a "source /opt/ros/hydro/setup.bash" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo "source /opt/ros/hydro/setup.bash" >> ~/.bashrc 
fi

# if it doesn't already exist, symlink /opt/ros/hydro/setup.bash to ~/ros_catkin_ws/install_isolated/setup.bash
#if [ ! -d /opt/ros/hydro ] ; then
#  sudo mkdir -p /opt/ros/hydro
#fi

#if [ ! -h /opt/ros/hydro/setup.bash ] ; then
#  sudo ln -s /home/$USER/ros_catkin_ws/install_isolated/setup.bash /opt/ros/hydro/setup.bash
#  sudo chmod +x /opt/ros/hydro/setup.bash
#fi

exit 0
