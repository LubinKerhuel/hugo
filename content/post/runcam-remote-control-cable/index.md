---
title: 'Start/Stop signal for RunCam2 action cam'
subtitle: 'Signal on the USB connector of the RunCam2 to start/stop record'
summary: Signal to remotely start / stop / take a picture on a runCam2 and compatible action cam through the USB connector.
authors:
- Lubin
tags: ["Camera"]
categories: ["Sensor"]
date: "2019-05-18"
#lastmod: "2019-04-12T00:00:00Z"
featured: false
draft: false

sitemap:
  priority: 1

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: 'Top: RunCam 2 action cam with custom 3 wires cable powering the cam and triggering records. Bottom: Commercial cable with electronic converting RC PWM output to runCam2 control pulses pattern.'
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

Cable exist to connect a RunCam2 action cam to an RC receiver for remotely start and stop a record from the receiver PWM output (20ms period, 1ms to 2ms duty cycle).
The cable has logic to decode the RC PWM signal and generate the signal pulse scheme to start and stop the RunCam2 record.

Controlling the camera can be done with a microcontroller by generating the required pulse scheme described below.

The micro USB cable pinout (on the male part) is

 - Pin 1 : GND
 - Pin 3 : TTL signal (5V)
 - Pin 5 : +5V (higher voltage possible for the RunCam2 connector)

When the Camera USB port is set for "Remote Control" and not for "mass storage" with the configuration application, it is possible to switch back and forth the camera from video mode to photo mode, and to start/stop recording, or take a picture.

The pulse scheme is the following:

- One pulse switch the camera from video recording mode to Photo mode.
- Two pulses separated with 85ms start or stop a video record (or take a picture in photo mode).

Pulse level is 5V but it works with 3.3V. Line is low state when idle. Pulses are 85ms in high state duration separated by 85ms on multiple pulse.

Tested with a runCam2 powered from a 3S LiPo battery (10 to 14V), no battery in the camera and pulse generated with a 3.3V dsPIC pin configured as digital output.

The figure below is the Simulink diagram with the logic used to generate the appropriate pulse on a dsPIC. Code is generated through the Simulink Coder and the [MPLAB block](https://www.microchip.com/DevelopmentTools/ProductDetails/PartNO/SW007023) from Microchip.

{{< figure
src="/img/runcam2-startstop-simulink-logic.png"
link="/img/runcam2-startstop-simulink-logic.png"
width="100%"
caption="Simulink logic to control a runCam2 action Cam. The subsystem time step resolution is 1ms. The integrator is reset on each state change of the subsystem input, which trig the generation of two 85ms pulse pattern. Integrator reset is locked while pulses are being generated. Logic at the output of the integrator generate the pulses. The generated code was tested on a dsPIC target"
numbered="true"
>}}

