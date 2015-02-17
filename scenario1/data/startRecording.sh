#!/bin/bash

clear

echo "Type experiment name (use only letters and one single string of characters): "
read folder
echo "A folder named $folder will contain all data related to your experiment"
mkdir $folder
cd $folder

echo "Recording will start in 5 seconds. After that you will receive the signal to start moving"

echo "Saving experiment parameters..."
rosparam dump $folder.yaml

echo "Starting recording process, remember it will only record for 8 seconds..."

sleep 5
gnome-terminal --disable-factory --title="RECORDING" -x bash -c "rosbag record -O $folder.bag --duration=8 /camera/depth_registered/points_drop phase_space_markers tf /flexiforce/raw_values; bash" &
PID=$!

sleep 2

echo "----------------------- GO! ---------------------------------"

sleep 8

kill -9 $PID

echo "----------------------- EXPERIMENT IS OVER ------------------"

sleep 3


echo "A bag file was generated with sensor data, check the readme the instructions to play it back."
echo "Farewell"

sleep 3