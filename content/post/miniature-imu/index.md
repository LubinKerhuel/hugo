---
# Project title.
title: Miniature Inertial Measurement Unit (IMU)
subtitle: Estimate attitude from low-cost MEMS inertial sensors
# Project summary to display on homepage.
summary: Estimate attitude from low-cost MEMS inertial sensors

authors:
- Lubin

tags:
  - DIY
  - IMU
  - model based design
  - simulink

categories: 
  - electronics
  - sensor

# Date this page was created.
date: 2019-06-22
#lastmod: "2019-04-12T00:00:00Z"
featured: true
draft: true

draft: true
#slides: Pitot-build

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: "IMU sensor boards available in 2019: GY-91 (open source) ; IMU 10DOF v2, 9DOF and 6DOF (Drotek)"
  focal_point: "Smart"
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: 
  - autopilot-plane
  - inverted-pendulum 

# links = [
# 	{name = "Lab", url = "/docs/inverted-pendulum/"},

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

The objective is to create a data fusion algorithm to estimate one's attitude from MEMS sensors. Rapid Control Prototyping (RCP) technics are used through the use of Simulink to design and test the algorithm onboard a dsPIC.

## Sensors

Three types of MEMS sensors typically noted AGM measure 3 quantities in 3 axes:

- (A) Accelerometers measure the acceleration vector
- (G) rate Gyros measure the angular speed rate
- (M) Magnetometers measure the magnetic field

Theses sensors are sometime all in one package. Many boards exist providing 6 (AG), 9 (AGM) and sometime 10 DoF[^DoF] (AGM and barometer).
example of sensors are: MPU9250 - MPU6050 - MPU6000 - ICM20608

### Algorithms

#### Accelerometers - Magnetometers (AM)

The simplest algorithm compute attitude from A and M vectors. The gravity and the magnetic vectors $\vec{g}$ and $\vec{m}$ and their vectorial product $\vec{g} \times \vec{m}$ define a  base which is ortho-normalized and placed in a column-wise vector matrix to form the DCM rotation matrix defining the attitude of the object.

This algorithm works under the assumption that

- the object is static (i.e. no linear accelerating) and
- the object is not subject to magnetic perturbations.

For most dynamic systems, theses assumptions are constraining.
Adding a rate gyro coupled with a data fusion algorithm reduces theses constraints.

#### Accelerometers - rate Gyro - Magnetometers (AGM)

AGM algorithms fusing accelerometers with magnetometers with rate gyro, we have 3 steps:

- Prediction
- Error
- Correction


Complementary Filter, good for 2D

Kalman, overkilling

whatever the algorithm picked, 3 steps:





### Algorithms



Magnetometre jamming rejection

AHRS: accelerometer + Gyrometre + magnetometre
MARG: accelerometer + gyro + mag
IMU: accelerometer + Gyrometer
IMU project Todo

Recorded Data Workflow
Recorded Sensor Data

[^DoF]: Degree of Freedom
<!-- test code -->
