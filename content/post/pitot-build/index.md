---
title: Miniature airspeed sensor for RC plane and UAVs.
subtitle: "A Pitot static (Prandtl) airspeed sensor embedded in an RC plane: Parts, Electronic and Performances."

# Project summary to display on homepage.
summary: Build and test of a miniature Pitot static (Prandtl) tube. Parts and electronic design are described. In flight airspeed performance is compared to a GPS ground speed used as reference. Wind speed is estimated to remove bias between airspeed and ground speed.

authors:
- Lubin

tags: 
  - Pitot
  - sensor
  - air-speed
  - wind
  - experiment
  - DIY

categories: 
  - electronics
  - sensor

date: 2019-05-28
lastmod: 2019-05-25
featured: true
draft: false

slides: pitot-build

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: Carbon Pitot-tube attached to the wing with a magnet.
  focal_point: Left
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: 
  - autopilot-plane

sitemap:
  priority: 1

math: true

# problem with embedded math due to _ character. use \_, or activate mmark markup syntax
# markup: mmark

highlight: true
# hilight style parameters set in config.toml
# Matlab style set by default.
#highlight_languages:
#  -matlab  # Add support for highlighting additional languages

---
<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

{{% toc %}}

## Pitot tube principle

A Pitot-Darcy probe is an airspeed sensor commonly used in aviation. It consists of a tube pointing in the forward direction. When the sensor moves forward a stop pressure $P\_t$ is added at its tip. The differential pressure $P\_{diff}$ is measured between the tip of the tube $P\_t$ and the static pressure $P\_s$. One variant named from its inventor Prandtl tube has static air ports directly on the side of the tube.

The pressure added at tube tip is the square of the airspeed : $P\_t = P\_s + \frac{1}{2}\rho v^2$ where $ P\_t $ and $P\_s$ are measured in Pascal unit (Pa). $\rho$ is the air density constant typically in $[1.14 \ 1.34]$ depending on temperature & altitude. $v$ is the airspeed in $m.s^{-1}$. The differential pressure measured is $P\_{diff} = P_t - P_s = \frac{1}{2}\rho v^2$ 

## Pitot-Prandtl tube

Prandtl tube is one version of a Pitot probe where an inner tube is placed in the center of an outer tube. Space between the two tubes is filled-in on few mm near the tip with an epoxy adhesive (Araldite or equivalent). The side of the outer tube is drilled to sense the static pressure. At the bottom, the inner tube which is longer act as a connector for the dynamic pressure sensor and third short tube is added to create a connector to the static pressure area which lies in the empty space between the two tube.

The static pressure holes must be drilled at a minimum distance from the tube tip where airflow perturbations are reduced. A distance 4 times the diameter (d=4mm)of the outer tube is retains here (16mm). Four 1mm holes were drilled with a Dremel hand tool. The three tubes are presented on the figure below.

First test was done using brass tubes. Inner tube width is 2/1mm (outside/inside) and outer tube is 4/3mm.

{{< figure 
src="/img/pitot-darcy-prandtl-build-brasstubes.jpg"
link="/img/pitot-darcy-prandtl-build-brasstubes.jpg"
width="80%"
title="Brass inner and outer tubes of the Pitot tube."
caption="Tube alfer from Leroy Merlin. Inner tube is 2mm/1mm. Outer tube is 4mm/3mm.  Outer tube length is m=86mm. Four 1mm holes are drilled at l=16mm from the tip."
numbered="true"
>}}

References:

- [report WIND-TUNNEL INVESTIGATION OF 'A NUMBER OF TOTAL-PRESSURE TUBES AT HIGH ANGLES OF ATTACK SUBSONIC, TRANSONIC, AND SUPERSONIC SPEEDS'](https://ntrs.nasa.gov/api/citations/19930092297/downloads/19930092297.pdf) by W.Gracey on the impact of the various shape on the measurement.
- [report (french)](https://www.planete-sciences.org/espace/IMG/pdf/tube_de_pitot.pdf) from ANSTJ with general information on Pitot sensor.
- [website (French)](http://voiletech.free.fr/skyassistant/pitot.htm) from Rémi Bourgin with experimental Pitot tube for RC plane

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

The [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP#/) from NXP is a sensitive differential pressure sensor. Its differential measurement range goes from 0 to 3.92 kPa. The analog output is ratio-metric and swing from 0.6V to 3V ($\Delta V =2.4V$). For reference, 1 kPa is approximately the pressure of 10cm of water.

We are interested in speed range varying from $0$ to $25 m.s^{-1}$ ($90km/h$) which correspond to a maximum differential pressure of 3.75 cm of water, or 0.375 kPa. The MP3V5004DP sensor is used in 10% of its nominal range.

Table below provide theoretical differential pressure expected for various speed using $P_{diff} = \frac{1}{2}\rho v^2$ with $\rho=1.15$.

| v (m/s) | v (Km/h) | $P_{diff}$ (Pa) | ~ $H_2O$ (cm) | [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP#/) & [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428)  (0.2041Pa / LSB[^LSB]) |
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

The pressure sensor electronics is placed in the wing close (~10cm) to the Pitot tube. The analog to digital conversion is integrated in the sensor board. The [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) from Microchip is a high resolution sigma-delta converter with a programmable gain factor from 1 to 8. It has a digital I2C bus interface and its I2C address can be selected. Similar DAC to consider are MCP342x, the newer MCP346x family or the MCP356x providing increased accuracy and higher sampling rate but its package is smaller thus more difficult to handle for a DIY project.

The [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP#/) output analog signal is connected to the [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) Sigma-Delta ADC through a first order RC low pass filter with a cut off frequency at $28Hz$ ($R=5.6 kOhm$,$C=1\mu F$). The 2nd differential input is connected on a voltage divisor to obtain 1V from the 3.3V reference (480 & 1kOhms). $10\mu F$ decoupling capacitor are used on power supply. The I2C bus wires are pulled up with 10kOhm and are connected to a 10pf capacitor protecting from glitches.
<!-- Measured 480 840 for the divisor. Write down 560 and 1.2k -->

The [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) Sigma-Delta ADC is configured for 

- 12 bits
- x8 Gain
- 240 Samples Per Seconds (SPS)

The resulting resolution is provided from:

- (1) [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP#/) Analog output sensitivity is 1633 Pa/V
- (2) [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) 12 bits with a gain of 8 : 0.125mV/LSB[^LSB]

With (1) and (2), we obtain a resolution of $1633 * 0.125e^{-3} $ =  ***0.2041 Pa / LSB[^LSB]*** 

{{< figure 
src="/img/pitot-darcy-prandtl-build-mp3v5004dp-mcp3428.jpg"
link="/img/pitot-darcy-prandtl-build-mp3v5004dp-mcp3428.jpg"
width="80%"
title="Pressure sensor and electronics mounted on a DIP adapter board."
caption="Differential pressure sensor (MP3V5004dp) with Analog to Digital converter integrating a differential amplifier (MCP3428). The MCP3428 communicate with the microcontroller through an I2C BUS. A MCP1700 3.3V voltage regulator adapt and filter out the 5V input voltage."
numbered="true"
>}}

### Sensor static tests

A 90 minutes lasting measurement is performed indoor without movements. Sensor output were logged at 100Hz. The figure below shows a slow drift (correlated with temperature or battery decay ? TBD). The sensor standard deviation measured on the overall measurement is 0.54 Pa (including the drift).

{{< figure 
src="/img/pitot-darcy-prandtl-static-characteristic.png"
link="/img/pitot-darcy-prandtl-static-characteristic.png"
width="100%"
title="Experimental pitot-tube static characteristic with the MP3V5004dp differential pressure sensor"
caption="90 minutes lasting static measurement indoor shows a slow drift and a standard deviation of 0.54 Pa. Resolution is 0.2041 Pa / LSB"
numbered="true"
>}}

#### possible noise/offset sources

The sensor is sensitive to its own orientation. Flipping the sensor up-side down creates an negative offset of 12.5mV (100 LSB[^LSB] with the analog to digital circuit setting).

MCP5398 and MP3V5004dp are both powered with 3.3V. A linear voltage regulator ([MCP 1700](https://ww1.microchip.com/downloads/en/DeviceDoc/20001826D.pdf)) filter-out the 5V sensor board input to 3.3V. The analog signal remains however sensitive to fluctuation on the 5v input. Particular attention should be taken with telemetry which pollute power supply if they do not have their dedicated regulator. Also the electromagnetic burst from telemetry module might pollute the overall electronic including the ground; A periodic burst correlated with MAVLink packets sent was noticed on pitot output (20 to 300 LSB, nothing noticed on IMU sensors) caused by a 3DR telemetry module when its antenna is placed too close to non protected electronics part. Problem solved by moving the antenna away and reducing the Tx emitting power.

## Flight setup

The sensor is mounted on the wing of a FirStar 1600 RC plane.

{{< figure 
src="/img/firstar1600-qx7.jpg"
link="/img/firstar1600-qx7.jpg"
width="80%"
title="FirStar 1600 Volantex RC plane"
caption="Platform used for tests"
numbered="true"
>}}

A 2mm flexible tube, originally for protecting fish lines, connect the sensor to the Pitot tube.

{{< figure 
src="/img/pitot-darcy-prandtl-tubesoupledecathlon.jpg"
link="/img/pitot-darcy-prandtl-tubesoupledecathlon.jpg"
width="50%"
title="Flashmer – flexible Tube 2mm. Image from Decathlon (france)."
caption="Fishing Tube used to connect the differential pressure MP3V5004dp sensor to Pitot tube."
numbered="true"
>}}

One magnet is glued on the Pitot tube. A 2nd magnet integrated in the wing allows to fix the Pitot tube. Both magnet are in contact. The tube stays firmly in place during flights and ejects in case of hard landing reducing damages. It is a flexible solution for testing other Pitot tube design ; It's also practical for storage and transportation.

{{< figure 
src="/img/pitot-darcy-prandtl-wing-brass-mp3v5004dp-mcp3428.jpg"
link="/img/pitot-darcy-prandtl-wing-brass-mp3v5004dp-mcp3428.jpg"
width="100%"
title="Brass Pitot tube with its electronic board mounted onboard the Firstar 1600 fixed wing platform."
numbered="true"
>}}

{{< figure 
src="/img/pitot-darcy-prandtl-wing-carbon2.jpg"
link="/img/pitot-darcy-prandtl-wing-carbon2.jpg"
width="60%"
title="Carbon-Brass light Pitot tube sensor attached to the wing with a magnet."
caption="Outer tube is a 5/3mm carbon tube. Inner tube is a brass 2mm/1mm tube."
numbered="true"
>}}

## Experimental results

The MCP3428 samples $P\_{diff}$ at 250Hz during flights. $V\_{Pitot}=\sqrt{\frac{2}{\rho}*P\_{diff}}$ with $\rho = 1.15$.

No calibration were required. Sensor theoretical output scaling were used with the formula to compute the speed from the pressure. $\rho$ value was tune from a default value 1.2 to 1.16 which minimized the mean error however the improvement was not a big deal. The only value to adjust is the raw pressure measurement offset (zero). The zero value for the sensor used is -1800. 

Matlab script converting 250Hz raw MCP3428 to Pressure (Pa) and Speed (m/s):

```matlab
% Pitot Calibration. P_pitot is a vector with raw MCP3428 output read from I2C bus.
P_pitot_cal =  0.2041* (double(P_pitot) + 1800);	% to Pa unit

% Compute Speed (m/s) from diff pressure (in Pa).
V_pitot = sqrt(max(0,(2/1.15) * P_pitot_cal));
```

### Comparison with GPS ground speed {#gps-vs-airspeed}

In calm condition, the ground speed $V\_{GPS}$ and airspeed $V\_{Pitot}$ are equal.

In windy condition, wind average direction and strength are estimated combining $V\_{GPS}$, $V\_{Pitot}$ and the plane yaw $\Theta\_{heading}$ direction (using GPS COG[^COG]). This  [wind estimation](#wind-estimation) is described below.

The airplane ground speed (GPS) is estimated with the difference of the airspeed (Pitot) with the projected wind to the aircraft forward direction:

 $V\_{GPS} \approx V\_{Pitot} - V_{wind}*cos(\Theta\_{heading} + \Theta\_{wind}) $

The figure below presents the airspeed in blue. The reconstructed ground speed (black) matches accurately with the GPS velocity (red) which prove the correctness of the airspeed measurement as well as the wind strength and direction. The onshore wind is laminar with limited turbulences. The airspeed measurement presents a high  sensitivity even at low speed.

{{< figure 
src="/img/pitot-darcy-prandtl-gps-wind-calibration.png"
link="/img/pitot-darcy-prandtl-gps-wind-calibration.png"
width="100%"
title="Experimental measurement comparing GPS ground speed with pitot-tube airspeed on 200s of a Firstar 1600 RC plane flight. Match between the GPS ground speed and the the pitot tube subtracted from the estimated wind."
caption="GPS Speed over ground (red). Pitot airspeed (blue) computed with $\rho=1.15$. Reconstructed up-front wind (green). Pitot airspeed minus wind estimated (black) where $V\_pitot$ is averaged and under-sampled by a factor 5 reducing its sampling rate from 250Hz to 50Hz. Up-front wind is estimated from the GPS COG angle ($\approx \theta\_{heading}$), and the estimated wind strength ($V\_{wind}= 2.5 m/s$) and direction ($\theta\_{wind} = 101°$)."
numbered="true" >}}

More figures in [online presentation](/slides/pitot-build/#/10).

The GPS update rate is 10Hz. It is sampled at 50Hz to minimize delay. The pitot-tube sensor update rate is 260Hs but it is sampled at 250Hz.

The error is defined with $error = V\_{gps} - \left( V\_{Pitot} - V_{wind}*cos(\Theta\_{heading} + \Theta\_{wind}) \right) $. For the 200s of the flight shown on the figure, the error measured is:

|  error | m/s | km/h |
|:--:|:--:|:--:|
| mean | 0.017 | 0.06 |
| standard deviation | 0.74 | 2.6 |

RMS error is relatively low regarding the measured speed value. Part of the error is also due to wind gust and GPS limited accuracy particularly at estimating fast change of vertical speed.

### Wind estimation {#wind-estimation}

Wind model considered  is constant and characterized by 

- its constant direction $\Theta\_{wind}$
- its constant strength $V\_{wind}$

#### Wind => $V\_{Pitot} - V\_{gps}$

The curve below shows the difference between the Ground speed (GPS) with the airspeed (Pitot) in function of the plane flight direction. This error (blue dashed points) fit with a sine wave. This sine wave is the speed offset added for each plane direction in $[0 \ 2\pi]$ by a wind with a constant strength and direction. Sine wave amplitude and phase is the wind strength and direction.

{{< figure 
src="/img/pitot-darcy-prandtl-speed-error-wind-estimation.png"
link="/img/pitot-darcy-prandtl-speed-error-wind-estimation.png"
width="100%"
title="Experimental result presenting GPS ground speed and Pitot airspeed difference in function of the plane direction of 450s flight of the RC Firstar 1600 plane."
caption="Blue dots are speed difference between GPS and Pitot. The continuous green curve is the wind sine wave projection on the $\Theta\_{heading}$ plane direction. Sine phase is wind direction ($(\pi-1.37*\frac{180}{\pi})=101°$, from East to West) and sine amplitude is wind strength (2.56m/s). Pitot values are averaged and under-sample by a factor 5."
numbered="true"
>}}

This wind estimation is used to compensate the airspeed when comparing the GPS ground speed $V\_{gps}$ with the Pitot airspeed $V\_{Pitot}$ [above](/post/pitot-build/#gps-vs-airspeed).

#### Script

Matlab script to estimate wind off-line:

```matlab
% V_gps and V_pitot are two vector with all data measured.
% V_pitot was under-sampled (averaging) by a factor 5 to fit the 50Hz log from the GPS.
% GPS chip update frequency is 10Hz, but it is logged at 50Hz.

V_err = V_pitot -  V_gps;    % Ground and Airspeed difference (i.e. wind) 

M = [cos(COG); sin(COG) ]'; % COG is the direction (Theta in rad) vector data measured from the GPS
y = V_err';
x = M\y;    % Solve wind strength and direction using linear algebra (MMSE)

Theta_Wind = -atan2(x(2),x(1));  % Wind (go to) direction. Azimuth direction is opposite to trigo
V_Wind = sqrt(sum(x(1:2).^2));  % Wind strength (m/s)

plot(COG,V_err','.'); hold on; % plot Error blue dots 
plot([0:.01:(2*pi)],V_Wind*(cos([0:.01:(2*pi)]+ Theta_Wind)),'-k','linewidth',3); % plot wind
```

#### Discussion

Using the GPS COG[^COG] field is not exactly the plane yaw direction $\Theta\_{heading}$ but the plane flight direction.
Thus the COG is a biased plane yaw $\Theta\_{heading}$ direction. It would be best to use plane orientation from the IMU sensor. It is not done here to reduce the number of sensors for this demonstration. The COG bias is small enough if we assume the wind speed to be small compared to the airplane airspeed. It might be possible with a more sophisticated script to compensate this bias.

W. Premerlani propose a [wind estimation](https://drive.google.com/file/d/0ByvTkVQo3tqXVzBYQUZicUNvbEE/view) using exclusively GPS data. Tests with this GPS dataset was not conclusive while trying to use all GPS sample while the platform direction is modified (i.e. COG derivative is above a given threshold). GPS dynamic seems too slow to provide robust results.

#### Other flight data

Plane was equipped with two GPS:

- one uBlox M8N GPS and 
- one MTK3339.
  
The uBlox trace presented on the map below is better than the MTK trace. The uBlox chip was used exclusively for the curves above. The MTK trace can be shown on the [map](https://www.google.com/maps/d/u/0/embed?mid=1-K7dsmfbMCDL3IQK1z3IEtSduB2OWXr9) (top left icon). The KML file can be opened with Google Earth which provide a 3D view of the trace showing the height of the plane.

<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1-K7dsmfbMCDL3IQK1z3IEtSduB2OWXr9" style="width: 100% ; height: 480px"></iframe>

<!--
Project folder:
C:\M91449\MCHP_Blockset\Projects\2017_10_Autopilote\2018_04_12_LogChampdeTir_PitotNum_magOk_LowWind 
-->

[^COG]: Course Over Ground
[^LSB]: Least Significant Bit
