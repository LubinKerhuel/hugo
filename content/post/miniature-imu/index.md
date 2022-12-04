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

#slides: Pitot-build

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: "IMU sensor boards available in 2019: GY-91 (open source) ; IMU 10DoF v2, 9DoF and 6DoF (Drotek)"
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

Three types of MEMS sensors noted respectively A,G and M measure 3 quantities in 3 axes:

- (A) Accelerometers measure the acceleration vector $\vec{a}$
- (G) rate Gyros measure the angular speed rate $\vec{G}$
- (M) Magnetometers measure the magnetic field $\vec{m}$

Theses sensors are sometime all in one single package. Boards provides 6 (AG), 9 (AGM) and even 10 DoF[^DoF] including a barometer. 

Example of MEMS sensors: MPU9250 - MPU6050 - MPU6000 - ICM20608

## Attitude algorithms introduction

### Accelerometers - Magnetometers (AM)

The **TRIAD** algorithm computes attitude from vectors $\vec{a}$ and $\vec{m}$: 
The gravity $\vec{a}$ and the earth magnetic vector $\vec{m}$ are measured in the object frame. Their vectorial product $\vec{k} = \vec{a} \times \vec{m}$ is orthogonal to  $\vec{g}$ and $\vec{m}$. The base $(\vec{a},\vec{m},\vec{k})$ is ortho-normalized by replacing the vector $\vec{m}$ with $\vec{j} = \vec{a} \times \vec{k}$. The base  $(\vec{a},\vec{j},\vec{k})$ base is ortho-normal. Placed in a column-wise vector matrix, the base $(\vec{a},\vec{j},\vec{k})$ is the DCM[^DCM] rotation matrix which define the attitude of the object frame. The invert rotation is the transposed DCM matrix.

TRIAD algorithm works under the assumption that

- the object is not subject to accelerations and
- the object is not subject to magnetic perturbations.

Most dynamics system are subject to accelerations, or take place indoor where magnetic field is not reliable. Another sensor allows reducing theses assumption constraints.

### Accelerometers - rate Gyro - Magnetometers (AGM)

Attitude estimation relying only on Accelerometers and Magnetometers are prone to errors as the gravity vector measurement is impacted by system own acceleration and earth magnetic field vector measurement is affected by local change of the magnetic field.

A rate gyro MEMS sensor measure angular speed rate in 3 axes. The rate gyro measurement is not perturbed[^rate-gyro-perturbation]. Attitude angle change can be tracked by integrating the angular speed rate. However a rate gyro is not self-sufficient because 

- Integrator initial angle value is not defined
- Integrator accumulates any sensor bias error making the attitude to drift

AGM algorithms use the `rate gyro` sensor to track the fast dynamic the attitude and the `accelerometers` and `magnetometers` sensors for initial attitude and correction of the drift inherent to the angular speed integration.

Three steps are typical from IMU data fusion algorithm:

1. Prediction
2. Error
3. Correction

## AGM algorithms



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
[^DCM]: Direct Cosine Matrix
[^rate-gyro-perturbation]: Rate gyro measurements are not modified by local magnetic field nor by its own acceleration, except important chocs.
<!-- test code -->
