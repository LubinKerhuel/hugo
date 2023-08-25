---
title: Prototypage Rapide avec Simulink sur dsPIC

sitemap:
  priority: 1

slides:
  # Choose a theme from https://github.com/hakimel/reveal.js#theming
  theme: black  # Reveal JS theme name
  highlight_style: dracula  # Highlight JS theme name
  
  #slide_number: true
  progress: true 
  transition: zoom
  transition_speed: fast
  history: false

  defaultTiming: 120
  mouseWheel: true

  previewLinks: true

  backgroundTransition: fade
  
---

## Prototypage Rapide 
### Model Based Design

<p class="stretch">
<a href="https://fr.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink-dspic-pic32-and-sam-mcu/">
<img data-src="/img/logo_mplab-deviceblocksforsimulink-whitebackground.png">
</a>
</p>

\[[Lab](https://rtdc.ctrl-elec.fr/)\] - [L.Kerhuel](/authors/lubin) - [R.Delpoux](/authors/romain-delpoux)

---
## Plan:
- Model Based Design
  - Model

- De la simulation au programme embarqué
  - Différences temporelles
  - type de données et optimisation

---
{{< slide transition="fade"  transition_speed="slow">}}
## Model Based Design (MDB)

![./Picooz_01_Close.jpg](./Picooz_01_Close.jpg)

---
{{< slide transition="fade"  transition_speed="slow">}}
## Model Based Design (MDB)

![./Picooz_01_Open.jpg](./Picooz_02_Open.jpg)

---
{{< slide transition="fade"  transition_speed="slow">}}
## Model Based Design (MDB)

![./Picooz_03_Close.jpg](./Picooz_03_Motor.jpg)

---
{{< slide background-color="#FFFFFF" >}}

<p class="stretch">
<img data-src="./Picooz_DC_Motor_Electronic_All.png">
</p>

{{< speaker_note >}}
Commande en Vitesse
{{< /speaker_note >}}   

---

## Model Based Design (MDB)
![./Picooz_IdentificatoinBlockPresentation.png](./Picooz_IdentificatoinBlockPresentation.png)

{{< speaker_note >}}
Identification
{{< /speaker_note >}}   


---
## Model Based Design (MDB)

{{< vimeo id="309895581" autoplay="false" >}}
<!-- {{< vimeo id="309895581" class="stretch" autoplay="false" title="test" >}} -->
<!-- [Video](C:/M91449/MCHP_Blockset/Developpements/2013_08_19_Masters2013/Fig/Video_Logs_Shirp.avi) -->

---

![./Picooz_Identificatoin_eq_01.png](./Picooz_Identificatoin_eq_01.png)

---

![./Picooz_Identificatoin_eq_02.png](./Picooz_Identificatoin_eq_02.png)

{{< speaker_note >}}
rasoir d'Ockham
{{< /speaker_note >}}   


---

![./Picooz_SuperTwistingController.png](./Picooz_SuperTwistingController.png)

---
{{< slide background-color="#FFFFFF" >}}

<section data-background-image="./Picooz_SetpLarge_ClosedLoop_SimuVsReal.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>

{{< speaker_note >}}
Prediction Simu vs reel
{{< /speaker_note >}}   

---
## <span style="color:yellow">Model</span> Based Design

1. Identification
1. Simulation / synthèse commande
1. Test

---

## TP: Validation du modèle de moteur DC fournit

- log de command & réponse
- Simulation comparaison 
  - commande avec modèle moteur
  vs
  - système réel

---
## TP: Validation du modèle de moteur DC fournit

![./Simulink_DCMotorPravalux_LogVsSimu.png](./Simulink_DCMotorPravalux_LogVsSimu.png)

---

## De la simulation au programme embarqué

---

{{< vimeo id="309876246" autoplay="false" >}}

---
## [Pendule inverse](/docs/inverted-pendulum/)

![./Inverted_Pendulum_ControlLoopCloseUp.png](./Inverted_Pendulum_ControlLoopCloseUp.png)
{{< speaker_note >}}
  1) Couleurs : Period echantillonnage
  2) Datatype  
{{< /speaker_note >}}   

---

## Aspect Temporel:
### Simulation

Modélisation en temps continue: 

transformé de Laplace en p (s)

  - Solver résoud les équations différentielles
    - approximation numérique  
  - Pas de contraintes temps réelle
    - différent solveurs (Runge-Kutta, ODEx,...)
  
{{< speaker_note >}}
  1) Couleurs : Period echantillonnage
   DSPACE discretise le modèle
{{< /speaker_note >}}   

---

## Aspect Temporel:
### Implémentation

Implémentation en temps discret:

"pas" de calcul fixe

  - pas de solveur 
  - Contrainte temps réel    
    - model Single-Rate & Multi-Rate
    - implementation Single-Tasking & Multi-Tasking

{{< speaker_note >}}
  Single Rate / Multi rate
  Single Tasking / Multi Tasking 
{{< /speaker_note >}}   

---

## Discrete times

- **Single-rate**:
  - Les blocks ont tous la même période d'exécution
    (Même couleur)

- **Multi-Rate**
  - Les blocks peuvent avoir des périodes d'exécution différentes
    (Schéma multicolore)

---
#### Modèle multi-rate

<p class="stretch">
<img data-src="./Model_Hardware_Test_withSampleTime.png">
</p>

<section data-background-image="./Scope_SingleTasking_70MIPS.png" data-background-opacity=0.06 data-background-position="center" >
</section>

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

{{< speaker_note >}}
  OVERLOAD
{{< /speaker_note >}}   

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

#### Charge CPU d'un modèle multi-rate multi-tasking (@70 mips) 

![./Scope_MultiTasking_70MIPS.png](./Scope_MultiTasking_70MIPS.png)

<section data-background-image="./Scope_MultiTasking_70MIPS.png" data-background-opacity=0.06 data-background-position="center" >
</section>

---

#### Charge CPU d'un modèle multi-rate multi-tasking (@20 mips) 

![./Scope_MultiTasking_20MIPS.png](./Scope_MultiTasking_20MIPS.png)

<section data-background-image="./Scope_MultiTasking_20MIPS.png" data-background-opacity=0.06 data-background-position="center" >
</section>

---

![./Scope_MultiTasking_70MIPS.png](./Scope_MultiTasking_SchedulerIllustration.png)

<section data-background-image="./Scope_MultiTasking_70MIPS.png" data-background-opacity=0.06 data-background-position="center" >
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

{{< speaker_note >}}
  20 MIPS ok avec multi-tasking
  Single tasking: deterministe
{{< /speaker_note >}}   

---

# Optimisation 

## type de données

- Virgule Fixe
- Virgule Flottante

---

## Virgule fixe

### int8


$\underbrace{1}\_{sign\ (1)} \ \underbrace{1111111}\_{mantisse\ (7)} * \underbrace{slope}\_{\text{LSB value}}$

- $v = (mantisse-sign*128) * slope $

- plage: $\pm 2^{7} * slope$
 
- 2 digit [0-9] significatifs

{{< speaker_note >}}
  slope est fixe
{{< /speaker_note >}}   

---

<section data-background-image="./FloatFixed_1.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>

---

{{% section %}}

## Virgule flotante

### Single (32 bits)


$\underbrace{1}\_{sign\ (1)} \ \underbrace{11111111}\_{exponent\ (8)} \ \color{yellow}{1}\underbrace{11111111111111111111111}\_{mantisse\ (23)} $

- $v \approx (1-2 sign) * mantisse * 2^{exponent-127}$

- plage: $\pm 2^{128} = \pm 3.4*10^{38}$
 
- 7 digit [0-9] significatifs

{{% /section %}}
{{% section %}}

 IEEE 754| Single | Double |
|:---:|:---:|:---:|
 Format width | 32 | 64 |
 Sign bit |1 | 1 |
 exponent width | 8 | 11 |
 Precision width| 23<span style="color:yellow">+1</span> | 52<span style="color:yellow">+1</span> |

<span style="color:yellow">1st</span> phantom bitof the significand is always 1.

{{% /section %}}

---
## Virgule flotante

### Custom (8 bits)


$\underbrace{1}\_{sign\ (1)} \ \underbrace{1111}\_{exponent\ (4)} \ \color{yellow}{1}\underbrace{111}\_{mantisse\ (3)} $

- $v \approx (1-2 sign) * mantisse * 2^{exponent-127}$

- plage: $\pm 2^{128} = 3.4*10^{38}$
 
- 0.9 digit [0-9] significatifs

---

## Custom 8 bit Floating point

 Parameter | Single | Double | Custom 
|:---:|:---:|:---:|:---:|
 Format width | 32 | 64 | 8 |
 Sign bit |1 | 1 | 1 |
 exponent width | 8 | 11 | 4 |
 Precision width| 23+1 | 52+1 | 3+1 | 
 
---

<section data-background-image="./FloatFixed_2.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>

---

<section data-background-image="./FloatFixed_3.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>

---

<section data-background-image="./FloatFixed_4.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>

{{< speaker_note >}}
  Integrateur (avec petit TS)
  GPS
{{< /speaker_note >}}  


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

<p class="stretch">
<img data-src="./Simulink_TypeCast_FixPtFormat.png">
</p>

---

## Data-type notation

- int8...uint23
- fixdt(1,16)
  - signed (1)
  - 16 bit width
  - Scaling is derived from defined min & max
- fixdt(1,16,15)
  - Scaling is <span style="color:yellow">En</span>15 (Exp neg $\rightarrow 2^{-15}$) 
- fixdt(1,16,-15)
  - Scaling is <span style="color:yellow">E</span>15 (Exp $\rightarrow 2^{15}$)    

---

## Datatype notation

![./Simulink_TypeCast_SlopeAndBias.png](./Simulink_TypeCast_SlopeAndBias.png)

- fixdt(1,16,.01,0)
  - Scaling is sfix16<span style="color:yellow">Sp</span>01 
    - Slope point 01    

---

![./Simulink_TypeCast_SlopeAndBias_Sat.png](./Simulink_TypeCast_SlopeAndBias_Sat.png)
- <span style="color:yellow">SI</span>: Stored Integer
- <span style="color:yellow">RWV</span>: Real World Value

---

## TP


[https://rtdc.ctrl-elec.fr/](https://rtdc.ctrl-elec.fr/)


---

## download

- [base model](https://github.com/rdelpoux/INSA_TP_CommandeTempsReel_MCC/raw/master/LABMatlabFiles/02_GettingStarted/MCLV2_dsPIC33EP256MC506_base_R2017a.zip)


---

## Elements de correction

---

## Liens:

- MPLAB device blocks for Simulink:
	https://www.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink
- MPLAB X:
	https://www.microchip.com/MPLABX
- XC16:
	https://www.microchip.com/XC16

- https://lubin.kerhuel.eu
- https://www.ctrl-elec.fr


---
# Slide control:

- Next: `Right Arrow` or `Space`
- Previous: `Left Arrow`
- Start: `Home`
- Finish: `End`
- Overview: `Esc`
- Speaker notes: `S`
- Fullscreen: `F`
- Zoom: `Alt + Click`