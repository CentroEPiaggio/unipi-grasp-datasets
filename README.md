# unipi-grasp-datasets

This pacakge contains experiment protocols related to Work Package 2 within the PaCMan project at UNIPI partner.

## Equipment & Dependencies

* [PhaseSpace](https://github.com/CentroEPiaggio/phase-space)
* [Asus/Kinect](http://wiki.ros.org/openni2_launch) (install from synaptic/apt-get recommended)
* [F/T](https://github.com/CentroEPiaggio/force-torque-sensor) & [Intrinsic Tactile Toolbox](https://github.com/CentroEPiaggio/intrinsic-tactile-toolbox)
* [SoftHand](https://github.com/CentroEPiaggio/pisa-iit-soft-hand)
* [Flexiforce Glove](https://github.com/CentroEPiaggio/flexiforce-glove)
* [Calibration](https://github.com/CentroEPiaggio/calibration)
* [PaCManObjectDatabse](https://github.com/pacman-project/pacman-object-database)

## Guidelines to perform grasp experiments

- If you use additional equipments or dependencies, please, add the link where to find them in the list above
- Create a package of your scenario using `catkin_create_pkg <scnarioname>` (more arguments can be useful to fill the `package.xml`)
- Follow the template of `scenario1`, create at least these files:
	* `launch/uploadSetup.launch` to bring up all devices
	* `data/startRecording.sh` to define your recording protocol (if possible, record only sensor data and parameters)
	* `launch/playExperiment.launch` to play back recorded data
- IMPORTANT: Do not commit your bag files to this repository! Upload your bag files to [CentroPiaggio server](http://131.114.31.70/) under the `datasets` folder as a single zip, share the file and provide a public link. If you don't have an account, ask to the [technical dept.](http://www.centropiaggio.unipi.it/administrative-staff.html) or your supervisor.
- EVEN MORE IMPORTANT: Document your scenario in this README file with at least two sections:
	* `Experiment protocol` to explain how the experiments were ran
	* `How to play the recorded data` to describe how to play the data you obtained and provide download links to your bag files.
- The package `sync_data` allow you to synchronize your data either for recording (not recommended) or for data being played. To this end, you should:
	* Create `msg/<scenarioname>.msg` file to define which type of message you want to synchronize
	* Write a `src/<scnarioname>sync.cpp` node to subscribe to the topics you want to synchronize
	* Create a `launch/<scenarioname>.launch` file to facilitate the use

## Experiments and Datasets

### Scenario 1: [PhaseSpace](http://www.phasespace.com/)/[Asus](http://www.asus.com/Multimedia/Xtion_PRO_LIVE/)/[SoftHand](http://www.qbrobotics.com/#!softhand/c1njg)/[FlexiforceGlove](https://github.com/CentroEPiaggio/flexiforce-glove)

#### Experiment protocol

Connect all devices. ToDo description.

0. Work on the data directory `roscd scenario1/data`.

1. Follow the instruction in the [calibration](https://github.com/CentroEPiaggio/calibration) package for the asus-phasespace calibration.

2. Select an object from the database.

3. Perform a tracker-object calibration, instructions at [calibration](https://github.com/CentroEPiaggio/calibration).

4. Upload the setup for the experiment with `roslaunch scenario1 uploadSetup.launch`.

5. Setup the registration environment (ToDo). In the visualization you see processed information, however, only sensor data (raw and calibrated) is recorded in the bag files. Point clouds are recorder using 20 of 21 messages at 30Hz. Parameters are saved to disk prior to recording to replicate the data later.

6. Perform and record grasp actions. The subjects are advised about the recording protocol. The actions are
	- Place the hand at rest position
	- `./startRecording`
	- Wait 2 seconds
	- Grasp the object and lift
	- Wait 2 seconds
	- Replace the object on the table
	- Go to the same rest position
	- Recording will shut down after 8 seconds

7. Select another object and go to point 3 until all objects are grasped.

#### How to play the recorded data

1. Download the [file]() containing all bag files and uncompress it in the `data` folder.

2. Type `roslaunch scenario1 playExperiment.launch experiment_name:=NAME`. This already loads the parameters used during the experiment.

#### How to synchronize the recorded data for later use
