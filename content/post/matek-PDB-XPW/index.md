---
title: 'MATEKSYS PDB-XPW Dual BEC & Current Module adaptation to measure lower current'
subtitle: 'Increase Current sensibility (reducing current range from 140A to 20A)'
summary: Change one resistance from the Op-Amp feedback on the current measurement on the PDB-XPW board from MATEKSYS.
authors:
- Lubin
tags: []
categories: []
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
projects: []

math: true

---

<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

Board reference: http://www.mateksys.com/?portfolio=pdb-xpw

The current measurement output signal amplification and conditionning is done through the "INA1x9 High-Side Measurement Current Shunt Monitor" chip from Texas Instrument.

It is the black 5 pins component noted E39 below to the Power supply connector and below to the 0.05 Ohms power resistor.

The gain resistor is the non-null resistor next to the component. Original value is 47kOhm corresponding to a gain of 47.
Using a higher value will increase the gain. 

Table from Texas instrument doc:

|Resistor|Gain|
|:---:|:---:|
|1 kOhm | 1 |
|5 Kohm | 5 |
|10 Kohm | 10 |
|50 Kohm | 50 |
|100 Kohm | 100 |


This board is used as voltage regulator and current measurement for an RC electric plane project. I needed a finer current measurement than the one provided for quad copter which consume more with their four motors. 

The 47 kOhm resistor was replaced with a 270 kOhm resistor providing a gain of 270.
The measurable current range is reduced from 140A (original board) to 140 * 47/270 = 20 (A). 0 to 20 (A) are beeing coded with a swing analog output from 0 to 3.3V.

