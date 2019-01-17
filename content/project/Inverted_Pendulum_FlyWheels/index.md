+++
# Project title.
title = "Inverted Pendulum"

# Date this page was created.
date = 2018-12-01
draft = false

#  toc = true  # Show table of contents? true/false
#  type = "docs"  # Do not modify.
 # 
#  [menu.Inverted_Pendulum_FlyWheels]
#  #  parent = "Inverted_Pendulum"
#    name = "test"
#    weight = 1

# Project summary to display on homepage.
summary = "Inverted pendulum running on a microstick II dsPIC board. Angle is estimated from low cost MEMS sensors with an IMU data fusion algorithm. Stabilizing control loop drives two DC motors from a modified RC toy. No encoder sensor are used."

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["Inverted pendulum","control","state space","LQR","rapid prototyping","model-based design","matlab","simulink","DIY"]

# Optional external URL for project (replaces project detail page).
external_link = "/tutorial/inverted_pendulum_flywheels/"


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
url_slides = ""
url_video = "https://vimeo.com/album/5666929"
url_code = ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
#url_custom = [{icon_pack = "fab", icon="twitter", name="Follow", url = "https://twitter.com/georgecushen"}]

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

#[header]
#image = "idtLK.jpg"
#caption = "head of the inverted pendulum"


[[gallery_item]]
album = "flywheel_gallery"
image = "01_Toysrus_FlyWheels_package.jpg"
caption = "FlyWheels toy package"

# [[gallery_item]]
# album = "1"
# image = "Toysrus_FlyWheels_Vehicle.jpg"
# caption = "Toy used as base"

# [[gallery_item]]
# album = "1"
# image = "Toysrus_FlyWheels_Vehicle_Remote.jpg"
# caption = "Toy with its remote"

[[gallery_item]]
album = "flywheel_gallery"
image = "02_Toysrus_FlyWheels_Open.jpg"
caption = "Inside of the FlyWheels toy with its two DC motors"
 

+++



{{% toc %}}


## Introduction

Objective is to build an `unstable pendulum platform` to experiment various control loop to stabilize it. The platform hardware is described below; a brief overview of the model is given and a LQR algorithm implemented as proof of concept.


<!-- test code -->
{{< vimeo id="309876246" 
caption="Inverted pendulum stabilized with LQR feedback loop" 
width="50%"
>}}
<!-- You tube alternative: {{< youtube id="dWTK7dTUvCo" >}} -->
Video of the stabilized platform with a 4 state LQR feedback loop. The platform is completely autonomous (no user input).


The top of the pendulum is comparable to a head where the microcontroller acts as a brain and the inertial sensor (accelerometers and rate gyro) as the inner ears. The base of the pendulum is a modified RC toys comprising two wheels driven by two independent DC motor (see [pictures below](#hw_trolley)).

{{% alert note %}}
`Stabilization overview:` The microcontroller computes the angle of the pendulum from the inertial sensor measurements (accelerometers and rate gyro). A feedback loop stabilize the pendulum up right while maintaining the pendulum position still. The pendulum translation is estimated through an internal dynamic model of the trolley stimulated with a copy of the DC motor command. The pendulum slow translations reflect the drift of the internal estimation of the displacement.
{{% /alert %}}

## Hardware

The head and the base trolley are described successively. They are separated with an $8mm$ carbon tube. The pendulum length is $0.52m$ from wheel axis to the top. Wheels diameters is $8cm$. Pendulum total weight is $200g$ comprising $111g$ for the 4 AA batteries. 

{{< figure
src="featured_reduced_horizontal.png"
link="featured.png"
width="60%"
title="inverted Pendulum"
caption="click to open vertical full sized picture"
numbered="true"
>}}



### head electronics: IMU sensor and microcontroller

The controller is a Microstick II board equipped with a dsPIC 33EP128MC202 running at $\approx 70\ MIPS$. It is powered through the USB modified cable which **provide only the power supply** from 4 AA batteries hold in the base.

{{< figure 
src="Pendulum_Top.png" 
link="Pendulum_Top.png"
width="80%"
title="head on top of the inverted pendulum"
caption="A prototyping board support a Microstick II board with the *dsPIC 33EP128MC202*. A sensor board from drotek endowing the *ICM-20608* inertial sensor is screwed on the base board."
numbered="true"
>}}

The unique sensor used is a 6 [DoF][^DoF] IMU[^IMU] sensor: the ICM-20608 from invensense mounted on a [drotek board](https://store.drotek.com/sensors/779-imu-6dof-icm20608-invensense-pcb-8944595424761.html) provides:

- a 3 axis Accelerometers and 
- a 3 axis rate gyro.

The ICM-20608 values are read through an I2C interface running at 400kHz. The I2C interface implemented through the I2C blocks for dsPIC enable hot plug of the sensor: The microcontroller sends an initialization sequence for the sensor each time this last is detected. Others sensor boards were tested endowed with MPU9250 and MPU6050 chips. The GY-91 board is currently the more commonly found on the market and has 10 [DoF][^DoF].

- The accelerometer is configured with a range of $\pm 8g$ low pass filtered at $99Hz$.
- The rage gyro is configured with a range of $\pm 500 \deg/s$ low pass filtered at $250Hz$.

The PCB board provides a $3.3V$ regulator and 4 pin extra interface ( GND, +3.3v, Tx, Rx ) to connect either a data logger, a radio link for telemetry module or an RC receiver capable of S.BUS or S.Port protocol (i.e. UART based).



### Base trolley: Motor, batteries and power electronics {#hw_trolley}

{{< gallery album="flywheel_gallery">}}

The base trolley is based on low cost a 2-wheel remote control toy. Its electronics is removed. Two pairs of wires power the two DC motors in either direction through an L298N H bridge external module. 

<!--  (pictures: [Package](Toysrus_FlyWheels_package.jpg), [vehicle](Toysrus_FlyWheels_Vehicle.jpg), [RC+vehicle](Toysrus_FlyWheels_Vehicle_Remote.jpg), [Inside](Toysrus_FlyWheels_Open.jpg)) -->

The L298N H bridge controls two DC motors. For each motor:

- Two logic input signals set the motor state: direction, brake, or free-wheels.
- The third logic input signal power-up the motor depending on to the state defined. This third signal is modulated with a 100Hz square periodic signal (PWM) whose duty cycle vary from 0% to 100%. It sets the torque for the motor.

The flat multicolor rubbon connects 6 logic control signal (3 for each motor) from the Microstick II dsPIC to the input of the L298N H bridge.

{{< figure
src="Pendulum_Base.png"
link="Pendulum_Base.png"
width="60%"
title="Base trolley of the inverted pendulum"
caption="A *L298N H bridge* (for arduino) power board drives the two DC motors of a modified *FlyWheels* toy. *Four AA batteries* powers the pendulum."
numbered="true"
>}}

Each side of the trolley hold two $1.2V$ AA NiMh batteries (total is 4 x AA) which powers both the DC motors and the electronics with $\approx 4.8V$. The black and red wires from the trolley to the top of the pendulum powers the Microstick II electronic and sensors.

## Pendulum model

The pendulum model is composed of two intertwinned sub-system:

- The *1 DoF pendulum*, with 1 rotational [DoF][^DoF] around the wheels axis 
- The *1 DoF trolley*, with 1 horizontal translation [DoF][^DoF]. 

The *1 DoF pendulum* is characterized by a length $L$ and a weight $M$. It is a $2^{nd}$ order system.

The *1 DoF trolley* is characterized by the motors dynamics when translating the base loaded with an up-right pendulum. The model is $1^{st}$ order system characterized by its time constant $\tau$.

### 1 rotational DoF pendulum



### 1 translational DoF trolley




## Control feedback loop


Video of the inverted Pendulum when it encounters a wall:
{{< vimeo id="309876329" caption="Inverted pendulum pushing a wall">}}
<!-- You tube alternative: {{< youtube id ="xbu4hXOnemE" >}} -->


#### Acronyms:
[^IMU]: Inertial Measurement Unit
[^DoF]: Degree of Freedom


<!--
{{< gallery album="ressources" filename=Pendulum_Base.png caption="test" >}}
-->

