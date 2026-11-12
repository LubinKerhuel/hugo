---
# Course title, summary, and position.
linktitle: Boîte à outils UxV pour Matlab-Simulink
title: Boîte à outils UxV
summary: La boîte à outils UxV fournit des scripts matlab et des blocs Simulink pour le pilote automatique. Des scripts décodent et visualisent les journaux MAVlink et configurent un modèle Simulink alimenté par des signaux MAVlink pour la simulation. Les blocs ajoutent MAVLink, le GPS et les protocoles FrSky S.BUS, Smart Port et F.Port à un modèle de prototypage rapide utilisé pour la génération de code avec les blocs MPLAB de Microchip (ciblant les microcontrôleurs dsPIC). 
weight: 1

tags:
    - rapid prototyping
    - model-based design (MBD)
    - matlab
    - simulink
    - UAV
    - UxV
    - MAVLink
    - GPS
    - FrSky
    - S.BUS
    - Smart Port
    - F.Port

# Page metadata.

date: 2019-07-01
# lastmod: "2019-07-01"
draft: false  # Is this a draft? true/false
toc: true  # Show table of contents? true/false
type: docs  # Do not modify.

# Add menu entry to sidebar.
# - name: Declare this menu item as a parent with ID `name`.
# - weight: Position of link in menu.

sitemap:
    priority: 1

menu:
  uxv:
    name: UxV toolbox
    identifier: uxv-toolbox
    weight: 1
---

## Vue d'ensemble

La boîte à outils UxV pour Matlab/Simulink fournit des scripts Matlab et des blocs Simulink pour les drones (UAV) pour traiter le protocole MAVLink, le GPS, les récepteurs RC et les protocoles de télémétrie.

- Scripts Matlab pour l'analyse des données après vol (MAVLink).
- Blocs Simulink pour concevoir un pilote automatique à partir d'un modèle (prototypage rapide des commandes avec Simulink).

Ces outils de conception et d'analyse fondés sur un modèle accélèrent les allers-retours entre les essais expérimentaux et la simulation.

## Scripts Matlab pour MAVLink

Trois scripts principaux permettent de décoder les messages MAVLink, de créer un modèle Simulink de simulation à partir des données enregistrées, et de générer la trace de la trajectoire sur une carte à partir des messages GPS.

| Script           | Entrée | Sortie | Fonction                              |
|------------------|-------|--------|---------------------------------------|
| (1) *mavlink2mat*      | Journal Mavlink | .mat | analyse dans Matlab   |
| (2) *mavlink2simulink* | Journal Mavlink | .mat / .mdl (.slx)  | simulation à partir de données réelles |
| (3) *mavlink2kml*      | Journal Mavlink | .kml | tracé de la ou des traces GPS sur une carte |
| *mavlink2gui*      | Journal Mavlink | GUI | exploration graphique d'un journal MAVLink |


Le script *mavlinkgui* ouvre une interface graphique (GUI) pour explorer les données MAVLink. Il liste les messages MAVLink présents dans un fichier journal et trace les {message - valeur} sélectionnés. Le script de tracé est personnalisable : l'utilisateur peut ainsi aller au-delà d'un simple tracé. L'interface donne accès aux trois scripts mentionnés ci-dessus.


## Blocs Simulink

10 blocs ajoutés apportent les fonctions essentielles d'un UAV pour mettre en œuvre un pilote automatique sur un DSC dsPIC. Ces blocs complètent les blocs MPLAB pour Simulink de Microchip, qui fournissent les blocs de périphériques pour la génération de code. Ils s'appuient sur MathWorks Embedded Coder. Les fonctions ajoutées sont les suivantes :

- GPS
  - *GPS Parser* pour décoder les messages NMEA
- MATH
  - *Quaternion to Cardan FxPt* pour convertir un quaternion en angles de Cardan en virgule fixe (similaires aux angles d'Euler)
- MAVLink :
  - *SEND* (envoyer un message)
  - *RECEIVE* (recevoir un message)
  - *MAVLink Data*  (données de points de passage)
  - *MAVLink Parser* (décode le message d'entrée et met en œuvre les protocoles WayPoint[^WayPoint] et Parameter[^Parameter])
- [Récepteurs-Télémétrie](block-receiver-telemetry/)
  - *S.BUS* reçoit les canaux RC
  - *Smart Port* envoie les valeurs de télémétrie
  - *F.Port* reçoit les canaux RC + envoie la télémétrie
  - *Sensor for Smart.Port or F.Port* définit les valeurs à envoyer par télémétrie[^Telemetry]

À l'exception du bloc MATH, ces blocs se connectent généralement aux blocs UART Rx/Tx du dsPIC pour envoyer ou recevoir le flux de données d'un GPS, d'un récepteur ou d'une liaison radio.

## Installation

Ces blocs sont développés par Lubin Kerhuel et diffusés gratuitement avec les [MPLAB device blocks for Simulink](https://www.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink) de Microchip.

1. Installer les MPLAB Device Blocks de Microchip
2. Saisir *pinInfo*, puis cliquer sur *go to Third Part Tools folder*
3. Exécuter le script *UxV_Blockset_Installer.p* dans le dossier UxV_blockset.


[^WayPoint]: Le *protocole Way Point* sert à définir et à lire des points de passage (WayPoint) depuis une station au sol compatible MAVLink.

[^Parameter]: Le *protocole Parameter* règle, depuis n'importe quelle station au sol MAVLink, les paramètres ajustables de Simulink, habituellement modifiés avec l'External Mode ou lors d'une simulation Processor In the Loop (PIL).

[^Telemetry]: Le bloc *Sensor for Smart.Port or F.Port* s'utilise avec le bloc *Smart Port* ou le bloc *F.Port*. Ces protocoles renvoient des paquets de télémétrie vers l'interface de la radiocommande (RC). Il est ainsi possible d'émuler aisément des capteurs Frsky (tension et courant de batterie, variomètre, vitesse air, GPS) et d'ajouter des fonctions à la radiocommande. Il est également possible d'émuler la télémétrie BetaFlight. Utilisés avec un script LUA, ils ajoutent des fonctions telles que l'horizon artificiel, la vitesse air, la vitesse verticale, la distance au point de départ et d'autres fonctions (évalué avec les [scripts LUA yaapu](https://github.com/yaapu/FrskyTelemetryScript/wiki)).
