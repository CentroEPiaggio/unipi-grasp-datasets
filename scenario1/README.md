# Scenario 1

This scenario has been designed for WP2 in the [PaCMan](http://www.pacman-project.eu/) project using the following devices:
* [PhaseSpace](http://www.phasespace.com/)
* [Asus](http://www.asus.com/Multimedia/Xtion_PRO_LIVE/)
* [SoftHand](http://www.qbrobotics.com/#!softhand/c1njg)
* [FlexiforceGlove](https://github.com/CentroEPiaggio/flexiforce-glove)


## Experiment protocol

0. Connect all devices, use the links above to go directly to the instructions within.

1. Change the working directiory, open and work on the data directory `roscd scenario1/data`.

2. Calibrate the asus/phasespace sytems. instructions are in the [README](https://github.com/CentroEPiaggio/calibration/blob/master/README.md) of the [calibration](https://github.com/CentroEPiaggio/calibration) package.

3. Select an object from the [PaCMan Object Databse](https://github.com/pacman-project/pacman-object-database) that is physically available and is included in your object pose estimation software.

4. Calibrate a knwon tracker with the object, instructions are in the [README](https://github.com/CentroEPiaggio/calibration/blob/master/README.md) of the [calibration](https://github.com/CentroEPiaggio/calibration) package.

5. Upload the setup for the experiment, open a different terminal and type `roslaunch scenario1 uploadSetup.launch`, and go back to initial terminal. A window should open that allow you to see the processing of the data online.

6. Perform and record grasp actions. The subjects are advised about the recording protocol. The actions are
	- Place the hand at rest position
	- `./startRecording.sh` (please, follow instructions on the terminal and wait for the GO! signal)
	- Grasp the object and lift after the `GO!` signal
	- Wait 2 seconds
	- Replace the object on the table
	- Go to the same rest position and wait until recording process is stopped automatically

7. If you want to try a different grasp on the same object, go to point 6. If you want to change the object, go the second terminal you opened, kill that process, go to point 23

Notes on the recorded data:
 - Recall only raw sensor data is recorded in the bag files at their max frequency. 
 - Recall that parameter for each grasp is saved to disk prior the recording to replicate the data processing. 
 - Point clouds are recorded using 20 of 21 messages at 30Hz, if you want to change this, modify it in the [`uploadSetup.launch`](scenario1/launch/uploadSetup.launch).

## How to play the recorded data

1. Download the [file](http://131.114.31.70:8080/share.cgi?ssid=0ERQVxL&fid=0ERQVxL&ep=LS0tLQ==) containing all bag files and uncompress it in the `data` folder.

2. Type `roslaunch scenario1 playExperiment.launch experiment_name:=NAME`. This already loads the parameters used during the experiment.

If you want to have a specific information being published in a(several) topic(s), you can `ros topic YOUR_TOPIC` and hit `space` to pause the playback at the desired moment, and hit `s` to perform a tiny step on the playback. Check the terminal where you echoed the topic and take the required infromation, for instace, this procedure can be used to have a static grasp captured from the recording.

## How to synchronize the recorded data

## How to segment the approach and grasp phase

The joint angles of the hand are measured through the flexiforce-based glove. Raw data of the five sensors is recorded and published in the `/flexiforce/raw_data`. Write a listener to this topic and compute the norm of the vector of raw data, the moment it changes more than a threshold you get the segmentation point.
