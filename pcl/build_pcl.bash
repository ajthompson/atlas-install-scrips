#1/bin/bash

if [ -d ~/pcl ] ; then
  echo "PCL is already installed"
  exit 0
fi

sudo apt-get install libvtk5-dev libvtk5-qt4-dev

cd ~
git clone git@github.com:PointCloudLibrary/pcl.git
cd pcl
git checkout pcl-1.7.2
mkdir build
cd build
cmake ..
make -j2 && sudo make install

exit 0
