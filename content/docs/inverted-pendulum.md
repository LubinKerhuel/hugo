+++
title = "Inverted Pendulum"

# date = 2018-09-09T00:00:00
# lastmod = 2018-09-09T00:00:00

draft = false  # Is this a draft? true/false
toc = true  # Show table of contents? true/false
type = "docs"  # Do not modify.

# GitRepo = "hugo"

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

## Presentation

{{% alert note %}}
Objective is to build an unstable pendulum platform to experiment various control loop to stabilize it.
{{% /alert %}}

{{< figure
src="/img/pendulum_platform_top.png"
link="/img/pendulum_platform.jpg"
width="45%"
title="Top of the inverted pendulum"
numbered="true"
>}}

The DIY hardware is presented. An overview of the model is given and a LQR feedback control loop tested.


<!-- test code -->
{{< vimeo id="309876246" 
caption="Inverted pendulum stabilized with LQR feedback loop" 
width="50%"
>}}
<!-- You tube alternative: {{< youtube id="dWTK7dTUvCo" >}} -->
Video of the stabilized platform with a 4 state LQR feedback loop. The platform is completely autonomous (no user input).


The top of the pendulum is comparable to a head where the microcontroller acts as a brain and the inertial sensor (accelerometers and rate gyro) as the inner ears. The base of the pendulum is a modified RC toys comprising two wheels driven by two independent DC motor (see [pictures below](#hw_trolley)).





# hardware

The head and the base trolley are described successively. They are separated with an $8mm$ carbon tube. The pendulum length is $0.52m$ from wheel axis to the top. Wheels diameters is $8cm$. Pendulum total weight is $200g$ comprising $111g$ for the 4 AA batteries. 

{{< figure
src="/img/pendulum_platform_reduced_horizontal.png"
link="/img/pendulum_platform.jpg"
width="60%"
title="Inverted Pendulum"
numbered="true"
>}}



## head electronics

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

The unique sensor used is a 6 DoF[^DoF] IMU[^IMU] sensor: the ICM-20608 from invensense mounted on a [drotek board](https://store.drotek.com/sensors/779-imu-6dof-icm20608-invensense-pcb-8944595424761.html) provides:

- a 3 axis Accelerometers and 
- a 3 axis rate gyro.

The ICM-20608 values are read through an I2C interface running at 400kHz. The I2C interface implemented through the I2C blocks for dsPIC enable hot plug of the sensor: The microcontroller sends an initialization sequence for the sensor each time this last is detected. Others sensor boards were tested endowed with MPU9250 and MPU6050 chips. The GY-91 board is currently the more commonly found on the market and has 10 DoF[^DoF].

- The accelerometer is configured with a range of $\pm 8g$ low pass filtered at $99Hz$.
- The rage gyro is configured with a range of $\pm 500 \deg/s$ low pass filtered at $250Hz$.

The PCB board provides a $3.3V$ regulator and 4 pin extra interface ( GND, +3.3v, Tx, Rx ) to connect either a data logger, a radio link for telemetry module or an RC receiver capable of S.BUS or S.Port protocol (i.e. UART based).



## Base trolley {#hw_trolley}

### Motors 

The base trolley is based on low cost a 2-wheel remote control toy. Its electronics is removed. Two pairs of wires power the two DC motors in either direction through an L298N H bridge external module. 



{{< figure
src="/img/pendulum_toysrus_flywheels_package.jpg"
link="/img/pendulum_toysrus_flywheels_package.jpg"
width="50%"
title="FlyWheels toy package"
numbered="true"
>}}

{{< figure
src="/img/pendulum_toysrus_flywheels_open.jpg"
link="/img/pendulum_toysrus_flywheels_open.jpg"
width="50%"
title="Inside of the FlyWheels toy with its two DC motors"
numbered="true"
>}}


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

The pendulum model is composed of two intertwinned sub-system:

- The *1 DoF pendulum*, with 1 rotational DoF[^DoF] around the wheels axis 
- The *1 DoF trolley*, with 1 horizontal translation DoF[^DoF]. 

## 1 rotational DoF pendulum

The rotational movement of the pendulum is modeled as a $2^{nd}$ order system. The pendulum is characterized by a its natural oscillation frequency $f_0 = \frac{1}{2\pi}\sqrt{\frac{g}{L}}$ and its damping factor $\gamma$ where $L$ is the length of the pendulum (from trolley wheels axis to center of mass of the pendulum). 


## 1 translational DoF trolley

The translational movement of the trolley is modeled as a $1^{st}$ order system characterized by its time constant $\tau$. This dynamic include the motor dynamics when it is loaded with the trolley ; neglecting the impact of the inverted pendulum considered as vertical. The model is simplified as we do not consider the impact of the pendulum on the trolley translation, nor the couple applied on the pendulum when motors are powered resulting from frictions. 




# Controller

`Stabilization overview:` The microcontroller computes the angle of the pendulum from the inertial sensor measurements (accelerometers and rate gyro). A feedback loop stabilize the pendulum up right while maintaining the pendulum position still. The pendulum translation is estimated through an internal dynamic model of the trolley stimulated with a copy of the DC motor command. The pendulum slow translations reflect the drift of the internal estimation of the displacement.




Video of the inverted Pendulum when it encounters a wall:
{{< vimeo id="309876329" caption="Inverted pendulum pushing a wall">}}
<!-- You tube alternative: {{< youtube id ="xbu4hXOnemE" >}} -->


[^IMU]: Inertial Measurement Unit
[^DoF]: Degree of Freedom