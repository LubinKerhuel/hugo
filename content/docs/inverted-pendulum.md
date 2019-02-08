+++
title = "Inverted Pendulum"

aliases = ["project/inverted_pendulum_flywheels/"]
summary = "LQR stabilization of an inverted pendulum platform made with low cost toy. Simulink model and generation of code for dsPIC Microchip microcontroller are provided (Rapid Control Prototyping : RCP)"

draft = false  # Is this a draft? true/false
toc = true  # Show table of contents? true/false
type = "docs"  # Do not modify.

 date = 2018-09-09T00:00:00
 lastmod = 2018-09-09T00:00:00

math = true

# date = 2018-09-09T00:00:00
# lastmod = 2018-09-09T00:00:00

GitRepo = "hugo"


# Add menu entry to sidebar.
# parent = "inverted_pendulum_flywheels"
[menu.docs]
    #parent = "Projects"    
    name = "Inverted Pendulum"
    identifier = "inverted-pendulum"
    weight = 10 

+++

<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}} 

{{< figure
src="/img/pendulum_platform_top.png"
width="45%"
caption="Top of the inverted pendulum"
numbered="true"
>}}

# Presentation

Stabilization of an inverted pendulum is a common engineering challenge. Objective is to build a low-cost DIY[^DIY] platform to test various feedback control loop.

This document describes the hardware and the theoretical model of the pendulum.
Simulation are presented with Simulink models and an LQR[^LQR] feedback control loop finally stabilizes the platform. 


<!-- test code -->
{{< vimeo id="309876246" 
caption="Inverted pendulum stabilized with LQR feedback loop" 
width="50%"
>}}
<!-- You tube alternative: {{< youtube id="dWTK7dTUvCo" >}} -->
Video of the stabilized platform with a 4 state LQR feedback loop. The platform is completely autonomous (no user input).


The electronic placed at the top of the pendulum composed of a dsPIC 16 bits microcontroller and an inertial sensor (accelerometers and rate gyro).
The base of the pendulum is a modified RC toys comprising two wheels driven by two independent DC motor (see [pictures below](#hw_trolley)).


# Hardware

## Overview

The head and the base trolley are described successively. They are separated with an $8mm$ carbon tube.
The pendulum length is $0.52m$ from wheel axis to the top. Wheels diameters is $8cm$. Pendulum total weight is $200g$ comprising $111g$ for the 4 AA batteries. 

{{< figure
src="/img/pendulum_platform_reduced_horizontal.png"
link="/img/pendulum_platform.jpg"
width="60%"
caption="Inverted Pendulum platform"
numbered="true"
>}}



## Head electronics

### Microcontroller

The controller is a `Microstick II` board equipped with a `dsPIC 33EP128MC202` running at $\approx 70\ MIPS$.
It is powered through the USB modified cable which **provide only the power supply** from 4 AA batteries hold in the base.

{{< figure 
src="/img/pendulum_top.png" 
link="/img/pendulum_top.png"
width="80%"
title="Microcontroller and sensor on top of the inverted pendulum"
caption="A prototyping board support a Microstick II board with the *dsPIC 33EP128MC202*. A board from Drotek endowing the Invensense ICM-20608 inertial sensor is screwed on the base board."
numbered="true"
>}}


### IMU sensor

The unique sensor used is a 6 DoF[^DoF] sensor: the `ICM-20608` from Invensense mounted on a [Drotek board](https://store.drotek.com/sensors/779-imu-6dof-icm20608-invensense-pcb-8944595424761.html) provides:

- a 3 axis Accelerometers and 
- a 3 axis rate gyros.

The I2C blocks set the BUS clock at $400kHz$ and fetch the 6 sensors values every $1ms$ $(1kHz)$.
The Simulink I2C blocks setting enable hot plug of the I2C sensor: The microcontroller initializes the sensor each time this last is detected or redetected on the I2C bus.

- The accelerometer is configured with a range of $\pm 8g$ low pass filtered at $99Hz$.
- The rage gyro is configured with a range of $\pm 500 \deg/s$ low pass filtered at $250Hz$.

A Simulink IMU[^IMU] sub-system run a data fusion algorithm to reconstruct a drift-free quaternion angular position at $1kHz$ (the yaw angle drift when magnetometer is not present).
The stabilization control loop uses the drift-free pitch angle. 

It is possible to use other sensors like the MPU9250 or MPU6050 with either an I2C or SPI interface. 
The GY-91 board is a 10 DoF[^DoF] widespread board based on the 9 DoF MPU9250 (3 accelerometers, 3 magnetometers, 3 rate gyros) and has a pressure sensor.


### UART interface {#UARTINTERFACE}

The PCB board provides a $3.3V$ regulator and 4 pin extra interface ( GND, +3.3v, Tx, Rx ) to connect either an UART [data-logger](https://github.com/d-ronin/openlager/wiki) or [radio link](http://ardupilot.org/copter/docs/common-sik-telemetry-radio.html#common-sik-telemetry-radio) for telemetry module or an [RC receiver](https://www.frsky-rc.com/product/xsr/) capable of S.BUS, S.Port or P.Port protocol (all UART based).




## Base trolley {#hw_trolley}

### Motors 

The base trolley is a low cost a 2-wheel remote control toy named `flywheels`. The toy is from 2012 but 2 wheeled equivalents exist.
Its electronics is removed.
Two pairs of wires power two DC motors in either direction through an `L298N` H bridge board module. 


{{< gallery >}}
	{{< figure
	src="/img/pendulum_toysrus_flywheels_package.jpg"
	title="FlyWheels toy package"
	caption="FlyWheels toy package"
	>}}

	{{< figure
	src="/img/pendulum_toysrus_flywheels_open.jpg"	
	title="Two DC motors"
	caption="Two DC motors"
	>}}
{{< /gallery >}}

<!-- 
 (pictures: [Package](Toysrus_FlyWheels_package.jpg), [vehicle](Toysrus_FlyWheels_Vehicle.jpg), [RC+vehicle](Toysrus_FlyWheels_Vehicle_Remote.jpg), [Inside](Toysrus_FlyWheels_Open.jpg)) 
 -->

### Power electronics 
The L298N H bridge controls two DC motors. For each motor:

- Two logic signals set the 4 states: direction CW or CCW, brake, or freewheel.
- The third logic signal power the motor depending on to the state defined. 

The third signal is modulated with a 100Hz square periodic signal whose duty cycle vary from 0% to 100% (PWM). It sets the torque for the motor.

The flat multicolor ribbon connects 6 logic control signals (3 for each motor) from the Microstick II dsPIC output to the of the L298N H bridge.

{{< figure
src="/img/pendulum_base.png"
link="/img/pendulum_base.png"
width="60%"
title="Base trolley of the inverted pendulum"
caption="A *L298N H bridge* (for Arduino) power board drives the two DC motors of a modified *FlyWheels* toy. *Four AA batteries* powers the pendulum."
numbered="true"
>}}

### Batteries

Four $1.2V$ AA Ni-Mh batteries are dispatched on both side of the trolley.
$\approx 4.8V$ powers the motors and the electronics.
The black and red wire from the trolley to the top of the pendulum powers the Microstick II electronic and sensors.


# Pendulum Model

The pendulum model is composed of two intertwined sub-system:

- The pendulum*, with 1 rotation DoF[^DoF] $\theta$ angle around the wheel's axis 
- The trolley*, with 1 translation DoF[^DoF] $x$ position. 

## Equations

Applying the Dynamic fundamental law on the pendulum:
$$ \sum \vec{Force} = m.\vec{a} $$ 

We model the three forces which are the weight $\vec{P}$, the Friction $\vec{F}$ which slow down the pendulum, and the Reaction $\vec{R}$ from the rod: 

$$ \underbrace{ -mg\vec{j} }\_{\vec{P}} \ 
 - \ \underbrace{ k \frac{\partial \vec{r}}{\\partial t} }\_{\vec{F}} \ 
 + \ \underbrace{ mg\vec{j} . \vec{r} + \underbrace{Ctfg . \vec{r}}\_{\text{Centrifugal}} }\_{\vec{R}} = ml \frac{\partial^2\vec{ r }}{\\partial t^2}
$$

With $ \\{ \vec{i},\vec{j} \\} $ the earth reference frame and $ \\{ \vec{r},\vec{n} \\} $ the pendulum frame (rod and normal direction). 
$m$ is the mass of the pendulum (without the trolley).
$l$ is the distance from the inter-wheel's axis to the center of mass of the pendulum (without the trolley)

$$
\left\\{ \begin{array}{rcl}
	\vec{i} \& = \& \vec{n} . cos(\theta) - \vec{r} . sin(\theta) \\\\\\ 
	\vec{j} \& = \& \vec{n} . sin(\theta) + \vec{r} . cos(\theta)
\end{array} \right.
$$ 

With 

$$
\begin{array}{rcl}
	k \frac{\partial \vec{r}}{\\partial t} 
	\& = \&
	-k  \dot{\theta} \vec{n} \\\\\\
\end{array} 
$$ 

and 

$$
\begin{array}{rcl}
	ml \frac{\partial^2\vec{ r }}{\partial t^2} 	
	\& = \&
	-ml \frac{\partial }{\\partial t} \left( \dot{\theta} \vec{n} \right) \\\\\\
	\& = \&
	-ml \ddot{\theta} \vec{n} - ml\dot{\theta}^2 \vec{r}
\end{array} 
 $$

Separating each axis $ \\{ \vec{r},\vec{n} \\} $  we obtain:
$$
\left\\{ \begin{array}{rcl}
	\ddot{\theta} + \frac{km}{l}\dot{\theta} - \frac{g}{l} . sin(\theta) = 0 \\\\\\ 
	ml\dot{\theta}^2 + Ctfg = 0	
\end{array} \right.
$$ 

The second equation provides the centrifugal force counteracted by the pendulum rod.

The first differential equation allows solving the angle $\theta$ evolution. It can be linearized with $sin(\theta) \approx \theta$ when the pendulum is up near $0$, or with $sin(\theta) \approx - (\theta - \pi)$ when the pendulum is down near $\pi$.

When the pendulum is up-side down (thus stable situation), the resulting $2^{nd}$ order system is characterized by: 

- a natural oscillation frequency $w_n = \sqrt{ \frac{g}{l} } $, and
- a damping factor $\zeta$. 

In the laplace domain, differential equations for $\theta$ becomes:
$$ \theta(s) \left ( \frac{1}{w_n^2}s^2 + \frac{2 \zeta}{w_n}s \pm 1 \right ) = 0  $$

The pendulum transfert function $F_p = \frac{\theta(s)}{E(s)}$ with a null input $E(s) = 1$
$$ F_p(s) = \frac{1}{ \frac{1}{w_n^2}s^2 + \frac{2 \zeta}{w_n}s \pm 1 } $$

Using $\pm 1 \rightarrow +1$ when the pendulum is down side (stable) and $-1$ when up side (unstable).


The parameter $l$ could be measured from the platform hardware but the damping factor $\zeta$ depends on friction and cannot be measured.
Thus both $l$ and $\zeta$ are determined by an identification on the free oscillating pendulum

## Identification

The pendulum is placed up-side-down between two chair back.
The pendulum is let free to oscillate, motor off.
The initial pendulum angle is $\theta \approx \frac{\pi}{2}$ (almost horizontal). It oscillates at its frequency $w_n$ until the damping friction ($\zeta$) stop the oscillations. The $1kHz$ sampled angular speed and accelerations are recorded with [openlager](https://github.com/d-ronin/openlager/wiki) board connected on the [UART](#UARTINTERFACE) interface.

|Pendulum Parameters|Identified Value|
| :---: | :---: |
| $l$  | $0.45 m$ |
| $k$  |$0.4$ |
| $w_n = \sqrt{\frac{g}{l}}$  | $0.37 rad.s^{-1}$ ( $2.33 Hz$ ) | 
⬆ Table of pendulum parameters


 Recorded data fed a Simulink model which reconstruct the pendulum angle with the IMU algorithm. Then the pendulum $\theta$ oscillations is compared against a theoretical pendulum model.
 The model parameters $l$ and $\zeta$ are tuned for the model to match with the experimental data.  


# Trolley Model

## Equations

The translational movement of the trolley is modeled as a $1^{st}$ order system characterized by its time constant $\tau$.
This dynamic includes the motor dynamics when it is loaded with the trolley considering the pendulum as vertical.

The model considers as negligible the effect of the pendulum forces (translational and rotational) applied on the trolley. 


$$  x(s) = \frac{1}{\tau s + 1} $$

|Trolley Parameter|Estimated Value|
| :---: | :---: |
| $\tau$  | $0.3s$ |

The trolley does not have any sensors. No encoder or current sensor are used to control the two motors. The parameters $\tau$ is guessed instead of identified. 

## Identification

Still the pendulum model including the trolley is simulated with its feedback loop controller and results are compared against recorded data of the real system running the same feedback loop controller. The simulated pendulum states are re-initialized periodically ($\approx 2s$) with the real pendulum states as the model would diverge otherwise due to perturbations not modeled and model discrepancies. Correctness of the model can be checked between theses periodic re-initialization.



# Controller

`Stabilization overview:` The microcontroller computes the angle of the pendulum from the inertial sensor measurements (accelerometers and rate gyro). A feedback loop stabilizes the pendulum up right while maintaining the pendulum position still. The pendulum translation is estimated through an internal dynamic model of the trolley stimulated with a copy of the DC motor command. The pendulum slow translations reflect the drift of the internal estimation of the displacement.




Video of the inverted Pendulum when it encounters a wall:
{{< vimeo id="309876329" caption="Inverted pendulum pushing a wall">}}
<!-- You tube alternative: {{< youtube id ="xbu4hXOnemE" >}} -->


Another way to stabilize a pendulum with an electric see-saw ([video](https://sciencedemonstrations.fas.harvard.edu/presentations/inverted-pendulum)).

[^IMU]: Inertial Measurement Unit
[^DoF]: Degree of Freedom
[^LQR]: Linear Quadratic Regulator
[^DIY]: Do It Yourself
