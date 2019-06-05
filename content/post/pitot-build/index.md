---
title: Air-speed sensor for plane, drone or UAVs.'
subtitle: 'Mechanic, electronic, test of a miniature Pitot-Darcy-Prandtl air speed sensor embedded in an RC plane'
summary: DIY miniature pitot-tube with tubes, a differential pressure sensor and an analog to digital converter. Calibrate air-speed measurement embedded in an RC plane with a GPS ground speed reference. Estimate wind strenght and direction fusing GPS data with pitot output.
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

sitemap:
  priority: 1

math: true

highlight: true
# hilight style parameters set in config.toml
# Matlab style set by default.
#highlight_languages:
#  -matlab  # Add support for highlighting additional languages

---
<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

## Principle

A Pitot-Darcy tube is an air speed sensor commonly used in aviation. It consists of a tube pointing in the forward direction. When the sensor moves forward a stop pressure is created at its top. A differential pressure is measured between the top of the tube and the ambient pressure. One variant named from its inventor Prandtl tube has static air ports directly on the side of the tube.

The pressure measured is linear to the square of the air speed : $P_t = P_s + \frac{1}{2}\rho v^2$ where $P_t$ and $P_s$ are the pressure in Pa, $\rho$ is the fluid density constant typically in $[1.14 \ 1.34]$ depending on temperature & altitude, and $v$ the speed in $m.s^{-1}$. The differential pressure measured is $P_d = P_t-P_s$.

## Prandtl tube

Prandtl tube is made of an inner tube placed within an outer tube. At their top, both tubes are centered. Space between the two tubes is hermetically filled in with an epoxy adhesive (Araldite or equivalent) on few mm near the top. The side of the outer tube is drilled to sense the static pressure. At the bottom, the inner tube which is longer act as a connector for the dynamic pressure sensor and a tiny tube is added next to create another connector to the static pressure which lies in the empty space between the two tube.

The static pressure holes should be placed at a minimum distance from the top due to airflow perturbations. A distance 4 times the diameter of the outer tube is retains here.

First test was done using brass tube. Inner tube is 1mm inside, 2mm outside. Outer tube was 3mm inside, 4mm outside. A lighter pitot tube was tested using one inner brass tube (1mm/2mm) with a carbon outer tube (3mm/5mm).

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
- [website (French)](http://voiletech.free.fr/skyassistant/pitot.htm) from Rémi Bourgin with experimental pitot tube for RC plane

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

The differential pressure measured vary with the square of the speed. RC plane speed can be quite low. Challenge is to be sensitive enough to obtain good measurement even in the low speed range of few meters per seconds.

The [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP) from NXP is a sensitive differential pressure sensor. Its differential measurement range goes from 0 to 3.92 kPa. The analog output is ratio-metric and swing from 0.6V to 3V ($\DeltaV =2.4V$). For reference, 1 kPa is approximately the pressure of 10cm of water.

We are interested in speed range varying from $0$ to $25 m.s^{-1}$ ($90km/h$) which correspond to a maximum differential pressure of 3.75 cm of water, or 0.375 kPa. The MP3V5004DP sensor is used in 10% of its nominal range.

Table below provide theoretical differential pressure expected for various speed using $P_{diff} = \frac{1}{2}\rho v^2$ with $\rho=1.2$.

| v (m/s) | v (Km/h) | $P_{diff}$ (Pa) | ~ $H_2O$ (cm) | [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP) & [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428)  (0.2041Pa / LSB) |
|:-:|:-:|:-:|:-:|:-:|
| 1 | 3.6	| 0.6	 |0.006 | 3 |
| 2 | 7.2	| 2.4	 |0.024 | 12 |
| 4 | 14.4| 	9.6 |	0.096 | 47 |
| 7 | 25.2	| 29.4 |	0.294 | 144 |
| 10 | 36	| 60	 | 0.6 | 294 |
| 15 | 54	| 135	 |1.3 | 661 |
| 20 | 72	| 240	 |2.4 | 1176 |
| 25 | 90	| 375	 |3.75 | 1837 |
| 30 | 108	| 540	 |5.4 | 2646 |
| 40 | 144	| 960	 |9.6 | *4704* (4095 sat) |

### Signal conditioning and conversion 

The pressure sensor is placed close (~10cm) to the pitot tube on the wing. The analog to digital conversion is also done on site to avoid noise pollution of analog signal. The [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) from Microchip is a high resolution sigma-delta converter with four differential inputs and a programmable gain factor from 1 to 8. It has a digital I2C interface to connect to the dsPIC. 

The [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP) output analog signal is connected to the [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) Sigma-Delta ADC through a first order RC low pass filter with a cut off frequency at $28Hz$ ($R=5.6 kOhm$,$C=1\mu F$). The 2nd differential input is connected on a voltage divisor with 1.2k and 560 ohms to the 3.3V ref and GND. $10\mu F$ decoupling capacitor are used on power supply. The I2C bus lines are pulled up with 10kOhm and are connected to a 10pf capacitor protecting from glitches.

{{< figure 
src="/img/pitot-darcy-prandtl-build-mp3v5004dp-mcp3428.jpg"
link="/img/pitot-darcy-prandtl-build-mp3v5004dp-mcp3428.jpg"
width="80%"
title="Pressure sensor and electronics mounted on a DIP adapter board."
caption="Differential pressure sensor (MP3V5004dp) with Analog to Digital converter integrating a differential amplifier (MCP3428). The MCP3428 communicate with the microcontroller through an I2C BUS. A 3.3V voltage regulator adapt and filter out the 5V input voltage."
numbered="true"
>}}

### Sensor static tests

A 90 minutes lasting measurement is performed indoor without movements. Sensor output were logged at 100Hz. The figure below shows a slow drift. The sensor standard deviation measured on the overall measurement is 0.54 Pa (including the drift).

{{< figure 
src="/img/pitot-darcy-prandtl-static-characteristic.png"
link="/img/pitot-darcy-prandtl-static-characteristic.png"
width="100%"
title="Differential Sensor static characteristics"
caption="90 minutes lasting static measurement indoor shows a slow drift and a standard deviation of 0.54 Pa."
numbered="true"
>}}

The sensor is sensitive to its own orientation. Moving the sensor up-side down create an offset of (100 LSB; to be checked :construction: ).

## Installation

A 2mm flexible tube originally used to protect fish lines connect the pitot tube with the sensor.

{{< figure 
src="/img/pitot-darcy-prandtl-tubesoupledecathlon.jpg"
link="/img/pitot-darcy-prandtl-tubesoupledecathlon.jpg"
width="50%"
title="Flashmer – flexible Tube 2mm. Image from Decathlon (france)"
caption="Fishing Tube used to connect pressure MP3V5004dp sensor to pitot tube."
numbered="true"
>}}

One magnet is glued on the pitot tube. The pitot tube is attached to the plane through a 2nd magnet integrated into the wing. This flexible solution allows the tube to stay in place during flight, eject in case of hard landing reducing damages and is practical for storage and transportation.

{{< figure 
src="/img/pitot-darcy-prandtl-wing-brass-mp3v5004dp-mcp3428.jpg"
link="/img/pitot-darcy-prandtl-wing-brass-mp3v5004dp-mcp3428.jpg"
width="100%"
title="Brass pitot tube with its electronic board mounted on the bottom of the right Firstar 1600 wing."
numbered="true"
>}}

{{< figure 
src="/img/pitot-darcy-prandtl-wing-carbon2.jpg"
link="/img/pitot-darcy-prandtl-wing-carbon2.jpg"
width="60%"
title="Carbon-Brass pitot tube attached to the wing with a magnet."
caption="Outer tube is a 5mm carbon tube. Inner tube is a brass 2mm/1mm tube."
numbered="true"
>}}

## Results

### Comparison with GPS ground speed

The pitot tube differential pressure is converted to speed with $V=\sqrt{\frac{2}{\rho}*P_{diff}}$ with $\rho = 1.2$.

Matlab script converting raw MCP3428 to Pressure (Pa) and Speed (m/s):

```matlab
% Pitot Calibration. P_pitot is the raw MCP3428 sensor output read from I2C bus.
P_pitot_cal =  0.2041* (double(P_pitot) + 1800);	% to Pa unit

% Compute Speed (m/s) from diff pressure (in Pa).
V_pitot = sqrt(max(0,(2/1.2) * P_pitot_cal));
```

The Ground Speed (GPS) and the Air Speed (pitot) measurements are theoretically similar in absence of wind. In presence of a constant wind, the direction and strength can be estimated combining the airspeed with the ground speed and the plane yaw direction.

With the wind strength and direction known, the airplane ground speed (GPS) is obtained by adding the projected wind to the aircraft forward direction to the air speed (pitot). The figure below presents the air speed in dashed blue. The air-speed measurement shows a good sensitivity even at low speed. The reconstructed ground speed (thin black line) matches with the GPS ground speed (large grey line) which prove the accuracy of the measurement. The estimation of the wind strength and direction is described [below](#wind-estimation).

 {{< figure 
src="/img/pitot-darcy-prandtl-gps-wind-estimation.png"
link="/img/pitot-darcy-prandtl-gps-wind-estimation.png"
width="100%"
title="GPS Speed over ground (large grey), Pitot air-speed (dashed blue) with parameter $\rho=1.2$. Pitot air-speed minus constant wind estimation (black curve)"
caption="GPS (grey curve) and Pitot minus Wind (black curve) matches. Data log of the first 200s of the Firstar 1600 RC plane flight. On the black curve, the pitot is averaged and undersampled by group of 5 samples reducing its sampling rate from 250Hz to 50Hz. The GPS ground speed is correctly estimated based on the pitot tube measurement."
numbered="true"
>}}

The remaining error might be sensor error, but also wind gust and GPS accuracy limitation particularly at estimating vertical speed changes (During flight, the plane speed was change through rapid dive to test the pitot tube on a wide range).

### Wind estimation

The comparison of the pitot tube with the GPS ground speed require to estimate the wind strength and direction.  

The curve below shows the difference between the Ground speed (GPS) with the air speed (pitot) in function of the plane flight direction. This error (blue dashed points) fit with a sine wave which is the offset added by a wind constant in strength and direction.

{{< figure 
src="/img/pitot-darcy-prandtl-speed-error-fct-direction.png"
link="/img/pitot-darcy-prandtl-speed-error-fct-direction.png"
width="100%"
title="GPS ground speed and pitot air speed difference in function of the plane direction during the 450s flight of a Firstar 1600."
caption="Blue dots are speed difference between GPS and pitot. The continuous black line is the wind sine wave (phase is wind direction; amplitude is wind strength) which best match the air speed and ground speed differences. Pitot values are averaged and under-sample by a factor 5."
numbered="true"
>}}

#### Script

Matlab script used for off-line wind estimation:

```matlab
% V_gps and V_pitot are the vector with all data measured.
V_err = V_gps - V_pitot;    % Ground and Air speed difference (i.e. wind) 

M = [sin(COG); cos(COG) ]'; % COG is the direction (Theta in rad) vector data measured from the GPS
y = -V_err';
x = M\y;    % estimate wind strength and direction with linear algebra (MMSE)

Theta_Wind = atan2(x(1),x(2));  % Wind angle (rad)
V_Wind = sqrt(sum(x(1:2).^2));  % Wind strength (m/s)
```

#### Limitation

Using the GPS COG[^COG] field is not the plane yaw direction but the plane forward direction. Thus the COG is a biased plane yaw direction. It would be best to use plane orientation from the IMU sensor. It is not done here to reduce the number of sensors for this demonstration. The COG bias is small enough if we assume the wind speed to be small compared to the airplane air speed. It might be possible with a more sophisticated script to compensate this bias.



<!--
C:\M91449\MCHP_Blockset\Projects\2017_10_Autopilote\2018_04_12_LogChampdeTir_PitotNum_magOk_LowWind -->

[^COG]: Course Over Ground