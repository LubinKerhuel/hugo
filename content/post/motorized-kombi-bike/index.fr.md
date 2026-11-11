---
title: 'Vélo Kombi électrique'
subtitle: 'Yuba long-tail KOMBI assisté par un moteur TSDZ2 et un firmware de vélo électrique open source'
summary: Vélo cargo long-tail Yuba KOMBI équipé d'un moteur Tongsheng TSDZ2. Mise à jour du TSDZ2 avec un firmware de vélo électrique open source. Repose-pieds du Kombi modifiés pour tracter un autre vélo.
authors:
- Lubin
tags: ["bike"]
categories: ["DIY"]
date: "2020-01-16"
#lastmod: "2019-04-12T00:00:00Z"
featured: false
draft: false

sitemap:
  priority: 0.25

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: Yuba Kombi long-tail équipé du moteur Tongsheng TSDZ2
  focal_point: TopLeft
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []

math: false

# add comment through github: required files github-comments.js (static/js) and comments.html (partial)
# provide a github repository with comment enabled:
# each page is assigned to a comment id. see github from dwilliamson/donw.io
# ghcommentrepo: dwilliamson/donw.io
# ghcommentid: 1

---

<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

Un vélo KOMBI motorisé par le moteur à entraînement central TSDZ2.
Le firmware du moteur est remplacé par le [firmware open source flexible TSDZ2](https://github.com/OpenSource-EBike-firmware/TSDZ2_wiki/wiki) initié par Casainho.

En utilisation typique, le vélo roule à vide ou chargé de deux enfants (trois en de rares occasions). Il a parcouru 2300 km à ce jour avec la chaîne d'origine du vélo, ainsi que le pignon bleu et l'embrayage d'origine du moteur.

Le premier vélo, bleu (photos ci-dessous), utilise un moteur 36 V avec une batterie 36 V (la tension de la batterie varie de 33 V à 42,4 V). Un second vélo a été réalisé avec le moteur TSDZ2 48 V et une batterie 48 V (variation de 40 V à 52 V).
La version 48 V est plus confortable que la version 36 V. Avec la version 36 V, la variation de tension de la batterie ne permet pas d'exploiter pleinement le potentiel du moteur une fois la batterie à moitié déchargée. Ce phénomène n'est pas observé avec le moteur 48 V.


Difficultés rencontrées :
  - 2300 km : bruit provenant du roulement du pédalier.
    Le pédalier semble insuffisamment serré. Le bruit apparaît par temps chaud (>15°C). Défaut non encore corrigé ; toutefois, le vélo fonctionne correctement (c'est l'hiver).


{{< figure 
src="/img/yuba-kombi-tsdz2-pedal-removal-01.jpg"
link="/img/yuba-kombi-tsdz2-pedal-removal-01.jpg"
width="80%"
title="Installation du moteur (1/3)"
caption="Pédales d'origine"
numbered="false"
>}}

{{< figure 
src="/img/yuba-kombi-tsdz2-pedal-removal-02.jpg"
link="/img/yuba-kombi-tsdz2-pedal-removal-02.jpg"
width="80%"
title="Installation du moteur (2/3)"
caption="Accès au boîtier de pédalier BSA 68"
numbered="false"
>}}

{{< figure 
src="/img/yuba-kombi-tsdz2-pedal-removal-03.jpg"
link="/img/yuba-kombi-tsdz2-pedal-removal-03.jpg"
width="80%"
title="Installation du moteur (3/3)"
caption="Boîtier de pédalier BSA 68"
numbered="false"
>}}

{{< figure 
src="/img/yuba-kombi-tsdz2-motor-installation.jpg"
link="/img/yuba-kombi-tsdz2-motor-installation.jpg"
width="80%"
title="Moteur TSDZ2 installé"
caption="Le TSDZ2 appuyé contre le tube avant, protégé par une chambre à air"
numbered="false"
>}}

{{< figure 
src="/img/yuba-kombi-tsdz2-battery-installation.jpg"
link="/img/yuba-kombi-tsdz2-battery-installation.jpg"
width="80%"
title="Vélo Yuba KOMBI équipé du moteur TSDZ2 et de la batterie"
caption="Batterie installée verticalement derrière la selle"
numbered="false"
>}}

{{< figure 
src="/img/yuba-kombi-tsdz2-tracting-bike-01.jpg"
link="/img/yuba-kombi-tsdz2-tracting-bike-01.jpg"
width="80%"
title="Vélo Yuba KOMBI tractant un vélo"
caption="Dispositif permettant de tracter un vélo BMX de course mini (personne sur le BMX). Le vélo tracté est libre de pivoter autour de l'axe de direction et verticalement (haut-bas), et suit sans à-coups le vélo tracteur."
numbered="false"
>}}

{{< figure 
src="/img/yuba-kombi-tsdz2-tracting-bike-02.jpg"
link="/img/yuba-kombi-tsdz2-tracting-bike-02.jpg"
width="80%"
title="Système de fixation pour tracter un autre vélo"
caption="La roue avant du vélo tracté est engagée dans une barrière du repose-pieds. Une sangle fixe rigidement la roue avant au vélo tracteur, ce qui laisse deux degrés de liberté au cadre du vélo tracté. Une seconde sangle aide à maintenir le vélo dans le même plan vertical. On observe le faible angle de la barrière du repose-pieds, qui ménage l'espace nécessaire aux pieds des enfants sur le vélo tracteur."
numbered="false"
>}}

{{< figure 
src="/img/yuba-kombi-tsdz2-on-car.jpg"
link="/img/yuba-kombi-tsdz2-on-car.jpg"
width="80%"
title="Vélo KOMBI sur un porte-vélos de voiture"
caption="Vélo Yuba KOMBI fixé avec deux autres vélos sur le porte-vélos de la voiture."
numbered="false"
>}}


### Divers 

https://em3ev.com/

- Batterie 36 V : 3,385 kg
- Batterie 42 V : 3,965 kg
