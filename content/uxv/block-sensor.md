---
linktitle: block Sensor
title: block Sensor
summary: The Sensor block set sensor ID and data values to send to the remote through telemetry. Data are sent to the receiver either through the F.Port or through a Smart Port.
weight: 10

tags:
    - rapid prototyping
    - model based design (MBD)
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

The block add a sensor "packet" to be transmitted to a receiver through the Smart Port of the F.Port. The receiver send the telemetry packet to the Remote controller (RC). Thus the Simulink should have either a Smart Port or a F.Port block.

Each sensor block declare the sensor reference composed of the two parameters PhysId and {Address+Offset}. Sensor value is composed of 4 bytes array block input. Multiple instance of the sensor block can be added in a model. Two instance can have the same sensor reference wihch is used for sensor sending multiple packets with various values (see FrSky FVLSS or GPS sensor).

Each block instance add a 4 bytes buffer to store the sensor value which is updated at block execution time. The block sample rate defines the update rate of the internal buffer.

The behaviour vary between Smart Port and F.Port protocol:

### behaviour with Smart Port

The receiver ping the electronics connected on Smart Port for one sensor reference. When a given sensor is ping, it must reply by providing its 4 bytes values within 3ms. 

If more than one instance of the sensor block address the same sensor reference (PhysId, Address+Offset), each blocks data packet are sent one after another.

- If a specific sensor Id is ping twice with his (none of his when multiple) block beeing updated in between, the same content is sent again.
- If a sensor block is updated while its previous content has not been sent yet, the block update has no effect and the newer value is lost. 

### behaviour with F.Port

The unique controller connected to the F.Port send a sensor value each RC channel packet received. The sensor to be send depends only on the controller which might send any sensor.

Each sensor block update add the sensor in a FIFO queue list of sensor request to send.
Only one request for each sensor block instance can be present in this FIFO.

- If a sensor block is updated while its previous value has not been sent yet ; this block sensor request to send is still in the FIFO, then the update has no effect and the newer value is lost.

Unlike the Smart Port, a sensor cannot be sent twice without having been updated once first because the sensor is placed in the send request FIFO while being updated.


for its corresponding sensor
 The block update sample rate is selected by end user.    whose value will be sent to the receiver. The receiver send then the sensor Id and the corresponding values to the remote through telemetry.

Communication with the receiver can use either the Smart Port, or the F.Port.

The sensor PhyId, APPID and APPID Offset variant are set within the block.
The PRIM field must be set to 0X10 for a sensor. The sensor value unit is set within the block.
Block input is the 4 bytes codint for the sensor value. 