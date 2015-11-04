#!/bin/bash

# use to enable CUDA - 1 is enabled, 0 is disabled
# using CUDA requires the CUDA libraries and sdk be installed
# 
USE_CUDA=1
GENERATION="Auto" # use Auto unless is specifically doesn't work

CUDA_OPTION=""
if [ $USE_CUDA -eq 1 ] ; then
  CUDA_OPTION="-DWITH_CUDA=ON -DCUDA_GENERATION=${GENERATION}"
fi

# check if the opencv2 directory exists
if [ -d /home/$USER/opencv_ws ] ; then
  echo "OpenCV2 already installed"
  exit 0
fi

# create directory
mkdir ~/opencv_ws
cd ~/opencv_ws

# remove pre-installed ffmpeg and x264
#sudo apt-get -qq remove ffmpeg x264 libx264-dev

# install dependencies
sudo apt-get -qq install libopencv-dev build-essential checkinstall cmake pkg-config yasm libjpeg-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev python-dev python-numpy libtbb-dev libqt4-dev libgtk2.0-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils libbobcat-dev libx264-dev kdelibs5-dev libboost-random-dev libopenscenegraph-dev libboost-all-dev libeigen3-dev python3.4-dev python-pip libsuitesparse-dev libglu-dev libglew-dev gnuplot ffmpeg ffmpeg2theora

#sudo add-apt-repository ppa:mc3man/gstffmpeg-keep
#sudo apt-get update
#sudo apt-get install gstreamer0.10-ffmpeg

# clone and build
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout 2.4.12.3
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=/usr/local -DWITH_TBB=ON $CUDA_OPTION -DBUILD_NEW_PYTHON_SUPPORT=ON -DWITH_V4L=ON -DINSTALL_C_EXAMPLES=ON -DINSTALL_PYTHON_EXAMPLES=ON -DBUILD_EXAMPLES=ON -DWITH_QT=ON -DWITH_OPENGL=ON ..
make -j8 && sudo make install
sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig

exit 0
