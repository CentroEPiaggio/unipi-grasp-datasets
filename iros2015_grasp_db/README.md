# IROS2015 - submitted: Human grasping using a handled Pisa/IIT SoftHand

This scenario has been designed to create the Grasp database necessary for the ``High-Level Planning for Dual Arm Goal-Oriented Tasks'' work submitted to IROS2015,  using the following devices:
* [PhaseSpace](http://www.phasespace.com/)
* [SoftHand](http://www.qbrobotics.com/#!softhand/c1njg)
* Handle for SoftHand


#### Experiment protocol

ToDo

Notes on the recorded data:
 - Recall only raw sensor data is recorded in the bag files at their max frequency. 
 - Recall that parameter for each grasp is saved to disk prior the recording to replicate the data processing. 
 - Point clouds are recorded using 20 of 21 messages at 30Hz, if you want to change this, modify the [`uploadSetup.launch`](scenario1/launch/uploadSetup.launch).
 - 

#### How to play the recorded data

1. Files containing the data for the IROS2015 submission can be downloaded [here](http://131.114.31.70:8080/share.cgi?ssid=0X5QnTM&fid=0X5QnTM&ep=LS0tLQ==). Uncompress it in the `data` folder.

2. Type `roslaunch scenario1 playExperiment.launch experiment_name:=NAME`. This already loads the parameters used during the experiment.

If you want to have a specific information being published in a(several) topic(s), you can `ros topic YOUR_TOPIC` and hit `space` to pause the playback at the desired moment, and hit `s` to perform a tiny step on the playback. Check the terminal where you echoed the topic and take the required infromation, for instace, this procedure can be used to have a static grasp captured from the recording.