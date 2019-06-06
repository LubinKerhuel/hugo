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

sitemap:
  priority: 1

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: PDB-XPW Dual BEC & current module. Image from MATEK Systems.
  focal_point: TopRight
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: ["autopilot-plane"]

math: true

# add comment through github: required files github-comments.js (static/js) and comments.html (partial)
# provide a github repository with comment enabled:
# each page is assigned to a comment id. see github from dwilliamson/donw.io
# ghcommentrepo: dwilliamson/donw.io
# ghcommentid: 1
---

<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

The board [PDB-XPW](http://www.mateksys.com/?portfolio=pdb-xpw) from MATEK System is a voltage regulator with an current measurement adapted for quad copters current with a max current measurement of 140 Amps. For an RC plane project, the current measurement might be reduced to increase current measurement resolution.

The chip "INA1x9 High-Side Measurement Current Shunt Monitor" from Texas Instrument condition and amplify the shunt resistor voltage drop providing an analog output proportional to the current.

On the PDB-XPW board, the INA1x9 chip is the black 5 pins component tagged E39 below the 0.05 Ohms shunt resistor, itself just below to the Power supply input connector.

The amplification gain is set with the 47 kOhm resistor next to the INA1x9 component. This original value of 47 kOhm correspond to a gain of 47.
The gain is the value in kOhm as stated by the chip documentation: 

|Resistor|Gain|
|:---:|:---:|
|1 kOhm | 1 |
|5 Kohm | 5 |
|10 Kohm | 10 |
|50 Kohm | 50 |
|100 Kohm | 100 |

The 47 kOhm resistor is replaced with a 270 kOhm resistor providing a gain of 270 instead of 47. 
The original current measurement range is reduced from 140 (A) to 20 (A) (140 * 47/270 = 20). 

The current measurement output is an analog signal swinging from 0 to 3.3V coding linearly for current in [0 - 20] Amps range. This lower current range fit with the RC plane platform like Bixler 2, Firstar 1600 or Ranger 1600.

