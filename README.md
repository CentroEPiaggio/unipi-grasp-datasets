# unipi-grasp-datasets

This pacakge contains experiment protocols on how to generate grasp datasets. Everything is based on [ROS Indigo](http://wiki.ros.org/indigo/Installation/Ubuntu)/[Ubunt 14.04](http://releases.ubuntu.com/14.04/). You must have a [catkin workspace](http://wiki.ros.org/catkin/Tutorials/create_a_workspace) configured in order to follow the instructions.

## Equipment & Dependencies

* [PhaseSpace](https://github.com/CentroEPiaggio/phase-space)
* [Asus/Kinect](http://wiki.ros.org/openni2_launch) (install from synaptic/apt-get recommended)
* [F/T](https://github.com/CentroEPiaggio/force-torque-sensor)
* [Intrinsic Tactile Toolbox](https://github.com/CentroEPiaggio/intrinsic-tactile-toolbox)
* [SoftHand](https://github.com/CentroEPiaggio/pisa-iit-soft-hand)
* [Flexiforce Glove](https://github.com/CentroEPiaggio/flexiforce-glove)
* [Calibration](https://github.com/CentroEPiaggio/calibration)
* [PaCManObjectDatabse](https://github.com/pacman-project/pacman-object-database)

You need to add them all to your catkin workspace to compile messages in the sync package.

## Guidelines to create grasp experiment scenarios

- If you use additional equipments or dependencies, please, add the link where to find them in the list above
- Create a package of your scenario using `catkin_create_pkg <scnarioname>` (more arguments can be useful to fill the `package.xml`)
- Follow the template of `scenario1`, create at least these files:
	* `launch/uploadSetup.launch` to bring up all devices
	* `data/startRecording.sh` to define your recording protocol (if possible, record only sensor data and parameters)
	* `launch/playExperiment.launch` to play back recorded data
- IMPORTANT: Do not commit your bag files to this repository! One alternative is to upload your bag files to the [CentroPiaggio server](http://131.114.31.70/) under the `datasets` folder as a single zip, share the file and provide a public link. If you don't have an account, ask to the [technical dept.](http://www.centropiaggio.unipi.it/administrative-staff.html) or your supervisor.
- EVEN MORE IMPORTANT: Document your scenario in a README file and add it to the list below. Fill at least the following two sections:
	* `Experiment protocol` to explain how the experiments must be ran/were ran
	* `How to play the recorded data` to describe how to play the data you obtained and provide download links to your bag files.
- The package `sync_data` allow you to synchronize your data either for recording (not recommended) or for data being played. To this end, you should:
	* Create `msg/<scenarioname>.msg` file to define which type of message you want to synchronize
	* Write a `src/<scnarioname>sync.cpp` node to subscribe to the topics you want to synchronize
	* Create a `launch/<scenarioname>.launch` file to facilitate the use

## Scenarios

### [Scenario 1](scenario1/)

This scenario has been designed to fulfil requirements in WP2 of the [PaCMan](http://www.pacman-project.eu/) project. Check the [README](scenario1/README.md) file to see where to download the data, how was recorded, and how can it be played back.
