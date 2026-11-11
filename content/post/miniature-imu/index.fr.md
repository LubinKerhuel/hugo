---
# Project title.
title: Centrale inertielle miniature (IMU)
subtitle: Estimer l'attitude à partir de capteurs inertiels MEMS à faible coût
# Project summary to display on homepage.
summary: Estimer l'attitude à partir de capteurs inertiels MEMS à faible coût

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
  caption: "Cartes de capteurs IMU disponibles en 2019 : GY-91 (open source) ; IMU 10DoF v2, 9DoF et 6DoF (Drotek)"
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

L'objectif est de concevoir un algorithme de fusion de données pour estimer l'attitude d'un objet à partir de capteurs MEMS. Le prototypage rapide de commande (RCP) avec Simulink est mis en œuvre pour concevoir et valider expérimentalement l'algorithme embarqué sur un dsPIC.

## Capteurs

Trois types de capteurs MEMS, notés respectivement A, G et M, mesurent 3 grandeurs sur 3 axes :

- (A) Les accéléromètres mesurent le vecteur accélération $\vec{a}$
- (G) Les gyromètres mesurent la vitesse angulaire $\vec{G}$
- (M) Les magnétomètres mesurent le champ magnétique $\vec{m}$

Ces capteurs sont parfois réunis dans un seul boîtier. Des cartes offrent 6 (AG), 9 (AGM), voire 10 DoF[^DoF] avec un baromètre. 

Exemples de capteurs MEMS : MPU9250 - MPU6050 - MPU6000 - ICM20608

## Introduction aux algorithmes d'attitude

### Accéléromètres - Magnétomètres (AM)

L'algorithme **TRIAD** calcule l'attitude à partir des vecteurs $\vec{a}$ et $\vec{m}$ : 
La gravité $\vec{a}$ et le vecteur champ magnétique terrestre $\vec{m}$ sont mesurés dans le repère de l'objet. Leur produit vectoriel $\vec{k} = \vec{a} \times \vec{m}$ est orthogonal à  $\vec{g}$ et à $\vec{m}$. La base $(\vec{a},\vec{m},\vec{k})$ est orthonormalisée en remplaçant le vecteur $\vec{m}$ par $\vec{j} = \vec{a} \times \vec{k}$. La base  $(\vec{a},\vec{j},\vec{k})$ est orthonormée. Disposée en colonnes dans une matrice, la base $(\vec{a},\vec{j},\vec{k})$ est la matrice de rotation DCM[^DCM] qui définit l'attitude du repère de l'objet. La rotation inverse est la matrice DCM transposée.

L'algorithme TRIAD suppose que :

- l'objet n'est soumis à aucune accélération et
- l'objet n'est soumis à aucune perturbation magnétique.

La plupart des systèmes dynamiques sont soumis à des accélérations, ou évoluent en intérieur où le champ magnétique n'est pas fiable. Un autre capteur permet de lever ces hypothèses.

### Accéléromètres - Gyromètres - Magnétomètres (AGM)

L'estimation d'attitude reposant uniquement sur des accéléromètres et des magnétomètres est sujette à des erreurs : la mesure du vecteur gravité est affectée par l'accélération propre du système, et la mesure du vecteur champ magnétique terrestre est affectée par les variations locales du champ magnétique.

Un gyromètre MEMS mesure la vitesse angulaire sur 3 axes. La mesure du gyromètre n'est pas perturbée[^rate-gyro-perturbation]. Il est possible de suivre la variation de l'angle d'attitude en intégrant la vitesse angulaire. Cependant, un gyromètre n'est pas suffisant à lui seul, car :

- La valeur initiale de l'angle de l'intégrateur n'est pas définie
- L'intégrateur accumule tout biais du capteur, ce qui provoque une dérive de l'attitude

Les algorithmes AGM utilisent le capteur `rate gyro` pour suivre la dynamique rapide de l'attitude, et les capteurs `accelerometers` et `magnetometers` pour l'attitude initiale et la correction de la dérive inhérente à l'intégration de la vitesse angulaire.

Un algorithme de fusion de données d'IMU comporte, de manière générale, trois étapes :

1. Prédiction
2. Erreur
3. Correction

## Algorithmes AGM



Filtre complémentaire, adapté au cas 2D

Kalman, surdimensionné

quel que soit l'algorithme choisi, 3 étapes :


### Algorithmes



Rejet des perturbations du magnétomètre

AHRS: accelerometer + Gyrometre + magnetometre
MARG: accelerometer + gyro + mag
IMU: accelerometer + Gyrometer
IMU project Todo

Recorded Data Workflow
Recorded Sensor Data

[^DoF]: Degré de liberté (Degree of Freedom)
[^DCM]: Matrice de cosinus directeurs (Direct Cosine Matrix)
[^rate-gyro-perturbation]: Les mesures du gyromètre ne sont modifiées ni par le champ magnétique local ni par sa propre accélération, sauf en cas de chocs importants.
<!-- test code -->
