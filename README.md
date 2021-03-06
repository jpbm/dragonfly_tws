# Dragonfly TWS

This is an archive of files and code that was involved in staging 'Dragonfly' at Tokyo Wonder Site in Shibuya in Spring 2017. 

Andreas Greiner's page:
http://www.andreasgreiner.com/works/dragonfly/?%2F=random

(includes video)

## Do NOT attempt to tether drones.
The [tethering] folder contains documentation of the experiments involved in flying the DJI Inspire 1 drone while supplying it with power from a ground tether. Do not attempt to do any of this yourself since there are substantial risks associated with it: if you do this wrong, and there are many ways in which it can go wrong, you can cause the batteries to explode violently, creating a fire that basically cannot be extinguished. Wiring up the power supply involves danger of electrocution and fire. The drone itself can inflict serious injuries through both its rotors and its sheer momentum in flight. The behavior of the drone can become unpredictable when it is flown indoors and on a tether. 

## Streaming/Dreaming
The code used to create a feed of deep-dream modified images was thrown together within minimal time, and leaves much to be desired to say the least. It can be found in the [streaming_dreaming] folder. The basic principle is to get a life feed from the drone using the Youtube streaming API (At the time, the DJI app had issues with custom RTMP servers). We then took screenshots of this feed, which were copied to an Amazon Web Services EC2 GPU instance that was based on the AMI of the Stanford CNN course, which has all the deep learning libraries pre-installed. On that instance, a script continuously checked for new frames, ran it through the Google Deep Dream algorithm, and moved them to an output folder, from which the frames were returned to the local machine. The local machine then ran a primitve Flask server that displayed the frames in the output folder in cycles.

The content of the remote machine was blindly copied into the folder [remote_content] towards the benefit of code archeology.

## Exhibit Photos
Photo Credit/Copyright:
© Tokyo Wonder Site Photo: Ken Kato

Refer to '2017_Condition_for_Use_of_Images_TWS_kato.pdf' for usage conditions.

None of the images from the exhibition may be used for commercial use, publicity or advertising without written consent from Tokyo Wonder Site. 
