#!/bin/bash
if [ -d ~/flycapture2-2.7.3.19-amd64 ] ; then
  echo "Flycapture already installed"
  exit 0
fi

sudo apt-get install libraw1394-11 libgtk2.0-0 libglademm-2.4-dev libgtkglextmm-x11-1.2-dev libusb-1.0-0 expect -y

cd ~/Downloads
if [ ! -e ~/Downloads/flycapture2-2.7.3.19-amd64-pkg.tgz ] ; then
  wget -N https://raw.github.com/WPI-Atlas-Lab/AtlasLab/master/flycapture2-2.7.3.19-amd64-pkg.tgz
fi

cd ~
tar xvf ~/Downloads/flycapture2-2.7.3.19-amd64-pkg.tgz
cd flycapture2-2.7.3.19-amd64

echo "Installing flycapture"
./install_flycapture.sh
#expect <<- DONE
#  set timeout -1
#  spawn /bin/bash /home/$USER/flycapture2-2.7.3.19-amd64/install_flycapture.sh
#  match_max 10000
#
#  # look for y/n prompt
#  expect "(y/n)$"
#  send -- "y\r"
#  expect "(y/n)$"
#  send -- "y\r"
#  expect "$"
#  send -- "$USER\r"
#  expect "(y/n)$"
#  send -- "y\r"
#  expect "(y/n)$"
#  send -- "y\r"
#  expect "(y/n)$"
#  send -- "y\r"
#  expect eof
#DONE

rm -f ~/Downloads/flycapture2-2.7.3.19-amd64-pkg.tgz

exit 0
