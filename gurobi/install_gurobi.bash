#!/bin/bash 

if [ -d /opt/gurobi605 ] ; then
  echo "Gurobi already installed"
  exit 0
fi

cd ~/Downloads
wget https://dl.dropboxusercontent.com/u/30063350/gurobi6.0.5_linux64.tar.gz

cd /opt
sudo tar xf ~/Downloads/gurobi6.0.5_linux64.tar.gz
cd ~/Downloads
rm -f gurobi6.0.5_linux64.tar.gz

COUNT=$(grep -a 'export GUROBI_HOME=/opt/gurobi605/linux64' ~/.bashrc | wc -l)
if [ $COUNT -eq 0 ] ; then
  echo 'export GUROBI_HOME=/opt/gurobi605/linux64' >> ~/.bashrc
fi

exit 0
