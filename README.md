# pacman-unipi-wp2

This pacakge contains experiment protocols related to Work Package 2 within the PaCMan project at UNIPI partner.

## Equipment & Dependencies

* [PhaseSpace](https://github.com/CentroEPiaggio/phase-space)
* [Asus/Kinect](http://wiki.ros.org/openni2_launch) (install from synaptic/apt-get recommended)
* [F/T](https://github.com/CentroEPiaggio/force-torque-sensor) & [Intrinsic Tactile Toolbox](https://github.com/CentroEPiaggio/intrinsic-tactile-toolbox)
* [SoftHand](https://github.com/CentroEPiaggio/pisa-iit-soft-hand)
* [Flexiforce Glove](https://github.com/CentroEPiaggio/flexiforce-glove)
* [Calibration](https://github.com/CentroEPiaggio/calibration)

## Datasets

### Scenario 1: [PhaseSpace](http://www.phasespace.com/)/[Asus](http://www.asus.com/Multimedia/Xtion_PRO_LIVE/)/[SoftHand](http://www.qbrobotics.com/#!softhand/c1njg)/[FlexiforceGlove](https://github.com/CentroEPiaggio/flexiforce-glove)

#### Experiment protocol

Connect all devices. ToDo description.

1. Follow the instruction in the [calibration](https://github.com/CentroEPiaggio/calibration) package for the asus-phasespace calibration.

2. Select an object from the database.

3. Perform a tracker-object calibration, instructions at [calibration](https://github.com/CentroEPiaggio/calibration).

4. Upload the setup for the experiment with `roslaunch scenario1 uploadSetup.launch`.

5. Setup the registration environment (ToDo). In the visualization you see processed information, however, only sensor data (raw and calibrated) is recorded in the bag files. Parameters are saved to disk.

6. Perform and record the action. Subjects must:
	- Play the hand at rest position and wait for 2 seconds (start recording).
    - Grasp the object and lift it for 2 seconds.
	- Replace the object on the table and go to the same rest position for 2 seconds (stop recording).

7. Select another object and go to point 3 until all objects are grasped.

#### How to play the recorded data

1. Download the [file]() containing all bag files and uncompress it in the `data` folder.

2. Type `roslaunch scenario1 playData.launch file:=FILENAME`. This already loads the parameters used during the experiment.

#### How to synchronize the recorded data for use

