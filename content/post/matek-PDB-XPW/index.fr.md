---
title: 'Modification du module double BEC et mesure de courant MATEKSYS PDB-XPW pour augmenter la sensibilité de la mesure de courant'
subtitle: 'Réduction de la plage de mesure de courant de 140 A à 20 A'
summary: Adapter le module d'alimentation MATEKSYS PDB-XPW, conçu pour les quadricoptères, à un avion RC électrique aux besoins en courant plus faibles. La plage de mesure du courant est modifiée par le remplacement d'une seule résistance du circuit de mesure à amplificateur opérationnel.
authors:
- Lubin
tags: ["electronics","power","PDB-XPW"]
categories: ["electronics"]
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
  caption: Module double BEC et mesure de courant PDB-XPW. Image de MATEK Systems.
  focal_point: TopRight
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: ["autopilot-plane"]

math: true

# add comment through github: required files github-comments.js (static/js) and comments.html (partial)
# provide a github repository with comment enabled:
# each page is assigned to a comment id. see github from dwilliamson/donw.io
# ghcommentrepo: dwilliamson/donw.io
# ghcommentid: 1
---

<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

La carte [PDB-XPW](https://www.mateksys.com/?portfolio=pdb-xpw) de MATEK System est un régulateur de tension équipé d'une mesure de courant adaptée aux courants des quadricoptères, avec une mesure maximale de 140 ampères. Pour un projet d'avion RC, il est possible de réduire la plage de mesure du courant afin d'augmenter la résolution de la mesure.

Le circuit « INA1x9 High-Side Measurement Current Shunt Monitor » de Texas Instrument conditionne et amplifie la chute de tension aux bornes de la résistance de shunt, et fournit une sortie analogique proportionnelle au courant.

Sur la carte PDB-XPW, le circuit INA1x9 est le composant noir à 5 broches marqué E39, situé sous la résistance de shunt de 0,05 ohm, elle-même placée immédiatement sous le connecteur d'entrée d'alimentation.

Le gain d'amplification est fixé par la résistance de 47 kOhm adjacente au composant INA1x9. Cette valeur d'origine de 47 kOhm correspond à un gain de 47.
Le gain correspond à la valeur exprimée en kOhm, comme l'indique la documentation du circuit :

|Résistance|Gain|
|:---:|:---:|
|1 kOhm | 1 |
|5 Kohm | 5 |
|10 Kohm | 10 |
|50 Kohm | 50 |
|100 Kohm | 100 |

La résistance de 47 kOhm est remplacée par une résistance de 270 kOhm, ce qui conduit à un gain de 270 au lieu de 47. 
La plage de mesure de courant d'origine passe ainsi de 140 A à 20 A (140 * 47/270 = 20).

La sortie de mesure du courant est un signal analogique variant de 0 à 3,3 V, codant linéairement le courant sur la plage [0 - 20] ampères. Cette plage de courant plus faible est adaptée aux avions RC tels que le Bixler 2, le Firstar 1600 ou le Ranger 1600.

