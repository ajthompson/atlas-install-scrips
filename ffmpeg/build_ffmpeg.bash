#!/bin/bash

if [ -d ~/FFmpeg ] ; then
  echo "FFmpeg is already installed."
  exit 0
fi

cd ~
git clone git@github.com:FFmpeg/FFmpeg.git -b release/0.11
cd ~/FFmpeg
./configure
make && sudo make install

