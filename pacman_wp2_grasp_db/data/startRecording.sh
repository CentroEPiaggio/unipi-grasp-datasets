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

gnome-terminal --disable-factory --title="RECORDING" -x bash -c "rosbag record -O ${folder}.bag --duration=15 /cloud_stream /video_stream phase_space_markers tf /flexiforce/raw_values; bash" &
PID=$!
echo "Recording..."
echo "15"
sleep 1
echo "14"
sleep 1
echo "13"
sleep 1
echo "12"
sleep 1
echo "11"
sleep 1
echo "10"
sleep 1
echo "9"
sleep 1
echo "8"
sleep 1
echo "7"
sleep 1
echo "6"
sleep 1
echo "5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1

echo "============================================================================================"
echo "                      DONE Recording, Experiment is finished"
echo "============================================================================================"

echo "Bag files were generated with sensor data, check the readme for instructions to play them back."
echo "Farewell!"

sleep 1
