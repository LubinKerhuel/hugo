---
title: 'Signal de démarrage/arrêt pour la caméra d''action RunCam2'
subtitle: 'Signal sur le connecteur USB de la RunCam2 pour démarrer/arrêter l''enregistrement'
summary: Signal pour démarrer / arrêter l'enregistrement ou prendre une photo à distance sur une RunCam2 et les caméras d'action compatibles, via le connecteur USB.
authors:
- Lubin
tags: ["camera"]
categories: ["sensor"]
date: "2019-05-18"
#lastmod: "2019-04-12T00:00:00Z"
featured: false
draft: false

sitemap:
  priority: 1

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: 'En haut : caméra d''action RunCam 2 avec un câble personnalisé à 3 fils qui alimente la caméra et déclenche les enregistrements. En bas : câble du commerce dont l''électronique convertit la sortie PWM RC en séquence d''impulsions de commande de la runCam2.'
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: [autopilot-plane]

---
<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

Il existe des câbles pour relier une caméra d'action RunCam2 à un récepteur RC afin de démarrer et d'arrêter l'enregistrement à distance à partir de la sortie PWM du récepteur (période de 20 ms, rapport cyclique de 1 ms à 2 ms).
Le câble contient une logique qui décode le signal PWM RC et génère la séquence d'impulsions qui démarre et arrête l'enregistrement de la RunCam2.

Il est également possible de commander la caméra avec un microcontrôleur, en générant la séquence d'impulsions requise décrite ci-dessous.

Le brochage du câble micro USB est le suivant :

 - Broche 1 (VCC) : +5 V (une tension plus élevée est possible sur le connecteur de la RunCam2)
 - Broche 3 (D+) : signal TTL (5 V)
 - Broche 5 (GND) : GND

Lorsqu'on règle le port USB de la caméra sur « Remote Control » (et non « mass storage ») avec l'application de configuration, il est possible de faire basculer la caméra du mode vidéo au mode photo et inversement, de démarrer ou d'arrêter l'enregistrement, ou de prendre une photo.

La séquence d'impulsions est la suivante :

- Une impulsion fait passer la caméra du mode enregistrement vidéo au mode photo.
- Deux impulsions séparées de 85 ms démarrent ou arrêtent un enregistrement vidéo (ou prennent une photo en mode photo).

Le niveau des impulsions est de 5 V, mais le dispositif fonctionne également avec 3,3 V. La ligne est à l'état bas au repos. Les impulsions durent 85 ms à l'état haut et sont séparées de 85 ms lorsque plusieurs impulsions sont émises.

Dispositif évalué avec une runCam2 alimentée par une batterie LiPo 3S (10 à 14 V), sans batterie dans la caméra, et avec des impulsions générées par une broche de dsPIC configurée en sortie numérique 3,3 V.

La figure ci-dessous est le diagramme Simulink contenant la logique utilisée pour générer les impulsions souhaitées sur un dsPIC. Le code est généré avec Simulink Coder et le [bloc MPLAB](https://www.microchip.com/DevelopmentTools/ProductDetails/PartNO/SW007023) de Microchip.

{{< figure
src="/img/runcam2-startstop-simulink-logic.png"
link="/img/runcam2-startstop-simulink-logic.png"
width="100%"
caption="Logique Simulink pour commander une caméra d'action runCam2. Le pas de temps du sous-système est de 1 ms. L'intégrateur est remis à zéro à chaque changement d'état de l'entrée du sous-système, ce qui déclenche la génération d'une séquence de deux impulsions de 85 ms. La remise à zéro de l'intégrateur est verrouillée pendant la génération des impulsions. La logique en sortie de l'intégrateur génère les impulsions. Le code généré a été évalué sur une cible dsPIC"
numbered="true"
>}}

