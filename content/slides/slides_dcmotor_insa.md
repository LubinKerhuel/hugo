﻿+++
title = "Prototypage Rapide avec Simulink sur dsPIC"


[reveal_hugo]
# Choose a theme from https://github.com/hakimel/reveal.js#theming
theme = "black"

#slide_number = true
progress = true 
transition = "zoom"

+++
 
# Prototypage rapide

## avec Simulink sur dsPIC

[MPLAB device blocks for Simulink](https://www.microchip.com/SimulinkBlocks)

L.Kerhuel & R.Delpoux

<section data-background-image="./Model_Hardware_Test_withSampleTime.png" data-background-opacity=0.06>
</section>

---

## Pendule inverse

![./Inverted_Pendulum_ControlLoopCloseUp.png](./Inverted_Pendulum_ControlLoopCloseUp.png)

<section data-background-image="./Model_Hardware_Test_withSampleTime.png" data-background-opacity=0.06>
</section>

---

![./Model_Hardware_Test_withSampleTime.png](./Model_Hardware_Test_withSampleTime.png)


---

![./Picooz_IdentificatoinBlockPresentation.png](./Picooz_IdentificatoinBlockPresentation.png)

[Video](C:/M91449/MCHP_Blockset/Developpements/2013_08_19_Masters2013/Fig/Video_Logs_Shirp.avi)

---

![./Picooz_Identificatoin_eq_01.png](./Picooz_Identificatoin_eq_01.png)

---

![./Picooz_Identificatoin_eq_02.png](./Picooz_Identificatoin_eq_02.png)

---

![./Picooz_SuperTwistingController.png](./Picooz_SuperTwistingController.png)

---

{{< slide background-color="#FFFFFF" >}}


![./Picooz_SetpLarge_ClosedLoop_SimuVsReal.png](./Picooz_SetpLarge_ClosedLoop_SimuVsReal.png)



---

## Plan:
Modèle de simulation & génération de code

- Différences Temporel
- optimisation et type de données
- blocks et fonctionnalités Simulink

{{< speaker_note >}}
DSPACE 
{{< /speaker_note >}}

---

## Aspect Temporel:
### Simulation

Modélisation en temps continue, transformé de Laplace dans le domaine p (ou s)

  - Solver résout les équations différentielles
  - Pas de contrainte temps réelle
  - Résultat dépend du solveur ; pas de calcul variable.
 
---

## Aspect Temporel:
### Implémentation

Implémentation en temps discret avec un pas de calcul fixe

  - pas de solveur 
  - Contrainte temps réel
  - Single-Rate & Multi-Rate
  - Single-Tasking & Multi-Tasking

<section data-background-image="./Scope_SingleTasking_70MIPS.png" data-background-opacity=0.06 data-background-position="center" >
</section>

---

## Discrete times

- **Single-rate**:
  - Les blocks ont tous la même période d'exécution
    (Même couleur)

- **Multi-Rate**
  - Les blocks peuvent avoir des périodes d'exécution différentes
    (Schéma multicolore)


<section data-background-image="./Scope_SingleTasking_70MIPS.png" data-background-opacity=0.06 data-background-position="center" >
</section>

---

#### Modèle multi-rate

![./Model_Hardware_Test_withSampleTime.png](./Model_Hardware_Test_withSampleTime.png)

---

#### Charge CPU d'un modèle multi-rate single-tasking (@70 mips)

![./Scope_SingleTasking_70MIPS.png](./Scope_SingleTasking_70MIPS.png)

<section data-background-image="./Scope_SingleTasking_70MIPS.png" data-background-opacity=0.06 data-background-position="center" >
</section>


---

#### Charge CPU d'un modèle multi-rate single-tasking (@20 mips) 

![./Scope_SingleTasking_20MIPS.png](./Scope_SingleTasking_20MIPS.png)

<section data-background-image="./Scope_SingleTasking_20MIPS.png" data-background-opacity=0.06 data-background-position="center" >
</section>

---

## Single-Tasking

Single-Tasking: Dans le slot de temps, l'exécution de tous les blocks doit se terminer avant la fin du slot. 

---

## Multi-Tasking

Multi-Tasking: Préemption possible -> **Monotonic Rate Scheduler**

- La tâche la plus fréquente à la priorité maximale
  - Préemptera une tache plus lente
  - Beaucoup plus flexible
  - Mode par défaut (voir options du solveur)

---

#### Charge CPU d'un modèle multi-rate single-tasking (@70 mips) 

![./Scope_MultiTasking_70MIPS.png](./Scope_MultiTasking_70MIPS.png)

<section data-background-image="./Scope_MultiTasking_70MIPS.png" data-background-opacity=0.06 data-background-position="center" >
</section>

---

#### Charge CPU d'un modèle multi-rate single-tasking (@20 mips) 

![./Scope_MultiTasking_20MIPS.png](./Scope_MultiTasking_20MIPS.png)

<section data-background-image="./Scope_MultiTasking_20MIPS.png" data-background-opacity=0.06 data-background-position="center" >
</section>

---

## Tasking Conclusion

- Single-Tasking @ 20  MIPS  -> **Overload**
  - dispatcher la tache la plus lente sur plusieurs slots
  - (option d'offset dans **Time Step** -> *[.001 .005])*
- Multi-Tasking @ 20  MIPS  -> **Ok**
  - Rate transfert block options
      - Data Integrity
      - Deterministic data transfert

---

# Optimisation 

## type de données

- Virgule Fixe
- Virgule Flottante


---

![./FloatFixed_1.png](./FloatFixed_1.png)

---

## Flotant

 IEEE 754| Single | Double |
|:---:|:---:|:---:|
 Format width | 32 | 64 |
 Sign bit |1 | 1 |
 exponent width | 8 | 11 |
 Precision width| 23+1 | 52+1 |

1st bit of the significand is always 1. Phantom bit

---

## Custom 8 bit Floating point

 Parameter | Single | Double | Custom 
|:---:|:---:|:---:|:---:|
 Format width | 32 | 64 | 8 |
 Sign bit |1 | 1 | 1 |
 exponent width | 8 | 11 | 4 |
 Precision width| 23+1 | 52+1 | 3+1 | 
 
---

![./FloatFixed_2.png](./FloatFixed_2.png)

---

![./FloatFixed_3.png](./FloatFixed_3.png)

---

![./FloatFixed_4.png](./FloatFixed_4.png)

---
## Script Matlab pour tester un flottant 8 bits

```MATLAB
% 4 bit exponent (signed)
emin = -7; emax = 6; 
% 3 bits significand
p = 3;

exps = 2.^[emin:emax]; 
vals = (2^p) + [0:(2^p-1)];  % significand with leading 1

TotalVal = vals'*exps;

% add denormalized values
8bitFloat = unique([TotalVal  ; 2^emin * [0:(2^m-1)]']);
8bitFloat = unique(flipud(-TotalVal) ;TotalVal]); % with neg vals
```

---

# Simulink 

---

## Data-type 

![./Simulink_TypeCast_FixPtFormat.png](./Simulink_TypeCast_FixPtFormat.png)

---

## Datatype 

- int8...uint23
- fixdt(1,16,15)
  - Scaling is En15 (Exp neg)
    -  $$\rightarrow 2^-15$$
- fixdt(1,16)
  - signed (1)
  - 16 bit width
  - Scaling is derived from min & max


---

## Datatype 

![./Simulink_TypeCast_SlopeAndBias.png](./Simulink_TypeCast_SlopeAndBias.png)

- fixdt(1,16,.01,0)
  - Scaling is sfix16**Sp**01 
    - Slope point 01    

---

![./Simulink_TypeCast_SlopeAndBias_Sat.png](./Simulink_TypeCast_SlopeAndBias_Sat.png)

---

# TP


## https://www.ctrl-elec.fr

https://lubin.kerhuel.eu/slides/slides_dcmotor_insa

---

## Elements de correction

---

![./TP_Correction_OpAmp.png](./TP_Correction_OpAmp.png)


---


![./TP_Correction_ADC.png](./TP_Correction_ADC.png)

---

## PWM settings

---

![./TP_Correction_PWM_Main.png](./TP_Correction_PWM_Main.png)


---


![./TP_Correction_PWM_02.png](./TP_Correction_PWM_02.png)

---


![./TP_Correction_PWM_03.png](./TP_Correction_PWM_03.png)

---


![./TP_Correction_PWM_04.png](./TP_Correction_PWM_04.png)

---


![./TP_Correction_PWM_05.png](./TP_Correction_PWM_05.png)


---

## Liens:

- MPLAB device blocks for Simulink:
	https://www.microchip.com/SimulinkBlocks
- MPLAB X:
	https://www.microchip.com/MPLABX
- XC16:
	https://www.microchip.com/XC16