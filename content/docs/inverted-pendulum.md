+++
title = "Inverted Pendulum"

# date = 2018-09-09T00:00:00
# lastmod = 2018-09-09T00:00:00

draft = false  # Is this a draft? true/false
toc = true  # Show table of contents? true/false
type = "docs"  # Do not modify.

GitRepo = "hugo"

# Add menu entry to sidebar.
# parent = "inverted_pendulum_flywheels"
[menu.docs]
    #parent = "Projects"    
    name = "Inverted Pendulum"
    identifier = "inverted-pendulum"
    weight = 10
    

# [[gallery_item]]
# 	album = "1"
# 	image = "pendulum_toysrus_flywheels_package.jpg"
# 	caption = "FlyWheels toy package"	
# 
# [[gallery_item]]
# 	album = "1"
# 	image = "pendulum_toysrus_flywheels_open.jpg"
# 	caption = "Inside of the FlyWheels toy with its two DC motors"

# {{< gallery album="1" >}}


+++

<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}} 

{{< figure
src="/img/pendulum_platform_top.png"
width="45%"
title="Top of the inverted pendulum"
numbered="true"
>}}

# Presentation

Stabilisation of an inverted pendulum is a common engineering challenge. Objective is to build an accessible pendulum platform (DIY[^DIY]]) for experiment various feedback control loop.
The hardware is described, the simulation model of the pendulum is presented and an LQR[^LQR] feedback control loop is tested. 


<!-- test code -->
{{< vimeo id="309876246" 
caption="Inverted pendulum stabilized with LQR feedback loop" 
width="50%"
>}}
<!-- You tube alternative: {{< youtube id="dWTK7dTUvCo" >}} -->
Video of the stabilized platform with a 4 state LQR feedback loop. The platform is completely autonomous (no user input).


The electronic placed at the top of the pendulum composed of a dsPIC 16 bits microcontroller and an inertial sensor (accelerometers and rate gyro). The base of the pendulum is a modified RC toys comprising two wheels driven by two independent DC motor (see [pictures below](#hw_trolley)).



# Hardware

## Overview

The head and the base trolley are described successively. They are separated with an $8mm$ carbon tube. The pendulum length is $0.52m$ from wheel axis to the top. Wheels diameters is $8cm$. Pendulum total weight is $200g$ comprising $111g$ for the 4 AA batteries. 

{{< figure
src="/img/pendulum_platform_reduced_horizontal.png"
link="/img/pendulum_platform.jpg"
width="60%"
title="Inverted Pendulum"
numbered="true"
>}}



## Head electronics

### Microcontroller

The controller is a Microstick II board equipped with a dsPIC 33EP128MC202 running at $\approx 70\ MIPS$. It is powered through the USB modified cable which **provide only the power supply** from 4 AA batteries hold in the base.

{{< figure 
src="/img/pendulum_top.png" 
link="/img/pendulum_top.png"
width="80%"
title="Microcontroller and sensor on top of the inverted pendulum"
caption="A prototyping board support a Microstick II board with the *dsPIC 33EP128MC202*. A sensor board from drotek endowing the *ICM-20608* inertial sensor is screwed on the base board."
numbered="true"
>}}


### IMU sensor

The unique sensor used is a 6 DoF[^DoF] sensor: the ICM-20608 from invensense mounted on a [drotek board](https://store.drotek.com/sensors/779-imu-6dof-icm20608-invensense-pcb-8944595424761.html) provides:

- a 3 axis Accelerometers and 
- a 3 axis rate gyro.

The ICM-20608 values are read all 6 values at $1kHz$ through an I2C interface clocked at $400kHz$. The I2C interface implemented through the I2C blocks for dsPIC enable hot plug of the sensor: The microcontroller initialize the sensor each time this last is detected on the I2C bus. Others sensor boards were tested using MPU9250 or MPU6050 chips. The GY-91 board is currently one widespread board and has 10 DoF[^DoF] (3 acceletometers, 3 rate gyor, 3 magnetometers, and one pressure sensor).

- The accelerometer is configured with a range of $\pm 8g$ low pass filtered at $99Hz$.
- The rage gyro is configured with a range of $\pm 500 \deg/s$ low pass filtered at $250Hz$.

The data fusion algorithm in the simulink IMU[^IMU] sub-system perform a data fusion algorithm to reconstruct a drift-free absolute quaternion angular position (except on the yaw angle when magnetometer is not available). The drift-free pitch angle is the only one requierd to stabilize the pendulum. 

### UART interface {#UARTINTERFACE}

The PCB board provides a $3.3V$ regulator and 4 pin extra interface ( GND, +3.3v, Tx, Rx ) to connect either an UART [data-logger](https://github.com/d-ronin/openlager/wiki) or [radio link](http://ardupilot.org/copter/docs/common-sik-telemetry-radio.html#common-sik-telemetry-radio) for telemetry module or an [RC receiver](https://www.frsky-rc.com/product/xsr/) capable of S.BUS, S.Port or P.Port protocol (all UART based).




## Base trolley {#hw_trolley}

### Motors 

The base trolley is based on low cost a 2-wheel remote control toy. Its electronics is removed. Two pairs of wires power the two DC motors in either direction through an L298N H bridge external module. 


{{< gallery >}}
	{{< figure
	src="/img/pendulum_toysrus_flywheels_package.jpg"
	title="FlyWheels toy package"
	>}}

	{{< figure
	src="/img/pendulum_toysrus_flywheels_open.jpg"	
	title="Two DC motors"
	>}}
{{< /gallery >}}

<!-- 
 (pictures: [Package](Toysrus_FlyWheels_package.jpg), [vehicle](Toysrus_FlyWheels_Vehicle.jpg), [RC+vehicle](Toysrus_FlyWheels_Vehicle_Remote.jpg), [Inside](Toysrus_FlyWheels_Open.jpg)) 
 -->

### Power electronics 
The L298N H bridge controls two DC motors. For each motor:

- Two logic signals set the motor state: direction, brake, or free-wheels.
- One logic signal power-up the motor depending on to the state defined. This third signal is modulated with a 100Hz square periodic signal (PWM) whose duty cycle vary from 0% to 100%. It sets the torque for the motor.

The flat multicolor rubbon connects 6 logic control signal (3 for each motor) from the Microstick II dsPIC to the input of the L298N H bridge.

{{< figure
src="/img/pendulum_base.png"
link="/img/pendulum_base.png"
width="60%"
title="Base trolley of the inverted pendulum"
caption="A *L298N H bridge* (for arduino) power board drives the two DC motors of a modified *FlyWheels* toy. *Four AA batteries* powers the pendulum."
numbered="true"
>}}

### Batteries

Four $1.2V$ AA NiMh batteries are dispatched on both side of the trolley. $\approx 4.8V$ powers the motors and the electronics. The black and red wires from the trolley to the top of the pendulum powers the Microstick II electronic and sensors.





# Model

The pendulum model is composed of two intertwined sub-system:

- The pendulum*, with 1 rotation DoF[^DoF] $\theta$ angle around the wheels axis 
- The trolley*, with 1 translation DoF[^DoF] $x$ position. 

## Pendulum

Forces:

- Weight $ \vec{P} = m\vec{g} $
- Friction $ \vec{F} = -k \frac{d\vec{ i }}{dt}  $
- Reaction $ \vec{R} = m\vec{g} . \vec{i} + \frac{l}{m} \frac{d^2\vec{ i }}{dt^2} . \vec{i}  $

Accelerations:

- Acceleration $ \vec{A} = l \frac{d^2\vec{ i }}{dt^2} $




Tangentiel:
$$ P_t = mg \sin{\theta} - k\dot {\theta} $$ 
$$ A_t = l \ddot{\theta} $$

$$ \ddot{\theta} + \frac{k}{l}\dot {\theta} - \frac{g}{l} \theta = 0 $$


The rotational movement of the pendulum is modeled as a $2^{nd}$ order system. The pendulum is characterized by 

- its natural oscillation frequency $w_n = \sqrt{ \frac{g}{L} } $ which depends only of the length $L$ of the pendulum (trolley wheels axis to center of mass of the pendulum) and
- a damping factor $\zeta$. 

$$ \theta(s) \left ( \frac{1}{w_n^2}s^2 - \frac{2 \zeta}{w_n}s - 1 \right ) = 0  $$
$$ F_p(s) = \frac{1}{ \frac{1}{w_n^2}s^2 - \frac{2 \zeta}{w_n}s -1 } $$

|Pendulum Parameters|Identified Value|
| :---: | :---: |
| $L$  | $0.45 m$ |
| $k$  |$0.4$ |
| $w_n = \sqrt{\frac{g}{L}}$  | $0.37 rad.s^{-1}$ ( $2.33 Hz$ ) |

The parameter $L$ could be measured from the platform hardware but the damping factor $\zeta$ depends on friction and cannot be measured.

 Both $L$ and $\zeta$ are determined by an identification on the free oscillating pendulum:

 The pendulum is placed up-side-down between two chair back. Motors are off ; the pendulum is let free to oscillate. The initial state is $\approx \frac{\pi}{2} \deg$ angle from the rest position. It oscillates at its natural frequency $w_n$ until the damping friction ($\zeta$) stop the oscillations. Angular speed and accelerations $1kHz$ samples are recorded onboard na [openlager](https://github.com/d-ronin/openlager/wiki) board connected on the [UART](#UARTINTERFACE) interface.
 
 Recorded data fed a Simulink model which reconstruct the pendulum angle with a data fusion IMU algorithm. Then the pendulum angular oscillations is compard against a pendulum model output. The model parameters $L$ and $\zeta$ are tuned to best fit with the experimental data. See results in the table. 


## Trolley

The translational movement of the trolley is modeled as a $1^{st}$ order system characterized by its time constant $\tau$. This dynamic include the motor dynamics when it is loaded with the trolley considering the pendulum as vertical. The model do not consider the impact of the non vertical pendulum on the trolley translation, nor the couple applied on the pendulum when motors applies a couple on the wheels. 

$$ x(s) = \frac{1}{\tau s + 1}$$

|Trolley Parameter|Estimated Value|
| :---: | :---: |
| $\tau$  | $0.3s$ |

The trolley is not equipped with any sensors. Thus the parameters $\tau$ is guessed instead of identified. 

The overall pendulum model including the trolley is simulated with its feedback loop controller and results are compared against recorded data of the real systme running the same feedback loop controller. The simulated pendulum states are re-initialised periodically ($\approx 2s$) with the real pendulum states as the model would diverge otherwise due to perturbations not modeled and model discripancies. Corectness of the model can be checked between theses periodic re-initialisation.


# Controller

`Stabilization overview:` The microcontroller computes the angle of the pendulum from the inertial sensor measurements (accelerometers and rate gyro). A feedback loop stabilize the pendulum up right while maintaining the pendulum position still. The pendulum translation is estimated through an internal dynamic model of the trolley stimulated with a copy of the DC motor command. The pendulum slow translations reflect the drift of the internal estimation of the displacement.




Video of the inverted Pendulum when it encounters a wall:
{{< vimeo id="309876329" caption="Inverted pendulum pushing a wall">}}
<!-- You tube alternative: {{< youtube id ="xbu4hXOnemE" >}} -->


[^IMU]: Inertial Measurement Unit
[^DoF]: Degree of Freedom
[^LQR]: Linear Quadratic Regulator
[^DIY]: Do It Yourself
