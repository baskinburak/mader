#!/bin/bash
# Author: Jesus Tordesillas Torres

#This file should be called from the root of the workspace 

#Example: If the structure is
# ws --> src --> mader
# This file should be called from the directory ws

source ~/.bashrc

#Ask for the password
sudo echo "-----------------------" 

path_to_ws=$(pwd)


#INSTALL CGAL v4.14.2
##########################################

#INSTALL python-catkin-tools (to be able to use catkin build)
##########################################
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get install python-catkin-tools -y

#CLONE SUBMODULES, INSTALL DEPENDENCIES AND COMPILE
##########################################
cd $path_to_ws/src/mader && git submodule init && git submodule update && cd ../../
rosdep install --from-paths src --ignore-src -r -y
catkin config -DCMAKE_BUILD_TYPE=Release
catkin build #GLPK will be installed when the `separator` package is compiled (see its CMakeList.txt)
echo "source $path_to_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc
