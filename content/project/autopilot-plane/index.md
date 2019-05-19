+++
# Project title.
title = "Auto-pilote for Plane based on simulink"

# Date this page was created.
date = 2019-05-19T00:00:00
draft = false

# Project summary to display on homepage.
summary = "model based design for an RC plane autopilot"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["simulink","matlab","rapid prototyping","model based design","dsPIC","Sliding Mode","autopilot","UAV","mavlink","FrSky","UxV blockset","AUAV V2 board"]

# Optional external URL for project (replaces project detail page).
external_link = ""


share = false  # Show social sharing links?
profile = true  # Show author profile?
comments = false  # Show comments?

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references 
#   `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides = ""

# Links (optional).
url_pdf = ""
url_code = ""
url_dataset = ""
url_slides = ""
url_video = ""
url_poster = ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
#links = [{icon_pack = "fab", icon="twitter", name="Follow", url = "https://twitter.com/georgecushen"}]
links = [
{icon_pack = "fab", icon="", name="Video Calm", url = "https://www.youtube.com/playlist?list=PLaljXZFYAWTM5xUd5nM3107M2cDsQRFC0"},
{icon_pack = "fab", icon="", name="Video Turbulent", url = "https://www.youtube.com/playlist?list=PLaljXZFYAWTPAKykfQDyIEClrdDMl0NDy"}
]

# Featured image
# To use, add an image named `featured.jpg/png` to your project's folder. 
[image]
  # Caption (optional)
  caption = "Firstar 1600 plane"
  
  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = "Smart"
+++

## An autopilot based on rapid control prototyping technics ##

### Motivation ###

Elements to build and test an autopilot for a plane are easy to build from low cost elements:

10 DoF IMU sensor board: 5 $\$$, Pitot tube: 10$\$$, GPS board: 10$\$$, Microcontroller basic board: price depend on the board used (or make a custom one with a less than 5$\$$ mcu), Plane platform: from 60 to 120$\$$ including servo and motors. You also need a receiver and remote control.

It's a great platform for testing various control theory.

### Why a new auto-pilot ? ###

Off the shelf autopilot exists and are likely to works properly. Their parameters can be tuned (PID gains). But testing a different, your own controller on theses requires to understand the code underneath. Even well documented, it represents hundreds of code pages to read, understand before eventually starting any changes.
Added to this analysis work, the structure bench might not fit the requirements for your controller (sampling time, asynchronous event).

The objective for the present autopilot is to use a model based design approach: The autopilot is generated from a single simulink model.

The autopilot controller use standard math blocks and the system low level parts is taken care with the Microchip blockset to drive the microcontroller peripherals and the UxV blockset to easily add features like GPS parser, Remote Control S.BUS, F.Port and Smart Port protocol, Mavlink messaging including Way Point and Parameters protocols.
This rapid prototyping approach allows to "get-in" graphically. It simplify any simulation quick test either based on a simulated plane of based on values logged.

### Hardware list ###

Various combination of material has been tested. Below is elements list providing good results.

- RC platform: Volantex Firstar 1600 with stocks motors and servos (Ranger 1600 is the next platform planed)
- Remote Control: FrSky QX7 remote control
- Receiver: FrSky XSR-M / XSR used with either the S.Bus and S.port protocol or with the F.Port protocol which combine function of both S.bus with S.port saving thus one UART peripheral of the microcontroller.
- Microcontroller: AUAV V2 board with a dsPIC 33EP ; only using the microcontroller: board sensors are outdated, glitch issue with the magnetometers sensor and board is not practical to place near the CG thus too much vibration for sensors. This board is not sold anymore. A custom board with a similar dsPIC might replace it. The UDB5 mini can be found as replacement.
- IMU sensor board: Gy-91 (10 DoF with 3 accelerometers, 3 rate gyro, 3 magnetometers and one barometer). Firmly attached near the CG of the plane reducing thus sensors vibrations. Microcontroller communicate with the Gy-91 through an I2C BUS.
- Pitot tube: 
  - An inner tube and an outer tube on which four hole are done laterally.
  - Signal conditioning: the pitot tube pressure sensor (MPXV 7004 DP) is done with a MCHP ADC converter which integrate an analog amplifier. Converted pressure is sent to the microcontroller through the I2C bus.
- GPS board: based on a uBlox M8N chip which provide up to 10Hz refresh rate and provided best results compared to others chips in the low price range.
- Data logger: openlager board to log on SD card. It allows logging continuous UART output flow with at a baud up to 2 470 000 (much higher than 115 200).
- Radio link: 3DR Sik based Radio module for mavlink telemetry (plane attitude, position, Way Point and Parameters tuning) with qgroundcontrol open source base station on either windows PC or android phone.
- action cam: RunCam2 to film the plane and its surface control from the top; getting a visual behavior of the autopilot in the action.

### Results obtained and next steps ###

#### Results ####

Sliding mode based controller tested in both pitch and roll axis with two mode:

- Control plane angular rate control (angular speed set-point given through the remote control)
- Control plane angle attitude (angle set point provided through the remote control)

Average CPU load was 7 to 8% on a dsPIC 33EP running at 70 MIPS. It includes the IMU estimation algorithm, autopilot control loop and all low tasks (handle various protocols (I2C, NMEA for GPS, F.Port, Mavlink and log sensors data at 1Khz through an UART configured at 24700000)

Tested with strong wind. Showing fairly good robustness despite the low number of parameters tuned so far.

Pitot tube air-speed estimation validated using GPS speed measurement as reference.

Validated the wind speed and direction estimation based on a difference between the GPS and pitot tube speed measurement taking into account the plane orientation.

Validated automatic calibration of the magnetometers axis offset and gain. Once in the air, the magnetic perturbation near the floor are negligible. An algorithm automatically determine if the calibration can be refined using current data (using standard flight input data, no looping or specific roll required).



#### next ####

Reduce chattering on ailerons when sliding mode control is enabled.

Test in flight mavlink protocol parameters tuning.

Add automatic guidance of the plane, using Mavlink Way point sets.


### site content ###

Time constraints does not allow writing a full description of the project as originally expected. Part of projects which I find interesting of inspiring will be shared.

Ideas to expand:

- IMU
- Pitot tube
- Wind estimate
- UxV blocks including GPS, Remote Control and Mavlink blocks and functionalities
