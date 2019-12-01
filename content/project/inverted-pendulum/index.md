+++
# Project title.
title = "Inverted Pendulum"

# Date this page was created.
date = 2018-12-01
#date = 2019-09-05T00:00:00Z
lastMod = 2019-09-05T00:00:00Z

draft = false

#  toc = true  # Show table of contents? true/false
#  type = "docs"  # Do not modify.
 # 
#  [menu.Inverted_Pendulum_FlyWheels]
#  #  parent = "Inverted_Pendulum"
#    name = "test"
#    weight = 1

# Project summary to display on homepage.
summary = "Inverted pendulum running on a microstick II dsPIC board. An IMU algorithm estimate the angle based on a MEMS inertial sensor. LQR feedback controls the DC motors of the trolley. No encoder are used."


# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`

# keep tag for the real page
#tags = ["inverted pendulum","state space","LQR","rapid prototyping","model based design","matlab","simulink","DIY","dsPIC","L298N","ICM-20608"]
# tags = [""]

# Optional external URL for project (replaces project detail page).
external_link = "/docs/inverted-pendulum/"


share = true  # Show social sharing links?
profile = false  # Show author profile?
comments = false  # Show comments?

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references 
#   `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides = ""


# Links (optional).
url_pdf = ""
url_preprint = ""
url_code = ""
url_dataset = ""
#url_project = "/docs/inverted-pendulum/"
url_slides = ""
url_video = "https://vimeo.com/album/5666929"
url_poster = ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
#links = [{icon_pack = "fab", icon="twitter", name="Follow", url = "https://twitter.com/georgecushen"}]

# links = [
# 	{name = "Lab", url = "/docs/inverted-pendulum/"},
# 	{name = "Simulink models", url = "https://github.com/rdelpoux/INSA_TP_CommandeTempsReel_MCC/tree/master/LABMatlabFiles/"},
# 	]

# Featured image
# To use, add an image named `featured.jpg/png` to your project's folder. 
[image]
  # Caption (optional)
  caption = "head of the inverted pendulum"
  
  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = "Top"

  # Show image only in page previews?
  # theu use header image to show something else in the page
  # preview_only = false

+++

Simulink Rapid Prototyping based inverted pendulum running on a microstick II dsPIC board.
The embedded IMU data fusion algorithm use the ICM-20608 inertial sensor to estimate the angle.
LQR control loop drives two DC motors of the modified toy.
No encoder sensor are present.
