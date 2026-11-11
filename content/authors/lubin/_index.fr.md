---
title: Lubin Kerhuel
authors: lubin
superuser: true
role: Ingénieur, docteur
address: Lubin Kerhuel, 19 rue Adrien Barthe, 64100 Bayonne, FRANCE
organizations:
- name: Microchip Technology Inc
  url: https://www.microchip.com/
bio: Intérêt pour le traitement du signal et la théorie de la commande. Prototypage rapide de commande depuis 2005 ; chez Microchip depuis 2011.
email: lubin@kerhuel.eu
interests:
- Théorie de la commande et mathématiques appliquées
- Systèmes embarqués
- Natation
education:
  courses:
  - course: Doctorat en automatique, traitement du signal et robotique aérienne
    institution: Centre national de la recherche scientifique (CNRS) / Université Montpellier II
    year: 2009
  - course: Master de recherche - Traitement du signal et communications numériques
    institution: Université de Nice Sophia-Antipolis
    year: 2004
  - course: Ingénieur - Systèmes sur puce
    institution: ESIEE Paris
    year: 2004
social:
  - icon: envelope
    icon_pack: fas
    link: '/#contact'
  - icon: linkedin
    icon_pack: fab
    link: https://www.linkedin.com/in/kerhuel/
  - icon: google-scholar
    icon_pack: ai
    link: https://scholar.google.co.uk/citations?user=61SJU_sAAAAJ
highlight_name: false
summary: "Lubin Kerhuel : ingénieur et docteur, développeur des MPLAB Device Blocks pour Simulink chez Microchip Technology."
---

{{% callout warning %}}
Les contenus de ce site relèvent d'une initiative personnelle et n'engagent pas les positions, stratégies ou opinions de Microchip.
{{% /callout %}}

Les systèmes embarqués exigent des compétences en programmation et un effort de mise en œuvre important. L'algorithme de commande est en général implémenté en dernier, sous la forme d'une boucle PI. Pourtant, la théorie de la commande offre de nombreuses solutions pour améliorer la dynamique des systèmes, rejeter les perturbations et accroître la robustesse face aux erreurs de modèle.

Par intérêt pour les mathématiques appliquées, un blockset pour Matlab/Simulink destiné aux microcontrôleurs dsPIC a été développé en 2005. Il permet de se concentrer sur la partie commande grâce à la simulation Simulink plutôt que sur les difficultés de mise en œuvre. Le prototypage rapide de commande (RCP, Rapid Control Prototyping) devient alors possible sur toute carte équipée d'un dsPIC. Il s'exécute sur des cartes de démonstration à faible coût ou sur des cartes spécifiques, sans le budget que requièrent des outils haut de gamme tels que dSPACE, SpeedGoat ou National Instruments.

$$
\text{Un seul bouton}
\left\\{ \begin{array}{l}
\text{- Générer le code C} \\\\\\
\text{- Compiler} \\\\\\
\text{- Téléverser et exécuter sur la cible} 
\end{array} \right.
$$ 

Cette boîte à outils dsPIC a été mise en œuvre dans la [thèse de doctorat](https://archive.kerhuel.eu/legacy/publi/Kerhuel_2009_PhD.pdf) en robotique biologique, de 2006 à 2009.
Elle a facilité le passage de la simulation du traitement du signal visuel à la commande de notre [robot aérien](https://www.researchgate.net/profile/Nicolas-Franceschini/publication/261957721/figure/fig11/AS:613971820285953@1523393697097/a-OSCAR-II-like-its-predecessor-OSCAR-I-is-a-tethered-aerial-robot-that-orients-its_W640.jpg), et s'est substituée à la plateforme dSPACE d'origine de notre laboratoire.

La même approche a ensuite été employée pour développer des algorithmes de fusion de données pour l'analyse du mouvement dans les équipements sportifs portables, chez [MOVEA](https://www.cea-tech.fr/cea-tech/english/Pages/success-stories/movea.aspx) en 2010-2011.

L'entrée chez [Microchip Technology](https://www.microchip.com/) en 2011 a permis de poursuivre le développement du [blockset MPLAB](https://www.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink). La boîte à outils ciblait initialement les dsPIC et a ensuite été étendue à :
- dsPIC33A
- PIC32 (cœur MIPS)
- SAMx2 (ARM Cortex M0+)
- SAMx5 (ARM Cortex M4)
- SAMx7 (ARM Cortex M7)

Nous avons développé un ordonnanceur multitâche à priorités fixes (rate-monotonic), pleinement intégré à l'environnement MathWorks, avec la prise en charge du PIL (Processor In the Loop) et du mode External Mode.

La boîte à outils prend désormais en charge jusqu'à 650 microcontrôleurs. Le développement et le support ont été dissociés en 2022. Les efforts portent désormais sur les nouveaux développements et le support des dsPIC.

Pour les entreprises, les scientifiques et les étudiants, *le prototypage rapide permet de se concentrer sur les idées*, plutôt que de s'attarder sur les détails de la programmation embarquée.
Raccourcir la boucle $\text{Simulation} \Leftrightarrow \text{Matériel}$ permet de :
- affiner et valider un modèle grâce à des essais précoces
- développer la commande à partir du jumeau numérique du système
- mettre en œuvre la commande finale
- tirer parti du large éventail d'outils MathWorks disponibles

Les projets électroniques de ce site utilisent le [blockset Microchip](https://www.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink). Les projets plus anciens sont disponibles sur mon [ancien site](https://archive.kerhuel.eu/wiki/).
