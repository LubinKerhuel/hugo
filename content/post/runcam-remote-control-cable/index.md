---
title: 'Record start/Stop signal for RunCam2 action cam'
subtitle: 'Signal on the USB connector of the RunCam2 to start/stop record'
summary: Signal to remotely start / stop / take a picture on a runCam2 and compabile action cam through the USB connector.
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
projects: []

---

<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

Cable are sold so as to be able to start and stop a record on a RunCam2 action camera from a PWM receiver signal from a receiver.

Controlling the action camera can be done straight from the microcontroller.

The micro USB cable pinout (on the male part) is

 - pin 1 : GND
 - Pin 3 : TTL signal
 - Pin 5 : +5V (higher voltage possible for the RunCam2)

When the Camera USB port is set for "Remote Control" and not for "mass storage", a single pulse coding scheme on the USB pin allows to start/stop a recording, and also to switch the camera from video mode to photo mode.

The coding scheme is the following:
Line is low state in Idle. Any pulse is a 85ms high state high state duration.

One single pulse switch the camera from video recording mode to Photo mode.
Two pulses separated with 85ms start or stop a video record (or take a picture in photo mode).
 


{{< figure
src="/img/runcam2-startstop-simulink-logic.png"
link="/img/runcam2-startstop-simulink-logic.png"
width="100%"
caption="Simulink logic to control a runCam2 actoin Cam. Model gererating code tested with a dsPIC. The integrator is resetted for each state change of subsystem input (camera state). While the integrator output is increasing, a double pulse is generated through threshold and binary logic."
numbered="true"
>}}
