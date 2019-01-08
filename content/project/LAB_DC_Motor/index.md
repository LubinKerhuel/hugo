+++
# Project title.
title = "Real Time Control for a DC Motor"

# Date this page was created.
date = 2018-12-01
draft = true

# Project summary to display on homepage.
summary = "Simulation & real-time control of a 24v DC motor (INSA Lyon hands-on)"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["simulink","matlab","motor-control","rapid-prototyping","DC-motor","speed-controller"]

# Optional external URL for project (replaces project detail page).
external_link = ""

share = false  # Show social sharing links?
profile = false  # Show author profile?
comments = false  # Show comments?

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references 
#   `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides = "slides_dcmotor_insa"

# Links (optional).
url_pdf = ""
url_slides = ""
url_video = ""
url_code = ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
#url_custom = [{icon_pack = "fab", icon="twitter", name="Follow", url = "https://twitter.com/georgecushen"}]

# Featured image
# To use, add an image named `featured.jpg/png` to your project's folder. 
[image]
  # Caption (optional)
  caption = "Motor Pravalux"
  
  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = "Smart"
+++

Control a 24V DC motor using the MCLV V2 board with a dsPIC 33EP256MC506. 
This hands-on is for 5th year students at INSA-Lyon. 

The hands-on Lab subject available at: https://rtdc.ctrl-elec.fr/.

Slides presents the adaptation required to go from a Simulink model for Simulation (or DSPACE) to a Simulink model targeting a microcontrollers. Two topics are presented:

- Real-time scheduler / CPU load analysis
- Fixed-point datatypes


### Authors:
- Romain DELPOUX (Romain.Delpoux at insa-lyon.fr), Assistant Professor, INSA de Lyon, Laboratoire Ampère UMR CNRS 5005.
- Lubin KERHUEL (Lubin.Kerhuel at microchip.com), Dr-Engineer, Microchip Technology Inc.

