---
title: 'Record start/Stop signal for RunCam2 action cam'
subtitle: 'Signal pattern for the USB connector of the RunCam2 to start/stop record'
summary: Signal to remotely start / stop / take a picture on a runCam2 and compatible action cam through the USB connector.
authors:
- Lubin
tags: []
categories: []
date: "2019-05-18"
#lastmod: "2019-04-12T00:00:00Z"
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: 'Top: RunCam 2 action cam with custom 3 wires cable powering the cam and triggering records. Bottom: Cable sold embedding electronic converting RC PWM output to runCam2 trig pulses.'
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: [autopilot-plane]

---
<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}


Cable connecting a RunCam2 action cam to an RC receiver allows to remotely start and stop a record from the receiver PWM output (20ms period, 1ms to 2ms duty cycle).
The cable comprise a component which decode the RC PWM signal and create another signal pulse scheme to start and stop the RunCam2 record.

Controlling the action camera can be done directly from a microcontroller by generating directly the required pulse scheme.

The micro USB cable pinout (on the male part) is

 - Pin 1 : GND
 - Pin 3 : TTL signal
 - Pin 5 : +5V (higher voltage possible for the RunCam2)

When the Camera USB port is set for "Remote Control" and not for "mass storage", a single pulse on the pin 3 of the USB switch back and forth the camera from video mode to photo mode. A double pulse scheme start or stop a recording.

The pulse scheme is the following:
Line is low state at rest when Idle. pulses are 85ms in high state duration separated by 85ms on multiple pulse.

- One pulse switch the camera from video recording mode to Photo mode.
- Two pulses separated with 85ms start or stop a video record (or take a picture in photo mode).


{{< figure
src="/img/runcam2-startstop-simulink-logic.png"
link="/img/runcam2-startstop-simulink-logic.png"
width="100%"
caption="Simulink logic to control a runCam2 action Cam. The integrator reset on each state change of the subsystem input (camera state). Integrator reset is locked if pulses are already being generated. The increment of the integrator generate a double pulse through the binary logic. The generated code were tested on a dsPIC target"
numbered="true"
>}}
