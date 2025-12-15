---
# Course title, summary, and position.
linktitle: UxV toolbox for Matlab-Simulink
title: UxV toolbox
summary: The UxV toolbox provides matlab script and Simulink blocks for autopilot. Script to decode, visualise MAVlink logs and configure a Simulink model feeding MAVlink signal for simulation. Block adds MAVLink, GPS, and FrSky protocol S.BUS, Smart Port and F.Port feature to a rapid prototyping model used for code generation working with the MPLAB blocks from microchip (targeting dsPIC microcontrollers). 
weight: 1

tags:
    - rapid prototyping
    - model-based design (MBD)
    - matlab
    - simulink
    - UAV
    - UxV
    - MAVLink
    - GPS
    - FrSky
    - S.BUS
    - Smart Port
    - F.Port

# Page metadata.

date: 2019-07-01
# lastmod: "2019-07-01"
draft: false  # Is this a draft? true/false
toc: true  # Show table of contents? true/false
type: docs  # Do not modify.

# Add menu entry to sidebar.
# - name: Declare this menu item as a parent with ID `name`.
# - weight: Position of link in menu.

sitemap:
    priority: 1

menu:
  uxv:
    name: UxV toolbox
    identifier: uxv-toolbox
    weight: 1
---

## Overview

The UxV toolbox for Matlab/Simulink provides Matlab scripts and simulink blocks for UAVs to handle MAVLink protocol, GPS, RC receivers and telemetry protocols.

- Matlab script for post flight data analyses (MAVLink).
- Simulink blocks for autopilote model based design (Rapid Control Prototyping using Simulink)

This model-based design and analysis tools speed-up the back and forth between experimental tests and simulation.

## Matlab scripts for MAVLink

Three main scripts enable decoding MAVLink messages, creating simulink model for simulation based on logged data, and generating map trajectory trace from GPS messages.

| Script           | Input | Output | Function                              |
|------------------|-------|--------|---------------------------------------|
| (1) *mavlink2mat*      | Mavlink log | .mat | matlab analysis   |
| (2) *mavlink2simulink* | Mavlink log | .mat / .mdl (.slx)  | simulation based on real data |
| (3) *mavlink2kml*      | Mavlink log | .kml | plot GPS trace(s) on a map |
| *mavlink2gui*      | Mavlink log | GUI | graphical exploration of mavlink log |


*mavlinkgui* script opens a Graphical User Interface to explore MAVLink data. It list MAVLink messages found in a log file and plot selected {message - value}. Plot script is customizable enabling user to go beyond a simple plot. The GUI provides access to the three scripts mentioned above.


## Simulink blocks

10 added blocks add essential UAV features to implement an autopilot on a dsPIC DSC. These blocks complete the MPLAB blocks for Simulink from Microchip providing peripheral blocks for code generation. These work on top of the MathWorks Embedded Coder.  Added features:

- GPS
  - *GPS Parser* to decode NMEA messages
- MATH
  - *Quaternion to Cardan FxPt* to convert quaternion angle to Cardan angle in fixed point (similar to euler)
- MAVLink:
  - *SEND* (send a message)
  - *RECEIVE* (Receive a message)
  - *MAVLink Data*  (Way Points data)
  - *MAVLink Parser* (decode input message and implement WayPoint[^WayPoint] and Parameter[^Parameter] protocols)
- [Receivers-Telemetry](block-receiver-telemetry)
  - *S.BUS* receive RC channels
  - *Smart Port* send telemetry values
  - *F.Port* receive RC channels + send telemetry
  - *Sensor for Smart.Port or F.Port* set values to send over telemetry[^Telemetry]

Except the MATH block, these blocks are typically connected to the dsPIC UART Rx/Tx block to send/receive the data flow from a GPS, a receiver, a radio link.

## Installation

These blocks are developed by Lubin Kerhuel and distributed for free with the [MPLAB device blocks for Simulink](https://www.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink) from Microchip.

1. Install the MPLAB Device Blocks for Microchip
2. type *pinInfo*, click on *go to Third Part Tools folder*
3. Start script *UxV_Blockset_Installer.p* in the UxV_blockset folder.


[^WayPoint]: *Way Point protocol* allows setting and reading WayPoint from a MAVLink compatible ground station.

[^Parameter]: *Parameter protocol* enable tuning from any MAVLink ground station the Simulink tunable parameters which are normally tuned with External Mode or from the Processor In the Loop simulation (PIL).

[^Telemetry]: *Sensor for Smart.Port or F.Port* block is used with either the *Smart Port* of the *F.Port* block. These protocols allow sending telemetry packets back to the Remote Controller (RC) interface. It enables emulation of Frsky sensor (battery voltage and current, variometer, airspeed, GPS) adding features to your remote easily. They also enable emulation of BetaFlight telemetry. Used with LUA script, this adds features like artificial horizon, air speed, vertical speed, distance from home and many others to your remote (tested with [yaapu LUA scripts](https://github.com/yaapu/FrskyTelemetryScript/wiki)).
