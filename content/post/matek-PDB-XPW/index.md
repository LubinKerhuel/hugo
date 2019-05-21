---
title: 'MATEKSYS PDB-XPW Dual BEC & Current Module tweak to increase current measurement sensitivity'
subtitle: 'Narrow current range measurement from 140A to 20A'
summary: Adapt the MATEKSYS PDB-XPW power module for quad rotor to fit electric RC plane with lower current requirements. Change current measurement range by replacing one single resistor from the Op-Amp current measurement circuit.
authors:
- Lubin
tags: ["Electronics","Power","PDB-XPW"]
categories: ["Electronics"]
date: "2019-05-18"
#lastmod: "2019-04-12T00:00:00Z"
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: 'PDB-XPW Dual BEC & current module. Image from MATEK Systems.'
  focal_point: "TopRight"
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

Board reference: http://www.mateksys.com/?portfolio=pdb-xpw

The current measurement output signal amplification and conditioning is done using the chip "INA1x9 High-Side Measurement Current Shunt Monitor" from Texas Instrument.

On the PDB-XPW, the INA1x9 chip is the black 5 pins component tagged E39 below the 0.05 Ohms power resistor, itself just below to the Power supply input connector.

The amplification gain resistor is the 47 kOhm resistor next to the INA1x9 component. Original value of 47kOhm correspond to a gain of 47.
The gain is simply equal to the value in kOhm. 

Table from Texas instrument doc:

|Resistor|Gain|
|:---:|:---:|
|1 kOhm | 1 |
|5 Kohm | 5 |
|10 Kohm | 10 |
|50 Kohm | 50 |
|100 Kohm | 100 |


This board is used as voltage regulator and current measurement for an RC electric plane project. The max current for this plane is 20Amps thus a finer current measurement from the one proposed for quads which typically consume more current is better suited.

The 47 kOhm resistor is replaced with a 270 kOhm resistor providing a gain of 270 instead of 47. 
The original current measurement range is reduced from 140 (A) to 20 (A) (140 * 47/270 = 20). The output analog swing range from 0 to 3.3V code linearly for current in 0 to 20 Amps range.

