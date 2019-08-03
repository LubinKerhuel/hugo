---
linktitle: block Sensor
title: block Sensor
summary: The Sensor block set sensor ID and data values to send to the remote through telemetry. Data are sent to the receiver either through the F.Port or through a Smart Port.
weight: 10

tags:
    - rapid prototyping
    - model based design (MDB)
    - matlab
    - simulink
    - UAV
    - UxV
    - Sensor
    - F.Port
    - Smart Port
    - block


#aliases = ["project/inverted_pendulum_flywheels/"]

draft: false  # Is this a draft? true/false
toc: true  # Show table of contents? true/false
type: docs  # Do not modify.

#date = 2018-09-09T00:00:00
#lastmod = 2018-09-09T00:00:00

# math: true

# date = 2018-09-09T00:00:00
# lastmod = 2018-09-09T00:00:00

# GitRepo = "hugo"

sitemap:
    priority: 1

# Add menu entry to sidebar.
# parent = "inverted_pendulum_flywheels"
menu:
    uxv:
        parent: blocks
        name: sensor
        identifier: sensor
        weight: 25
         

---
<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

Each sensor block added in the model declare a new sensor whose value will be sent to the receiver. The receiver send then the sensor Id and the corresponding values to the remote through telemetry.

Communication with the receiver can use either the Smart Port, or the F.Port.

The sensor PhyId, APPID and APPID Offset variant are set within the block.
The PRIM field must be set to 0X10 for a sensor. The sensor value unit is set within the block.
Block input is the 4 bytes codint for the sensor value. 