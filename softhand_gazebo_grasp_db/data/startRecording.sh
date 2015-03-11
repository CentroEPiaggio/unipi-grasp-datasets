#!/bin/bash

clear
echo "Type experiment name (use only letters and one single string of characters):"
read folder </dev/tty

echo "A folder named $folder will contain all data related to your experiment"
mkdir $folder
cd $folder

echo "Saving experiment parameters..."
rosparam dump $folder.yaml

echo "============================================================================================"
echo "Type [ENTER] key when you are ready to start recording (you must kill the rosbag program)"
echo "============================================================================================"
read k </dev/tty

sleep 1
echo "============================================================================================"
echo "                                        GO!!!"
echo "============================================================================================"

gnome-terminal --disable-factory --title="RECORDING" -x bash -c "rosbag record -O ${folder}.bag phase_space_markers tf" 

echo "============================================================================================"
echo "                      DONE Recording, Experiment is finished"
echo "============================================================================================"

echo "Bag files were generated with sensor data, check the readme for instructions to play them back."
echo "Farewell!"