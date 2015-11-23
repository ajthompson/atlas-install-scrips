#!/bin/bash

if [ -d ~/drc_workspace ] ; then
  echo "Workspace already exists"
  exit 0
fi

#isudo apt-get install libvtk6-dev
sudo apt-get install libvtk5.8 libvtk5.8-qt4 libvtk5-dev libvtk5-qt4-dev -y

# install libx264-120
cd ~/Downloads
wget -N http://security.ubuntu.com/ubuntu/pool/universe/x/x264/libx264-120_0.120.2151+gita3f4407-2_amd64.deb
sudo dpkg -i libx264-120_0.120.2151+gita3f4407-2_amd64.deb

source ~/.bashrc

mkdir -p ~/drc_workspace/src
cd ~/drc_workspace/src
catkin_init_workspace
cd ~/drc_workspace
catkin_make

COUNT=$(grep -a "source /home/$USER/drc_workspace/devel/setup.bash" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo "source /home/$USER/drc_workspace/devel/setup.bash" >> ~/.bashrc
fi

COUNT=$(grep -a "export ATLAS_ROBOT_INTERFACE=/home/$USER/drc_workspace/src/drc/bdi_api/AtlasRobotInterface" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo "export ATLAS_ROBOT_INTERFACE=/home/$USER/drc_workspace/src/drc/bdi_api/AtlasRobotInterface" >> ~/.bashrc
fi

COUNT=$(grep -a 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${ATLAS_ROBOT_INTERFACE}/lib64:/usr/lib' ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${ATLAS_ROBOT_INTERFACE}/lib64:/usr/lib' >> ~/.bashrc
fi

COUNT=$(grep -a "alias drchome" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo alias drchome="'cd ~/drc_workspace/src/drc/'" >> ~/.bashrc
fi

COUNT=$(grep -a "alias drcmake" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo alias drcmake="'catkin_make install -DCMAKE_INSTALL_PREFIX:PATH=~/drc_workspace/install -C ~/drc_workspace -DCMAKE_BUILD_TYPE=Release'" >> ~/.bashrc
fi

COUNT=$(grep -a "alias drceclipse" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo alias drceclipse="'catkin_make --force-cmake -G\"Eclipse CDT4 - Unix Makefiles\" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_ECLIPSE_MAKE_ARGUMENTS=-j8 -C ~/drc_workspace'" >> ~/.bashrc
fi

COUNT=$(grep -a 'export GAZEBO_PLUGIN_PATH=~/drc_workspace/devel/lib:$GAZEBO_PLUGIN_PATH' ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo 'export GAZEBO_PLUGIN_PATH=~/drc_workspace/devel/lib:$GAZEBO_PLUGIN_PATH' >> ~/.bashrc
fi

COUNT=$(grep -a 'export GAZEBO_MODEL_PATH=~/drc_workspace/src/drc/field/robotiq:$GAZEBO_MODEL_PATH' ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo 'export GAZEBO_MODEL_PATH=~/drc_workspace/src/drc/field/robotiq:$GAZEBO_MODEL_PATH' >> ~/.bashrc
fi

COUNT=$(grep -a 'export PYTHONPATH=~/drc_workspace/src/drc/trajopt/build_trajopt/lib:~/drc_workspace/src/drc/trajopt:$PYTHONPATH' ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo 'export PYTHONPATH=~/drc_workspace/src/drc/trajopt/build_trajopt/lib:~/drc_workspace/src/drc/trajopt:$PYTHONPATH' >> ~/.bashrc
fi

COUNT=$(grep -a 'export OPENRAVE_DATA=${OPENRAVE_DATE}:~/drc_workspace/src/drc/trajopt/' ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo 'export OPENRAVE_DATA=${OPENRAVE_DATE}:~/drc_workspace/src/drc/trajopt/' >> ~/.bashrc
fi 

COUNT=$(grep -a 'alias drctrajopt' ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo alias drctrajopt="'cd ~/drc_workspace/src/drc/trajopt/'" >> ~/.bashrc
fi

# install libg2o

if [ ! -d /opt/ros/hydro/share/libg2o ] ; then
  cd ~/Downloads
  wget http://www.dropbox.com/s/l0q4oc7yuk00t92/if_g2o_is_missed.zip
  unzip if_g2o_is_missed.zip
  sudo mv if_g2o_is_missed/cmake /opt/ros/hydro/share/libg2o/
  rm -rf if_g2o_is_missed
  rm if_g2o_is_missed.zip
fi

# install wrecs-perception deps
sudo apt-get install libeigen3-dev libsuitepasrse-dev freeglut3-dev libglew-dev gnuplot

. ~/.bashrc
cd ~/drc_workspace/src
wstool init
wstool set drc git@github.com:WPI-Humanoid-Research-Lab/drc.git --git -y
# Install dependencies
wstool set camera_info_manager_py git@github.com:ros-perception/camera_info_manager_py.git --git -y
wstool set qt_build git@github.com:stonier/qt_ros.git --git -v hydro -y
#wstool set perception_pcl git@github.com:ros-perception/perception_pcl.git --git -v hydro-devel -y
#wstool set octomap_ros git@github.com:OctoMap/octomap_ros.git --git -v hydro-devel -y

# build the dependencies first
source ~/.bashrc
. ~/.bashrc
wstool update
. ~/.bashrc

sudo dpkg -i ~/drc_workspace/src/drc/sentis_tof_m100_pkg/m100api-1.0.0-Linux-amd64.deb

# make decision_making_parser look for libboost-system

# apply patches
patch ~/drc_workspace/src/drc/decision_making/decision_making_parser/CMakeLists.txt < ${SCRIPT_DIR}/workspace/patch/decision_making_parser/CMakeLists.txt.patch

cd ~/drc_workspace
source ~/.bashrc
#catkin_make -j1 -Dmultisense_ros_DIR="/home/$USER/multisense_ws/devel/share/multisense_ros/cmake" -Dmultisense_lib_DIR="/home/$USER/multisense_ws/devel/share/multisense_lib/cmake" -DOpenRAVE_DIR="/home/$USER/openrave/build/" -Ddecision_making_parser_DIR="/home/$USER/decision_ws/devel/share/decision_making_parser/cmake/" -Doctomap_DIR="/home/$USER/octomap/build/octomap/InstallFiles" -Doctomap_msgs_DIR="/home/$USER/octomap_msgs/devel/share/octomap_msgs/cmake" -Dpcl_conversions_DIR="/home/$USER/pcl_ros_packages/devel/share/pcl_conversions/cmake" -Dpcl_msgs_DIR="/home/$USER/pcl_ros_packages/src/pcl_msgs/cmake" -Dpcl_ros_DIR="/home/$USER/pcl_ros_packages/devel/share/pcl_ros/cmake" -DCMAKE_C_COMPILER="/home/$USER/gcc_ws/install/bin/rosgcc" -DCMAKE_CXX_COMPILER="/home/$USER/gcc_ws/install/bin/rosg++" -DCMAKE_INCLUDE_PATH="/home/$USER/gcc_ws/install/include" -DCMAKE_LIBRARY_PATH="/home/$USER/gcc_ws/install/lib:/home/$USER/gcc_ws/install/lib64"
catkin_make -j1 -Dmultisense_ros_DIR="/home/$USER/multisense_ws/devel/share/multisense_ros/cmake" -Dmultisense_lib_DIR="/home/$USER/multisense_ws/devel/share/multisense_lib/cmake" -DOpenRAVE_DIR="/home/$USER/openrave/build/" -Ddecision_making_parser_DIR="/home/$USER/decision_ws/devel/share/decision_making_parser/cmake/" -Doctomap_DIR="/home/$USER/octomap/build/octomap/InstallFiles" -Doctomap_msgs_DIR="/home/$USER/octomap_msgs/devel/share/octomap_msgs/cmake" -Dpcl_conversions_DIR="/home/$USER/pcl_ros_packages/devel/share/pcl_conversions/cmake" -Dpcl_msgs_DIR="/home/$USER/pcl_ros_packages/src/pcl_msgs/cmake" -Dpcl_ros_DIR="/home/$USER/pcl_ros_packages/devel/share/pcl_ros/cmake"
source ~/.bashrc
