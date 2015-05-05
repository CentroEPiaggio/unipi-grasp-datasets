# Scenario 1: Human grasping using a handled Pisa/IIT SoftHand

This scenario has been designed for WP2 in the [PaCMan](http://www.pacman-project.eu/) project using the following devices:
* [PhaseSpace](http://www.phasespace.com/)
* [Asus](http://www.asus.com/Multimedia/Xtion_PRO_LIVE/)
* [SoftHand](http://www.qbrobotics.com/#!softhand/c1njg)
* [FlexiforceGlove](https://github.com/CentroEPiaggio/flexiforce-glove)
* Handle for SoftHand
 
The following figure shows the software infrastructure chosen for this scenario. Green connections represent PhaseSpace tracking, red ones the calibration steps and yellow ones represent data being recorded.
<br> <img src="./media/scenario1.png" alt="pacman_wp2_grasp_db" width="800px"/>

## Experiment protocol

0. Connect all devices, use the links in the main [README](../README.md) above for instructions.

1. Change the working directiory, open and work on the data directory `roscd pacman_wp2_grasp_db/data`.

2. Calibrate the asus/phasespace sytems. instructions are in the [README](https://github.com/CentroEPiaggio/calibration/blob/master/README.md) of the [calibration](https://github.com/CentroEPiaggio/calibration) package.

3. Select an object from the [PaCMan Object Databse](https://github.com/pacman-project/pacman-object-database) that is physically available and is included in your object pose estimation software.

4. Calibrate a knwon tracker with the object, instructions are in the [README](https://github.com/CentroEPiaggio/calibration/blob/master/README.md) of the [calibration](https://github.com/CentroEPiaggio/calibration) package.

5. Upload the setup for the experiment, open a different terminal and type `roslaunch pacman_wp2_grasp_db uploadSetup.launch`, and go back to initial terminal. A window should open that allow you to see the processing of the data online.

6. Perform and record grasp actions. The subjects are advised about the recording protocol. The actions are
	- Place the hand at rest position
	- `./startRecording.sh` (please, follow instructions on the terminal and wait for the GO! signal)
	- Grasp the object and lift after the `GO!` signal
	- Wait 2 seconds
	- Replace the object on the table
	- Go to the same rest position and wait until recording process is stopped automatically

7. If you want to try a different grasp on the same object, go to point 6. If you want to change the object, go the second terminal you opened, kill that process, then restart from point 4

Notes on the recorded data:
 - Recall only raw sensor data is recorded in the bag files at their max frequency. 
 - Recall that parameter for each grasp is saved to disk prior the recording to replicate the data processing. 
 - Point clouds are recorded using 1 out of 21 messages at 30Hz, if you want to change this, modify it in the [`uploadSetup.launch`](launch/uploadSetup.launch).

## How to play the recorded data

1. Download grasp database from [here](http://131.114.31.70:8080/share.cgi?ssid=0G3K8vf&fid=0G3K8vf&ep=LS0tLQ==). Uncompress the archives it in the `data` folder. Each subdirectory created represents a single grasp record, the name of such subdirectory is the name of the grasp that needs to be specified in the next step.

2. Type `roslaunch pacman_wp2_db playExperiment.launch name:=NAME`. Where `NAME` is the grasp record name you want to view. This command already loads the parameters used during the experiment.

Please note that you need the [Pacman Object Database](https://github.com/pacman-project/pacman-object-database) in order to correctly visualize object meshes.

If you want to have a specific information being published in a(several) topic(s), you can `ros topic YOUR_TOPIC` and hit `space` to pause the playback at the desired moment, and hit `s` to perform a tiny step on the playback. Check the terminal where you echoed the topic and take the required infromation, for instace, this procedure can be used to have a static grasp captured from the recording.

## How to segment the approach and grasp phase

The joint angles of the hand are measured through the flexiforce-based glove. Raw data of the five sensors is recorded and published in the `/flexiforce/raw_data`. Write a listener to this topic and compute the norm of the vector of raw data, the moment it changes more than a threshold you get the segmentation point.
