---
title: Capteur de vitesse air miniature pour avion RC et drones.
subtitle: "Un capteur de vitesse air à tube de Pitot statique (Prandtl) embarqué dans un avion RC : pièces, électronique et performances."

# Project summary to display on homepage.
summary: Construction et validation expérimentale d'un tube de Pitot statique (Prandtl) miniature. Les pièces et la conception électronique sont décrites. La vitesse air mesurée en vol est comparée à la vitesse sol GPS prise comme référence. La vitesse du vent est estimée afin de supprimer le biais entre vitesse air et vitesse sol.

authors:
- Lubin

tags: 
  - Pitot
  - sensor
  - air-speed
  - wind
  - experiment
  - DIY

categories: 
  - electronics
  - sensor

date: 2019-05-28
lastmod: 2019-05-25
featured: true
draft: false

slides: pitot-build

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  alt_text: "Tube de Pitot en carbone fixé à l’aile par un aimant"
  caption: Tube de Pitot en carbone fixé à l'aile par un aimant.
  focal_point: Left
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: 
  - autopilot-plane

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
<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

{{% toc %}}

## Principe du tube de Pitot

Une sonde de Pitot-Darcy est un capteur de vitesse air couramment utilisé en aviation. Elle se compose d'un tube orienté vers l'avant. Lorsque le capteur avance, une pression d'arrêt $P\_t$ s'ajoute à son extrémité. La pression différentielle $P\_{diff}$ est mesurée entre l'extrémité du tube $P\_t$ et la pression statique $P\_s$. Une variante, le tube de Prandtl (du nom de son inventeur), possède des prises de pression statique directement sur le côté du tube.

La pression ajoutée à l'extrémité du tube est proportionnelle au carré de la vitesse air : $P\_t = P\_s + \frac{1}{2}\rho v^2$ où $ P\_t $ et $P\_s$ sont mesurées en pascals (Pa). $\rho$ est la masse volumique de l'air, généralement comprise dans l'intervalle $[1.14 \ 1.34]$ selon la température et l'altitude. $v$ est la vitesse air en $m.s^{-1}$. La pression différentielle mesurée est $P\_{diff} = P_t - P_s = \frac{1}{2}\rho v^2$ 

## Tube de Pitot-Prandtl

Le tube de Prandtl est une version de la sonde de Pitot dans laquelle un tube interne est placé au centre d'un tube externe. L'espace entre les deux tubes est comblé, sur quelques mm près de l'extrémité, avec une colle époxy (Araldite ou équivalent). Le côté du tube externe est percé pour capter la pression statique. En bas, le tube interne, plus long, sert de raccord pour le capteur de pression dynamique, et un troisième tube court est ajouté pour créer un raccord vers la zone de pression statique, qui se situe dans l'espace vide entre les deux tubes.

Les trous de pression statique doivent être percés à une distance minimale de l'extrémité du tube, où les perturbations de l'écoulement d'air sont réduites. Une distance égale à 4 fois le diamètre (d=4mm) du tube externe (16mm) est retenue ici. Quatre trous de 1mm ont été percés avec un outil rotatif Dremel. Les trois tubes sont présentés sur la figure ci-dessous.

Pour le premier essai, des tubes en laiton ont été utilisés. Le tube interne mesure 2/1mm (extérieur/intérieur) et le tube externe 4/3mm.

{{< figure 
src="/img/pitot-darcy-prandtl-build-brasstubes.jpg"
link="/img/pitot-darcy-prandtl-build-brasstubes.jpg"
width="80%"
title="Tubes interne et externe en laiton du tube de Pitot."
caption="Tube Alfer acheté chez Leroy Merlin. Le tube interne mesure 2mm/1mm. Le tube externe mesure 4mm/3mm.  La longueur du tube externe est m=86mm. Quatre trous de 1mm sont percés à l=16mm de l'extrémité."
numbered="true"
>}}

Références :

- [rapport WIND-TUNNEL INVESTIGATION OF 'A NUMBER OF TOTAL-PRESSURE TUBES AT HIGH ANGLES OF ATTACK SUBSONIC, TRANSONIC, AND SUPERSONIC SPEEDS'](https://ntrs.nasa.gov/api/citations/19930092297/downloads/19930092297.pdf) de W. Gracey sur l'influence de la forme sur la mesure.
- [rapport (en français)](https://www.planete-sciences.org/espace/IMG/pdf/tube_de_pitot.pdf) de l'ANSTJ avec des informations générales sur le capteur de Pitot.
- [site web (en français)](http://voiletech.free.fr/skyassistant/pitot.htm) de Rémi Bourgin présentant un tube de Pitot expérimental pour avion RC

<!-- Tube laiton macif (alfer) au Leroy Merlin;

Tube intèrieur: 2mm, trou 1mm
Tube extèrieur: 4mm, trou 3mm

Longueur total:
d = 4mm
l = 4d => 16mm
m = 11d =>44mm

Tube altigator:
d = 4mm
l = 18mm
m = 72mm
-->
 
## Électronique

### Exigences de sensibilité et capteur de pression

La pression différentielle mesurée varie avec le carré de la vitesse. La vitesse d'un avion RC peut être relativement faible. L'enjeu est de conserver une sensibilité suffisante pour mesurer correctement les basses vitesses, de quelques mètres par seconde.

Le [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP#/) de NXP est un capteur de pression différentielle sensible. Sa plage de mesure différentielle va de 0 à 3,92 kPa. La sortie analogique est ratiométrique et varie de 0,6V à 3V ($\Delta V =2.4V$). À titre de repère, 1 kPa correspond approximativement à la pression de 10cm d'eau.

L'étude porte sur une plage de vitesses allant de $0$ à $25 m.s^{-1}$ ($90km/h$), ce qui correspond à une pression différentielle maximale de 3,75 cm d'eau, soit 0,375 kPa. Le capteur MP3V5004DP est par conséquent utilisé à 10 % de sa plage nominale.

Le tableau ci-dessous donne la pression différentielle théorique attendue pour diverses vitesses, avec $P_{diff} = \frac{1}{2}\rho v^2$ et $\rho=1.15$.

| v (m/s) | v (Km/h) | $P_{diff}$ (Pa) | ~ $H_2O$ (cm) | [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP#/) & [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428)  (0.2041Pa / LSB[^LSB]) |
|:-:|:-:|:-:|:-:|:-:|
| 1 | 3.6	| 0.6	 |0.006 | 3 |
| 2 | 7.2	| 2.4	 |0.024 | 12 |
| 4 | 14.4| 	9.6 |	0.096 | 47 |
| 7 | 25.2	| 29.4 |	0.294 | 144 |
| 10 | 36	| 60	 | 0.6 | 294 |
| 15 | 54	| 135	 |1.3 | 661 |
| 20 | 72	| 240	 |2.4 | 1176 |
| 25 | 90	| 375	 |3.75 | 1837 |
| 30 | 108	| 540	 |5.4 | 2646 |
| 40 | 144	| 960	 |9.6 | *4704* (4095 sat) |

### Conditionnement du signal et conversion

L'électronique du capteur de pression est placée dans l'aile, à proximité (~10cm) du tube de Pitot. La conversion analogique-numérique est intégrée à la carte du capteur. Le [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) de Microchip est un convertisseur sigma-delta haute résolution avec un gain programmable de 1 à 8. Il communique par bus I2C et son adresse I2C est sélectionnable. D'autres convertisseurs similaires sont envisageables : les MCP342x, la famille plus récente MCP346x ou la MCP356x offrent une précision accrue et une cadence d'échantillonnage plus élevée ; en revanche, leur boîtier, plus petit, est plus difficile à manipuler pour un prototype artisanal.

Le signal analogique de sortie du [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP#/) est relié au CAN sigma-delta [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) par un filtre passe-bas RC du premier ordre de fréquence de coupure $28Hz$ ($R=5.6 kOhm$,$C=1\mu F$). La 2ᵉ entrée différentielle est reliée à un pont diviseur de tension pour obtenir 1V à partir de la référence 3,3V (480 & 1kOhms). Des condensateurs de découplage de $10\mu F$ sont placés sur l'alimentation. Les lignes du bus I2C sont rappelées à l'alimentation par des résistances de 10kOhm et reliées à un condensateur de 10pf qui les protège des parasites.
<!-- Measured 480 840 for the divisor. Write down 560 and 1.2k -->

Le CAN sigma-delta [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) est configuré ainsi :

- 12 bits
- gain x8
- 240 échantillons par seconde (SPS)

La résolution obtenue est donnée par :

- (1) La sensibilité de la sortie analogique du [MP3V5004dp](https://www.nxp.com/part/MP3V5004DP#/) est de 1633 Pa/V
- (2) [MCP3428](https://www.microchip.com/wwwproducts/en/MCP3428) 12 bits avec un gain de 8 : 0,125mV/LSB[^LSB]

Avec (1) et (2), on obtient une résolution de $1633 * 0.125e^{-3} $ =  ***0,2041 Pa / LSB[^LSB]*** 

{{< figure 
src="/img/pitot-darcy-prandtl-build-mp3v5004dp-mcp3428.jpg"
link="/img/pitot-darcy-prandtl-build-mp3v5004dp-mcp3428.jpg"
width="80%"
title="Capteur de pression et électronique montés sur une carte adaptatrice DIP."
caption="Capteur de pression différentielle (MP3V5004dp) avec convertisseur analogique-numérique intégrant un amplificateur différentiel (MCP3428). Le MCP3428 communique avec le microcontrôleur par un bus I2C. Un régulateur de tension 3,3V MCP1700 adapte et filtre la tension d'entrée de 5V."
numbered="true"
>}}

### Essais statiques du capteur

Une mesure de 90 minutes en intérieur, sans mouvement, a été effectuée, la sortie du capteur étant enregistrée à 100Hz. La figure ci-dessous met en évidence une dérive lente (corrélée à la température ou à la décharge de la batterie ? À DÉTERMINER). L'écart-type mesuré sur l'ensemble de l'enregistrement est de 0,54 Pa (dérive incluse).

{{< figure 
src="/img/pitot-darcy-prandtl-static-characteristic.png"
link="/img/pitot-darcy-prandtl-static-characteristic.png"
width="100%"
title="Caractéristique statique expérimentale du tube de Pitot avec le capteur de pression différentielle MP3V5004dp"
caption="Une mesure statique de 90 minutes en intérieur met en évidence une dérive lente et un écart-type de 0,54 Pa. La résolution est de 0,2041 Pa / LSB"
numbered="true"
>}}

#### Sources possibles de bruit et de décalage (offset)

Le capteur est sensible à sa propre orientation. Retourner le capteur introduit un décalage négatif de 12,5mV (100 LSB[^LSB] avec la configuration du circuit de conversion analogique-numérique).

Le MCP3428 et le MP3V5004dp sont tous deux alimentés en 3,3V. Un régulateur linéaire de tension ([MCP 1700](https://ww1.microchip.com/downloads/en/DeviceDoc/20001826D.pdf)) filtre l'entrée 5V de la carte capteur pour la ramener à 3,3V. Le signal analogique reste néanmoins sensible aux fluctuations de l'entrée 5v. Il convient de surveiller la télémétrie, qui perturbe l'alimentation lorsqu'elle ne dispose pas de son propre régulateur. Par ailleurs, les salves électromagnétiques du module de télémétrie peuvent perturber l'ensemble de l'électronique, y compris la masse ; j'ai observé sur la sortie du Pitot une salve périodique corrélée aux paquets MAVLink émis (20 à 300 LSB, aucune perturbation sur les capteurs de l'IMU). Elle était due à un module de télémétrie 3DR dont l'antenne était placée trop près d'éléments électroniques non protégés. J'ai corrigé ce défaut en éloignant l'antenne et en réduisant la puissance d'émission.

## Montage en vol

Le capteur est monté sur l'aile d'un avion RC FirStar 1600.

{{< figure 
src="/img/firstar1600-qx7.jpg"
link="/img/firstar1600-qx7.jpg"
width="80%"
title="Avion RC FirStar 1600 Volantex"
caption="Avion utilisé pour les vols d'essai"
numbered="true"
>}}

Un tube flexible de 2mm, à l'origine destiné à protéger les lignes de pêche, relie le capteur au tube de Pitot.

{{< figure 
src="/img/pitot-darcy-prandtl-tubesoupledecathlon.jpg"
link="/img/pitot-darcy-prandtl-tubesoupledecathlon.jpg"
width="50%"
title="Flashmer – tube flexible 2mm. Image Decathlon (France)."
caption="Tube de pêche utilisé pour relier le capteur de pression différentielle MP3V5004dp au tube de Pitot."
numbered="true"
>}}

Un aimant est collé sur le tube de Pitot. Un 2ᵉ aimant intégré à l'aile permet de fixer le tube de Pitot. Les deux aimants sont en contact. Le tube reste fermement en place pendant les vols et se détache en cas d'atterrissage brutal, ce qui limite les dégâts. Cette solution modulable permet d'évaluer d'autres conceptions de tube de Pitot ; elle est également pratique pour le rangement et le transport.

{{< figure 
src="/img/pitot-darcy-prandtl-wing-brass-mp3v5004dp-mcp3428.jpg"
link="/img/pitot-darcy-prandtl-wing-brass-mp3v5004dp-mcp3428.jpg"
alt="Tube de Pitot en laiton avec sa carte électronique, monté sur la plateforme à voilure fixe Firstar 1600"
width="100%"
title="Tube de Pitot en laiton avec sa carte électronique, embarqué sur l'avion Firstar 1600."
numbered="true"
>}}

{{< figure 
src="/img/pitot-darcy-prandtl-wing-carbon2.jpg"
link="/img/pitot-darcy-prandtl-wing-carbon2.jpg"
width="60%"
title="Capteur à tube de Pitot léger en carbone et laiton, fixé à l'aile par un aimant."
caption="Le tube externe est un tube en carbone de 5/3mm. Le tube interne est un tube en laiton de 2mm/1mm."
numbered="true"
>}}

## Résultats expérimentaux

Le MCP3428 échantillonne $P\_{diff}$ à 250Hz pendant les vols. $V\_{Pitot}=\sqrt{\frac{2}{\rho}*P\_{diff}}$ avec $\rho = 1.15$.

Aucun étalonnage n'a été nécessaire. L'échelle théorique de sortie du capteur et la formule permettant de déterminer la vitesse à partir de la pression ont été utilisées. La valeur de $\rho$ a été ajustée de la valeur par défaut 1,2 à 1,15, ce qui minimisait l'erreur moyenne ; l'amélioration n'était cependant pas significative. La seule valeur à ajuster est le décalage (zéro) de la mesure brute de pression. La valeur du zéro pour le capteur utilisé est -1800. 

Script MATLAB convertissant les données brutes du MCP3428 à 250Hz en pression (Pa) et en vitesse (m/s) :

```matlab
% Pitot Calibration. P_pitot is a vector with raw MCP3428 output read from I2C bus.
P_pitot_cal =  0.2041* (double(P_pitot) + 1800);	% to Pa unit

% Compute Speed (m/s) from diff pressure (in Pa).
V_pitot = sqrt(max(0,(2/1.15) * P_pitot_cal));
```

### Comparaison avec la vitesse sol GPS {#gps-vs-airspeed}

Par temps calme, la vitesse sol $V\_{GPS}$ et la vitesse air $V\_{Pitot}$ sont égales.

En présence de vent, on estime la direction et la force moyennes du vent en combinant $V\_{GPS}$, $V\_{Pitot}$ et la direction de lacet de l'avion $\Theta\_{heading}$ (obtenue avec le COG[^COG] du GPS). Cette [estimation du vent](#wind-estimation) est décrite plus loin.

La vitesse sol de l'avion (GPS) est estimée par la différence entre la vitesse air (Pitot) et le vent projeté sur la direction d'avancement de l'avion :

 $V\_{GPS} \approx V\_{Pitot} - V_{wind}*cos(\Theta\_{heading} + \Theta\_{wind}) $

La figure ci-dessous présente la vitesse air en bleu. La vitesse sol reconstruite (noir) concorde précisément avec la vitesse GPS (rouge), ce qui confirme la justesse de la mesure de vitesse air ainsi que de la force et de la direction du vent. Le vent de mer est laminaire, avec de faibles turbulences. La mesure de vitesse air présente une sensibilité élevée, même à basse vitesse.

{{< figure 
src="/img/pitot-darcy-prandtl-gps-wind-calibration.png"
link="/img/pitot-darcy-prandtl-gps-wind-calibration.png"
width="100%"
title="Mesure expérimentale comparant la vitesse sol GPS à la vitesse air du tube de Pitot sur 200s d'un vol d'avion RC Firstar 1600. Concordance entre la vitesse sol GPS et la vitesse du tube de Pitot corrigée du vent estimé."
caption="Vitesse sol GPS (rouge). Vitesse air Pitot (bleu) calculée avec $\rho=1.15$. Vent de face reconstruit (vert). Vitesse air Pitot moins vent estimé (noir), où $V\_pitot$ est moyennée et sous-échantillonnée d'un facteur 5, ce qui ramène sa fréquence d'échantillonnage de 250Hz à 50Hz. Le vent de face est estimé à partir de l'angle COG du GPS ($\approx \theta\_{heading}$), de la force du vent estimée ($V\_{wind}= 2.5 m/s$) et de sa direction ($\theta\_{wind} = 101°$)."
numbered="true" >}}

Des figures complémentaires figurent dans la [présentation en ligne](/slides/pitot-build/#/10).

La fréquence de mise à jour du GPS est de 10Hz, mais elle est échantillonnée à 50Hz afin de minimiser le retard. Celle du capteur à tube de Pitot est de 240 SPS, mais elle est échantillonnée à 250Hz.

L'erreur est définie par $error = V\_{gps} - \left( V\_{Pitot} - V_{wind}*cos(\Theta\_{heading} + \Theta\_{wind}) \right) $. Sur les 200s du vol présenté sur la figure, l'erreur mesurée est :

|  erreur | m/s | km/h |
|:--:|:--:|:--:|
| moyenne | 0.017 | 0.06 |
| écart-type | 0.74 | 2.6 |

L'erreur RMS est relativement faible au regard de la valeur de vitesse mesurée. Une partie de l'erreur est également due aux rafales de vent et à la précision limitée du GPS, en particulier pour estimer les variations rapides de vitesse verticale.

### Estimation du vent {#wind-estimation}

Le modèle de vent considéré est constant, caractérisé par :

- sa direction constante $\Theta\_{wind}$
- sa force constante $V\_{wind}$

#### Vent => $V\_{Pitot} - V\_{gps}$

La courbe ci-dessous montre la différence entre la vitesse sol (GPS) et la vitesse air (Pitot) en fonction de la direction de vol de l'avion. Cette erreur (points bleus en pointillés) est ajustée par une sinusoïde. Cette sinusoïde est le décalage de vitesse ajouté, pour chaque direction de l'avion dans $[0 \ 2\pi]$, par un vent de force et de direction constantes. L'amplitude et la phase de la sinusoïde permettent de déterminer la force et la direction du vent.

{{< figure 
src="/img/pitot-darcy-prandtl-speed-error-wind-estimation.png"
link="/img/pitot-darcy-prandtl-speed-error-wind-estimation.png"
width="100%"
title="Résultat expérimental présentant la différence entre la vitesse sol GPS et la vitesse air Pitot en fonction de la direction de l'avion, sur 450s de vol de l'avion RC Firstar 1600."
caption="Les points bleus sont la différence de vitesse entre le GPS et le Pitot. La courbe verte continue est la projection sinusoïdale du vent sur la direction de l'avion $\Theta\_{heading}$. La phase de la sinusoïde est la direction du vent ($(\pi-1.37*\frac{180}{\pi})=101°$, d'est en ouest) et son amplitude est la force du vent (2,56m/s). Les valeurs du Pitot sont moyennées et sous-échantillonnées d'un facteur 5."
numbered="true"
>}}

Cette estimation du vent est utilisée pour compenser la vitesse air lors de la comparaison de la vitesse sol GPS $V\_{gps}$ avec la vitesse air Pitot $V\_{Pitot}$ [ci-dessus](/post/pitot-build/#gps-vs-airspeed).

#### Script

Script MATLAB pour estimer le vent hors ligne :

```matlab
% V_gps and V_pitot are two vector with all data measured.
% V_pitot was under-sampled (averaging) by a factor 5 to fit the 50Hz log from the GPS.
% GPS chip update frequency is 10Hz, but it is logged at 50Hz.

V_err = V_pitot -  V_gps;    % Ground and Airspeed difference (i.e. wind) 

M = [cos(COG); sin(COG) ]'; % COG is the direction (Theta in rad) vector data measured from the GPS
y = V_err';
x = M\y;    % Solve wind strength and direction using linear algebra (MMSE)

Theta_Wind = -atan2(x(2),x(1));  % Wind (go to) direction. Azimuth direction is opposite to trigo
V_Wind = sqrt(sum(x(1:2).^2));  % Wind strength (m/s)

plot(COG,V_err','.'); hold on; % plot Error blue dots 
plot([0:.01:(2*pi)],V_Wind*(cos([0:.01:(2*pi)]+ Theta_Wind)),'-k','linewidth',3); % plot wind
```

#### Discussion

Le champ COG[^COG] du GPS n'est pas exactement la direction de lacet de l'avion $\Theta\_{heading}$ mais sa direction de déplacement.
Le COG constitue donc une direction de lacet $\Theta\_{heading}$ biaisée. Il serait préférable d'utiliser l'orientation de l'avion fournie par le capteur IMU. Cette option n'a pas été retenue, afin de réduire le nombre de capteurs de cette démonstration. Le biais du COG reste suffisamment faible si l'on suppose que la vitesse du vent est faible devant la vitesse air de l'avion. Un script plus élaboré pourrait compenser ce biais.

W. Premerlani propose une [estimation du vent](https://drive.google.com/file/d/0ByvTkVQo3tqXVzBYQUZicUNvbEE/view) à partir des seules données GPS. Sur le jeu de données GPS considéré, les essais n'ont pas été concluants lorsque tous les échantillons GPS ont été utilisés pendant les phases où la direction de l'avion varie (c'est-à-dire lorsque la dérivée du COG dépasse un seuil donné). La dynamique du GPS semble trop lente pour fournir des résultats robustes.

#### Autres données de vol

L'avion était équipé de deux GPS :

- un GPS uBlox M8N et 
- un MTK3339.
  
La trace uBlox présentée sur la carte ci-dessous est de meilleure qualité que la trace MTK. Seul le GPS uBlox a été utilisé pour les courbes ci-dessus. La trace MTK peut être affichée sur la [carte](https://www.google.com/maps/d/u/0/embed?mid=1-K7dsmfbMCDL3IQK1z3IEtSduB2OWXr9) (icône en haut à gauche). Le fichier KML peut être ouvert avec Google Earth, qui fournit une vue 3D de la trace montrant l'altitude de l'avion.

<iframe src="https://www.google.com/maps/d/u/0/embed?mid=1-K7dsmfbMCDL3IQK1z3IEtSduB2OWXr9" style="width: 100% ; height: 480px"></iframe>

<!--
Project folder:
C:\M91449\MCHP_Blockset\Projects\2017_10_Autopilote\2018_04_12_LogChampdeTir_PitotNum_magOk_LowWind 
-->

[^COG]: Course Over Ground (route sol)
[^LSB]: Least Significant Bit (bit de poids faible)
