---
linktitle: block receiver-telemetry
title: block receiver-telemetry
summary: block receiver-telemetry for Simulink
weight: 10

tags:
    - rapid prototyping
    - model based design (MDB)
    - matlab
    - simulink
    - UAV
    - UxV
    - receiver-telemetry
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
        name: receiver-telemetry
        identifier: receiver-telemetry
        weight: 20
         

---

<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

S.Bus, S.Port and F.Port are three protocol used in FrSky receiver.

S.Bus, F.Port and S.Port xxx takes receiver output stream to extract control values sent by the remote. The input stream is a vector which length is defined by end user. All values of the vector do not have to be set. The block use the N input length scalar to know how many bytes from the input vector are received values and must be processed. The block input vector can received partial data packet. The whole receiver packet can be  sliced over time and sent as values are received by the MCU ; these blocks reconstruct the packet before processing it.

## FrSky S.BUS protocol

UART Configuration: 
Only Rx channel is used with the following parameters:

- 100 000 bauds/s 
- Rx inverted logic (Idle state is low level)
- Even parity
- 2 stop bits
- No control flow

Rx is implemented with a Circular Buffer with 64 bytes buffer and interrupt priority 5.


UART Rx block:
    sampled at 1kHz (1ms).
    Vector output size set as inherited via internal rule is assigned to a value of 10 (no more than 10 bytes can be received in 1 ms at 100000 bauds/s)

## FrSky S.Port protocol





## FrSky F.Port protocol


imgs:
uxv-block-fport-gui-control-frame
uxv-block-fport-connect-with-uart


UART configuration:
Rx and Tx channels are used. They are assigned to the same pin. UART is configured for to half duplex.

- 115200 bauds/s
- Half duplex
- Rx and Tx inverted logic (Idle state is low level)
- No parity
- 1 stop bit
- No control flow

Rx is implemented with a Circular Buffer with 32 bytes buffer and interrupt priority 5.

Tx is implemented with a circular buffer with 64 bytes buffer and interrupt priority 5.