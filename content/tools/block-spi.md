+++
title = "SPI block"

# date = 2018-09-09T00:00:00
# lastmod = 2018-09-09T00:00:00

draft = true  # Is this a draft? true/false
toc = true  # Show table of contents? true/false
type = "docs"  # Do not modify.

GitRepo = "hugo"

# Add menu entry to sidebar.
# parent = "inverted_pendulum_flywheels"
[menu.tools]
    name = "SPI"
    identifier = "SPI"
    weight = 10
    

+++

<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

The SPI block send/receive SPI frame between the targeted dsPIC / PIC32 a sensor.
The SPI driver use interrupt to keep the main task running while handling SPI tasks in background.

The Block output provides the SPI read values received during the previous time step. First value read is undefined and typically 0.
The `blocking mode` option blocks the execution of the simulink scheduler until completion of the SPI transfer started by this block. When enabled, the block output are Block output provides the values received during this SPI transfer.

Several SPI block can use the same SPI peripheral. Using multiple SPI blocks allows:

- execute SPI frame (combination of read/write) at various sample time.
- Conditionally send SPI frame

Particularly, if one SPI frame must be sent once to initialize a sensor, one SPI block with a sample time set to **inf** ($\inf$) is placed on the model with the initialisation sequence for that sensor.

{{% callout note %}}
The output of a SPI block set with "inf" sample time will not output the expected value. If SPI sequence providing a block output must be executed only once, use a trigger mechanism and do not use the "inf" sample time.
{{% /callout %}}

The SPI blocks allows to modify the configuration of the SPI peripheral in the middle of any sequence. 
Add the `Update-Configuration` command. Then the parameters from the *SPI Bus Parameters* (Clock Speed, SPI mode, number of bits...) can be modified.
The initial configuration is not automatically set back at the end of the sequence. Make sure to add a $2nd$ *Update-Configuration* to leave the SPI bus setting to its initial configuration. 
When selecting the command in the sequence list, the GUI updates the SPI BUS parameters to reflect the current SPI bus setting. 




##### MPLAB, dsPIC and PIC32 are registered trademark by Microchip.

