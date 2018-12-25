+++
# About/Biography widget.
widget = "about"
active = true
date = 2018-12-25T00:00:00

# Order that this section will appear in.
weight = 2

# List your academic interests.
[interests]
  interests = [
    "Control Theory",
    "Electronics",
    "Embedded projects (UAV)"
  ]

# List your qualifications (such as academic degrees).
[[education.courses]]
  course = "Ph.D Automatic, Signal Processing & Aerial Robotics"
  institution = "National Center for Scientific Research (CNRS) / University Montpellier II"
  year = 2009

[[education.courses]]
  course = "Master of Research - Signal Processing and Digital Communication"
  institution = "University of Nice Sophia-Antipolis"
  year = 2004

[[education.courses]]
  course = "Engineer - System on Chip"
  institution = "ESIEE Paris"
  year = 2004
 
+++

# About me


Interrested in applied math, my university projects were done applied control theory on embedded platforms (UAV). From theses projects, I learned that **~90% of the effort** is concentrated on the **building and low level programming** tasks. Time spent on modelisaiton of the system and control algorithms were reduced if not replaced by a simple PID tuned by successive trials.

I started in 2004 designing a blockset for Simulink. I was able to concentrate on control algorithms running on dsPIC microcontroller unit (MCU) direclty from Simulink model. This model based design was used to complete my PhD thesis on Bioloigcally inspired robotics (fly's visual system) from 2005 to 2009. This scheme reduced drastically the time to convert a Simulink/dSPACE algorithm to our [OSCAR II](https://www.researchgate.net/figure/a-OSCAR-II-like-its-predecessor-OSCAR-I-is-a-tethered-aerial-robot-that-orients-its_fig11_261957721) autonomous robot.

I joined [MOVEA](https://www.ideas-laboratory.com/projects/movea/), a spin-up from CEA-Leti in early 2010 where I designed and implemented Data fusion algorithm for Inertial Measurement Unit and derived applications. We switched from hand writting programming to to the model based design approach which speed-up the research and developpment.

Microchip proposed to developp a blockset similar to the one I did for a wider range of microcontrollers. I am responsible for the [Rapid Control Prototyping tool](https://www.microchip.com/simulinkblocks/) for dsPIC, PIC32 chips at [Microchip Technology Inc](https://www.microchip.com/). 

For scientists, company or students projects, the model based design allows focusing on high level algorithm where added value is. It also typically reduce the time to market for company.  

Theses pages presents projects or informations related to Rapid Control Prototyping tools. All are based on the blockset provided for free by Microchip to target Microchip's microcontrollers directly from Simulink. 
