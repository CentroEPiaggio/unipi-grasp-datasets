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
echo "Type [ENTER] key when you are ready to start recording (the record will last only 8 seconds)"
echo "============================================================================================"
read k </dev/tty

gnome-terminal --disable-factory --title="RECORDING" -x bash -c "rosbag record -O ${folder}.bag --duration=8 /camera/depth_registered/points_drop phase_space_markers tf /flexiforce/raw_values; bash" &
PID=$!
echo "Recording..."

sleep 9

echo "============================================"
echo "DONE! Record is finished"
echo "============================================"
kill -9 $PID

echo "Bag files were generated with sensor data, check the readme for instructions to play them back."
echo "Farewell!"

sleep 1
