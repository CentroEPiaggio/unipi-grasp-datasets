#!/bin/bash

clear
echo "Type experiment name (use only letters and one single string of characters):"
read folder </dev/tty

echo "A folder named $folder will contain all data related to your experiment"
mkdir $folder
cd $folder

echo "Saving experiment parameters..."
rosparam dump $folder.yaml


echo "Press <enter> key to start recording for 10 seconds"
read folder </dev/tty
echo "============================================================================================"
echo "                                        GO!!!"
echo "============================================================================================"

rosbag record -O record.bag --duration=10 cloud_stream video_stream phase_space_markers tf /flexiforce/raw_values 

echo "============================================================================================"
echo "                      DONE Recording, Experiment is finished"
echo "============================================================================================"

echo "Bag files were generated with sensor data, check the readme for instructions to play them back."
echo "Farewell!"

sleep 1
