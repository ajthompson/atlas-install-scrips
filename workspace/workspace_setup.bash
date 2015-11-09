#!/bin/bash

if [ -d ~/drc_workspace ] ; then
  echo "Workspace already exists"
  exit 0
fi

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
  echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${ATLAS_ROBOT_INTERFACE}/lib64i:/usr/lib' >> ~/.bashrc
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
  echo 'export GAZEBO_PLUGIN_PATH=~/drc_workspace/src/drc/field/robotiq:$GAZEBO_MODEL_PATH' >> ~/.bashrc
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
sudo apt-get install libeigen3-dev libsuitepasrse-dev freeglut3-dev libglew-dev libboost-all-dev gnuplot

. ~/.bashrc
cd ~/drc_workspace/src
wstool init
wstool set drc git@github.com:WPI-Humanoid-Research-Lab/drc.git --git -y
# Install dependencies
wstool set camera_info_manager_py git@github.com:ros-perception/camera_info_manager_py.git --git -y
wstool set multisense_ros ssh://hg@bitbucket.org/crl/multisense_ros --hg -y
#wstool set libg2o git@github.com:RainerKuemmerle/g2o.git --git -y
. ~/.bashrc
wstool update
. ~/.bashrc

sudo dpkg -i ~/drc_workspace/src/drc/sentis_tof_m100_pkg/m100api-1.0.0-Linux-amd64.deb

cd ~/drc_workspace
catkin_make
. ~/.bashrc

