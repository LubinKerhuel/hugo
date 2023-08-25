+++
# Project title.
title = "Lab INSA - Real Time Control for a DC / PMSM Motors"

aliases = ["/project/lab_dc_motor/"]

# Date this page was created.
date = 2018-12-01
lastMod = 2019-06-01
draft = false

authors = ["lubin","romain-delpoux"]

# Project summary to display on homepage.
summary = "Simulation & real-time control of a motor with MCLV 2 board"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["simulink","matlab","motor","control","rapid prototyping"]

# Optional external URL for project (replaces project detail page).
external_link = ""

share = false  # Show social sharing links?
profile = false  # Show author profile? Show only first profile
comments = false  # Show comments?

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references 
#   `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides = "slides_dcmotor_insa_2022_12" 
# "slides_dcmotor_insa"

# Links (optional).
url_pdf = ""
url_preprint = ""
url_code = ""
url_dataset = ""
url_project = ""
url_slides = ""
url_video = ""
url_poster = ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
#links = [{icon_pack = "fab", icon="twitter", name="Follow", url = "https://twitter.com/georgecushen"}]

links = [
	{name = "Lab DC Motor", url = "https://rtdc.ctrl-elec.fr/"},
  {name = "Lab PMSM Motor", url = "https://rcp.ctrl-elec.fr/"},
	{name = "Simulink models", url = "https://github.com/rdelpoux/INSA_TP_CommandeTempsReel_MCC/tree/master/LABMatlabFiles/"},
	]

# Featured image
# To use, add an image named `featured.jpg/png` to your project's folder. 
[image]
  # Caption (optional)
  caption = "Motor Pravalux"
  
  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = "Smart"
+++

Control a 24V motor (Pravalux 24v DC) using the MCLV-V2 board with a dsPIC 33EP256MC506.
This hands-on is for 5th year students at INSA-Lyon.

The hands-on Lab subject available at: https://rtdc.ctrl-elec.fr/.

Slides presents the adaptation required to go from a Simulink model for Simulation (or DSPACE) to a Simulink model targeting a microcontrollers. Two topics are presented:

- Real-time scheduler / CPU load analysis
- Fixed-point datatypes

2021: Dspace project not feasible in labs due to Covid-19. It was replaced with home lab on MCLV-2 boards (sent to students) replacing Dspace.
lab subject is availalbe at: https://rcp.ctrl-elec.fr/
