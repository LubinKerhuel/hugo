---
# Course title, summary, and position.
linktitle: UxV toolbox for Matlab-Simulink
title: UxV toolbox
summary: This toolbox provide matlab script and Simulink blocks. Script allows to decode, plot and feed simulation based on MAVlink log files. Block allows to add MAVLink, GPS, FrSky protocol S.BUS, S.Port and F.Port feature to a model for code generation and is tested with dsPIC MCU. 
weight: 1

tags:
    - rapid prototyping
    - model-based design (MDB)
    - matlab
    - simulink
    - UAV
    - UxV
    - MAVLink
    - GPS
    - FrSky
    - S.BUS
    - S.Port
    - F.Port

# Page metadata.

# date: "2018-09-09T00:00:00Z"
# lastmod: "2018-09-09T00:00:00Z"
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

## Motivation

Rapid Control Prototyping tools enable designing autopilot from simulink model.
This model-based design speed-up the back and forth between simulation and experimental tests.
Experimental logged data are compared against simulation hypothesis and might also feed a simulation allowing further improvements.

The MathWorks Embedded Coder / Simulink Coder generate code for blocks from the Simulink library.
The MPLAB device blocks add peripheral blocks allowing to generate a standalone executable from the model. It also implement a multi-tasking scheduler allowing to benefit efficiently from multi-rate model. 

Intermediate protocol like GPS (NMEA over UART), MAVLink or modern receiver protocol like FrSky S.Bus, S.Port and F.Port can be added using the C function Call block from the MPLAB device block. User must provide the corresponding C implementation or library. This technical requirement breaks simple block drag & drop design process you are typically looking for when using Rapid Control Prototyping tool.

## Features

### Blocks

The UxV toolbox provides blocks for 

- GPS NMEA message decoding,
- MAVLink protocol (packets, WayPoints, Parameters)
- FrSky protocol (S.Bus, S.port, F.port)

Moreover, the MAVLink and FrSky functions benefits from Simulink extra informations like block sampling rate and simulink parameters structure. This allows for example integrating the MAVLink Parameters protocol so as to enable modifying model tunable parameters. Practically, it enable tuning of model tunable parameters on the fly from a MAVLink base station like QGC or Mission Planner.

### Scripts

The UxV toolbox provides scripts:

- mavlink2mat: convert MAVLink log files into .mat format to use with Matlab
- mavlink2kml: extract MAVLink GPS message to generate KML 3D trajectory to view with a google earth/map
- mavlink2simulink:create a simulink model replaying a mavlink log into a simulation
- mavlinkgui: explore converted .mat file through quick plot of various MAVLink message

## Features

### GPS

GPS block support decoding of NMEA messages:

### MAVLink

MAVLink blocks support MAVLink format 0.9 and 1.0. It rely on the MAVLink xml message definition file and can send any MAVLink packet. 
It also support:
- WayPoint Protocol
- Parameters Protocol

### Receiver 

The receiver blocks support
- FrSky S.BUS protocol: receiption of transmitter commands
- FrSky S.Port protocol: Dedicated port to send values to the transmitter through telemetry
- FrSky F.Port protocol: mix both functions of S.BUS and S.Port in one unique port


