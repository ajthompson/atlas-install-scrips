#!/bin/bash

if [ -d ~/ode ] ; then
  echo "ODE is already installed, exiting."
  exit 0
fi

cd ~
hg clone ssh://hg@bitbucket.org/odedevs/ode
cd ode
hg up 0.8
sh autogen.sh
./configure
make && sudo make install

exit 0
