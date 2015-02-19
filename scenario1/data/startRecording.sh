#!/bin/bash

clear
echo "Type experiment name (use only letters and one single string of characters):"
read folder </dev/tty

echo "A folder named $folder will contain all data related to your experiment"
mkdir $folder
cd $folder

echo "Saving experiment parameters..."
rosparam dump $folder.yaml

echo "====================================================================="
echo "Type [ENTER] key when you are ready to start recording approach phase"
echo "====================================================================="
read k </dev/tty

gnome-terminal --disable-factory --title="RECORDING_APPROACH" -x bash -c "rosbag record -O ${folder}_APP.bag /camera/depth_registered/points_drop phase_space_markers tf /flexiforce/raw_values; bash" &
PID=$!
echo "Recording approach..."

echo "============================================"
echo "Type [ENTER] key when you are ready to grasp"
echo "============================================"
read key </dev/tty
kill -9 $PID

echo "Recording grasp..."

gnome-terminal --disable-factory --title="RECORDING_GRASP" -x bash -c "rosbag record -O ${folder}_GRP.bag /camera/depth_registered/points_drop phase_space_markers tf /flexiforce/raw_values; bash" &
PID=$!

echo "================================================="
echo "Type [ENTER] key to stop recording the experiment"
echo "================================================="
read key </dev/tty
kill -9 $PID

rosbag reindex ${folder}_*.bag.active -f -q
mv ${folder}_APP.bag.active ${folder}_APP.bag
mv ${folder}_GRP.bag.active ${folder}_GRP.bag
rm ${folder}_APP.bag.orig.active ${folder}_GRP.bag.orig.active

echo "Bag files were generated with sensor data, check the readme for instructions to play them back."
echo "Farewell!"

sleep 1
