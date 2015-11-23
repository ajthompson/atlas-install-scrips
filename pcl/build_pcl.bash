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

# apply patch
patch ~/pcl/io/include/pcl/io/impl/point_cloud_image_extractors.hpp < ${SCRIPT_DIR}/pcl/patch/point_cloud_image_extractors.hpp.patch

mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX="/usr"
make -j8
sudo make install

if [ ! -h /usr/lib/x86_64-linux-gnu/libpcl_common.so ] ; then
  sudo ln -s /usr/lib/lib_pcl_common.so /usr/lib/x86_64-linux-gnu/libpcl_common.so
fi

exit 0
