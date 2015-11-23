#!/bin/bash

if [ -d ~/decision_ws ] ; then
  echo "ROS decision making already installed."
  exit 0
fi

mkdir -p ~/decision_ws/src
cd ~/decision_ws/src
source ~/.bashrc
catkin_init_workspace .
git clone git@github.com:cogniteam/decision_making.git
cd ..
catkin_make

COUNT=$(grep -a "source /home/$USER/decision_ws/devel/setup.bash" ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo "source /home/$USER/decision_ws/devel/setup.bash" >> ~/.bashrc
fi

exit 0

