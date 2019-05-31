---
title: 'Air-speed sensor for plane, drone or UAVs.'
subtitle: 'Mechanic, electronic and calibration for a miniature Pitot-Darcy-Prandtl air speed sensor'
summary: Build a miniature pitot-tube with two tubes, one differential pressure sensor and one analog to digital converter integrating the signal conditioning. Calibrate air-speed measurement with a GPS ground speed reference.
authors:
- Lubin
tags: ["Pitot","sensor","air-speed"]
categories: ["Electronics","sensor"]
date: "2019-05-28"
#lastmod: "2019-04-12T00:00:00Z"
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: 'Carbon pitot tube attached to the wing with a magnet.'
  focal_point: "Left"
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: ["autopilot-plane"]

math: true

---
<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

## Principle

A Pitot-Darcy tube is an air speed sensor commonly used in aviation. It consist of a tube pointing in the forward direction. When the sensor move forward a stop pressure is created at its top. A differential pressure is measured between the top of the tube and the ambient pressure. One variant named from its inventor Prandtl tube has static air ports directly on the side of the tube.

The pressure measured is linear to the square of the air speed : $P_t = P_s + \frac{1}{2}\rho v^2$ where $P_t$ and $P_s$ are the pressure in Pa, $\rho$ is the fluid density constant typically in $[1.14 \ 1.34]$ depending on temperature & altitude, and $v$ the speed in $m.s^{-1}$. The differential pressure measured is $P_d = P_t-P_s$.

## Prandtl tube

Prandtl tube is build placing an inner tube within an outer tube. Both tube are centered on their top which are aligned and the space between the tubes is hermetically filled in with a hard enough glue like epoxy. The side of the outer tube is drilled to sense the static pressure. At the bottom of the tube, the inner tube which is longer act as a connector for the dynamic pressure sensor and a tiny tube is added next to create another connector providing access to the static pressure which lies between the two tube.

The static pressure holes should be placed at a minimum distance from the top due to airflow perturbations. A distance 4 times the diameter of the outer tube is retains here.

Any tube can be used. First test were done with brass tube. Inner tube were 1mm inside, 2mm outside. Outer tube was 3mm inside, 4mm outside. A lighter Prandtl tube was made using one inner brass tube (1mm/2mm) with a carbon outer tube (3mm/5mm).

{{< figure 
src="/img/pitot-darcy-prandtl-build-brasstubes.jpg"
link="/img/pitot-darcy-prandtl-build-brasstubes.jpg"
width="80%"
title="Brass inner and outer tubes composing the pitot tube."
caption="Tube alfer from Leroy Merlin. Inner tube is 2mm/1mm. Outer tube is 4mm/3mm (d=4mm).  Outer tube length is m=86mm (21d). Four 1mm width holes are at l=16mm (4d) from the top."
numbered="true"
>}}

References:

- [report](http://naca.central.cranfield.ac.uk/reports/1957/naca-report-1303.pdf) by W.Gracey on the impact of the various shape on the measurement.
- [report (french)](https://www.planete-sciences.org/espace/IMG/pdf/tube_de_pitot.pdf) from ANSTJ with general information on pitot sensor.
- [website (french)](http://voiletech.free.fr/skyassistant/pitot.htm) from Rémi Bourgin with experimental pitot tube for RC plane

<!-- Tube laiton macif (alfer) au Leroy Merlin;

Tube intèrieur: 2mm, trou 1mm
Tube extèrieur: 4mm, trou 3mm

Longueur total:
d = 4mm
l = 4d => 16mm
m = 11d =>44mm

Tube altigator:
d = 4mm
l = 18mm
m = 72mm
-->
 
## Electronics

### Sensitivity requirements and Pressure sensor

The differential pressure measured is vary with the square of the speed. RC plane speed can be quite low. Challenge is to build an electronic sensitive enough to obtain good measurement even in the low speed range.

One sensitive differential pressure sensor available is the [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP) from NXP. It measures differential pressure from 0 to 3.92 kPa and provide a ratiometric analog ouptut swing from 0.6V to 3V (2.4V swing). For reference, 1 kPa correspond to the pressure of 10cm of water.

We are interested in speed range varying from $0$ to $25 m.s^{-1}$ ($90km/h$) which correspond to a maximum differential pressure of 3.75 cm of water, or 0.375 kPa. The MP3V5004DP sensor is used in 10% only of its nominal range.

Table below provide theoretical differential pressure expected for a given speed, using $\rho=1.2$ and $P_{diff} = \frac{1}{2}\rho v^2$.

| Speed (m/s) | (Km/h) | diff pressure (Pa) | ~ H2O level (cm) |
|:-:|:-:|:-:|:-:|
| 1 | 3.6	| 0.6	 |0.006 |
| 2 | 7.2	| 2.4	 |0.024 |
| 4 | 14.4| 	9.6 |	0.096 |
| 7 | 25.2	| 29.4 |	0.294 |
| 10 | 36	| 60	 | 0.6 |
| 15 | 54	| 135	 |1.3 |
| 20 | 72	| 240	 |2.4 |
| 25 | 90	| 375	 |3.75 |
| 30 | 108	| 540	 |5.4 |
| 40 | 144	| 960	 |9.6 |

### Signal conditioning and conversion 

The sensor is deported on the wing. Analog signal transport is to be avoided on such distance for sake of simplicity. The use of the [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) from Microchip provide an integrated solution. It is a high resolution sigma-delta analog to digital converter with four differential input channels. It has an I2C interface and provide a programmable gain on each analog input from 1 to 8. 

The MP3V5004dp output analog signal is connected to the MCP3428 Sigma-Delta ADC through a first order RC low pass filter with a cut off frequency of 28Hz ($R=5.6 kOhm$,$C=1\mu F$). The 2nd differential input is connected on a voltage divisor with 1.2k and 560 ohms to the 3.3V ref and GND. $10\mu F$ decoupling capacitor are used on power supply. The I2C bus lines are pulled up with 10kOhm and are connected to a 10pf capacitor protecting from glitches.

{{< figure 
src="/img/pitot-darcy-prandtl-build-mp3v5004dp-mcp3428.jpg"
link="/img/pitot-darcy-prandtl-build-mp3v5004dp-mcp3428.jpg"
width="80%"
title="Pressure sensor and electronics mounted on a DIP adapter board."
caption="Differential pressure sensor (MP3V5004dp) with Analog to Digital converter integrating a differential amplifier (MCP3428). The MCP3428 communicate with the microcontroller through an I2C BUS. A 3.3V voltage regulator adapt and filter out the 5V input voltage."
numbered="true"
>}}

## Installation

One magnet is glued on the pitot tube. The pitot tube is firmly attached to the plane through a 2nd magnet glued into the wing. It allows the tube to detach stay in place during flight, and detach in case of crash, avoiding possible injury. Flexible tube connecting the sensor to its electronics are fishing tube originally used to protect fish lines.

{{< figure 
src="/img/pitot-darcy-prandtl-tubesoupledecathlon.jpg"
link="/img/pitot-darcy-prandtl-tubesoupledecathlon.jpg"
width="50%"
title="Flashmer - Tube souple 2mm. Image from Decathlon (france)"
caption="Fishing Tube used to connect pressure MP3V5004dp sensor to pitot tube."
numbered="true"
>}}

pitot-darcy-prandtl-tubesoupledecathlon

{{< figure 
src="/img/pitot-darcy-prandtl-wing-brass-mp3v5004dp-mcp3428.jpg"
link="/img/pitot-darcy-prandtl-wing-brass-mp3v5004dp-mcp3428.jpg"
width="80%"
title="Brass pitot tube with its electronic board mounted on the bottom of the right FirStar 1600 wing."
numbered="true"
>}}


{{< figure 
src="/img/pitot-darcy-prandtl-wing-carbon2.jpg"
link="/img/pitot-darcy-prandtl-wing-carbon2.jpg"
width="80%"
title="Carbon-Brass pitot tube attached to the wing with a magnet."
caption="Outer tube is a 5mm carbon tube. Inner tube is a brass 2mm/1mm tube."
numbered="true"
>}}

## Calibration

{{% alert warning %}} 
:vertical_traffic_light: Below is under construction :construction:
{{% /alert %}}

<!--
C:\M91449\MCHP_Blockset\Projects\2017_10_Autopilote\2018_04_12_LogChampdeTir_PitotNum_magOk_LowWind -->