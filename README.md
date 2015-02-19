# unipi-grasp-datasets

This pacakge contains experiment protocols on how to generate grasp datasets. Everything is based on [ROS indigo](http://wiki.ros.org/indigo/Installation/Ubuntu)/[Ubunt 14.04](http://releases.ubuntu.com/14.04/). You must have a [catkin workspace](http://wiki.ros.org/catkin/Tutorials/create_a_workspace) configured in order to follow the instructions.

## Equipment & Dependencies

* [PhaseSpace](https://github.com/CentroEPiaggio/phase-space)
* [Asus/Kinect](http://wiki.ros.org/openni2_launch) (install from synaptic/apt-get recommended)
* [F/T](https://github.com/CentroEPiaggio/force-torque-sensor)
* [Intrinsic Tactile Toolbox](https://github.com/CentroEPiaggio/intrinsic-tactile-toolbox)
* [SoftHand](https://github.com/CentroEPiaggio/pisa-iit-soft-hand)
* [Flexiforce Glove](https://github.com/CentroEPiaggio/flexiforce-glove)
* [Calibration](https://github.com/CentroEPiaggio/calibration)
* [PaCManObjectDatabse](https://github.com/pacman-project/pacman-object-database)

You need to install them all.

## Guidelines to create grasp experiment scenarios

- If you use additional equipments or dependencies, please, add the link where to find them in the list above
- Create a package of your scenario using `catkin_create_pkg <scnarioname>` (more arguments can be useful to fill the `package.xml`)
- Follow the template of `scenario1`, create at least these files:
	* `launch/uploadSetup.launch` to bring up all devices
	* `data/startRecording.sh` to define your recording protocol (if possible, record only sensor data and parameters)
	* `launch/playExperiment.launch` to play back recorded data
- IMPORTANT: Do not commit your bag files to this repository! One alternative is to upload your bag files to the [CentroPiaggio server](http://131.114.31.70/) under the `datasets` folder as a single zip, share the file and provide a public link. If you don't have an account, ask to the [technical dept.](http://www.centropiaggio.unipi.it/administrative-staff.html) or your supervisor.
- EVEN MORE IMPORTANT: Document your scenario in this README file with at least two sections:
	* `Experiment protocol` to explain how the experiments must be ran/were ran
	* `How to play the recorded data` to describe how to play the data you obtained and provide download links to your bag files.
- The package `sync_data` allow you to synchronize your data either for recording (not recommended) or for data being played. To this end, you should:
	* Create `msg/<scenarioname>.msg` file to define which type of message you want to synchronize
	* Write a `src/<scnarioname>sync.cpp` node to subscribe to the topics you want to synchronize
	* Create a `launch/<scenarioname>.launch` file to facilitate the use

## Experiments and Datasets

### Scenario 1: [PhaseSpace](http://www.phasespace.com/)/[Asus](http://www.asus.com/Multimedia/Xtion_PRO_LIVE/)/[SoftHand](http://www.qbrobotics.com/#!softhand/c1njg)/[FlexiforceGlove](https://github.com/CentroEPiaggio/flexiforce-glove)

#### Experiment protocol

0. Connect all devices, use the links above to go directly to their instructions within.

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
 - Point clouds are recorded using 20 of 21 messages at 30Hz, if you want to change this, modify the [`uploadSetup.launch`](scenario1/launch/uploadSetup.launch).
 - 

#### How to play the recorded data

1. Download the [file](http://131.114.31.70:8080/share.cgi?ssid=096EZd5&fid=096EZd5&ep=LS0tLQ==) containing all bag files and uncompress it in the `data` folder.

2. Type `roslaunch scenario1 playExperiment.launch experiment_name:=NAME`. This already loads the parameters used during the experiment.

If you want to have a specific information being published in a(several) topic(s), you can `ros topic YOUR_TOPIC` and hit `space` to pause the playback at the desired moment, and hit `s` to perform a tiny step on the playback. Check the terminal where you echoed the topic and take the required infromation, for instace, this procedure can be used to have a static grasp captured from the recording.

#### How to synchronize the recorded data for later use
