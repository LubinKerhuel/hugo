+++
# Project title.
title = "Pilote automatique d'avion à voilure fixe basé sur un modèle Simulink"

# Date this page was created.
date = 2019-05-19T00:00:00
draft = false

# Project summary to display on homepage.
summary = "Pilote automatique 16 bits pour avion à voilure fixe, développé par conception basée sur modèle (Model Based Design)"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["simulink","matlab","rapid prototyping","model based design (MBD)","dsPIC","sliding-mode","autopilot","UAV","MAVLink","UxV blockset","AUAV V3 board"]

# Optional external URL for project (replaces project detail page).
external_link = ""


# share = false  # Show social sharing links?
profile = true  # Show author profile?
# comments = false  # Show comments?

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references 
#   `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides = ""

# Links (optional).
# url_pdf = ""
# url_code = ""
# url_dataset = ""
# url_slides = ""
# url_video = ""
# url_poster = ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
#links = [{icon_pack = "fab", icon="twitter", name="Follow", url = "https://twitter.com/georgecushen"}]
links = [
{icon_pack = "fab", icon="", name="Vidéos conditions calmes", url = "https://www.youtube.com/playlist?list=PLaljXZFYAWTM5xUd5nM3107M2cDsQRFC0"},
{icon_pack = "fab", icon="", name="Vidéos conditions turbulentes", url = "https://www.youtube.com/playlist?list=PLaljXZFYAWTPAKykfQDyIEClrdDMl0NDy"}
]

# Featured image
# To use, add an image named `featured.jpg/png` to your project's folder. 
[image]
  # Caption (optional)
  caption = "Avion Firstar 1600"
  
  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = "Smart"
+++

<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

## Un pilote automatique 16 bits conçu avec Simulink et des outils de prototypage rapide de commande ##

### Motivation ###

Il est désormais aisé de construire une plateforme destinée à évaluer différentes boucles de commande de pilote automatique, grâce aux nombreux composants à faible coût disponibles. En voici quelques-uns :

- **Centrale inertielle (IMU) 10 DoF** : (~$5\ \$$),
- **Carte GPS** : (~$10\ \$$),
- **Tube de Pitot** ([sur mesure](/post/pitot-build/)) : (~$20\ \$$),
- **Carte microcontrôleur** : dépend de la carte ; repose sur un microcontrôleur à $\approx 5\ \$$,
- Plateforme **avion** : de $60$ à $120\ \$$ servos et moteurs inclus. 
- Quelques éléments de radiocommande sont également nécessaires : 
  - **récepteur**
  - **télécommande**
  - **batterie**
-  quelques éléments optionnels pour l'**enregistrement de données**, la **télémétrie**, la **caméra**...

### Différences avec les pilotes automatiques existants ###

De nombreux pilotes automatiques prêts à l'emploi existent et donnent de bons résultats. En voici quelques-uns :

- [Ardupilot](https://ardupilot.org/)
- [PX4](https://px4.io/)
- [iNav](https://inavflight.com/)
- [LibrePilot](https://www.librepilot.org/site/index.html)
- [Paparazzi](https://wiki.paparazziuav.org/wiki/Main_Page).
- D'autres sont listés dans le [comparatif de DroneTrest](https://blog.dronetrest.com/flight-controller-firmware/)).

De manière générale, leurs paramètres internes peuvent être réglés. Cependant, l'insertion d'une boucle de commande personnalisée dans un tel pilote automatique suppose de comprendre la structure du code sous-jacent. Même bien documenté, celui-ci comporte des centaines de fonctions C à examiner avant de pouvoir entreprendre la moindre modification.
Une boucle de commande personnalisée peut ne pas s'intégrer dans la structure existante. Il peut être souhaitable de mettre en œuvre un correcteur plus avancé que les PID existants, utiliser une autre fréquence d'échantillonnage, etc.

Il est parfois plus rapide de démarrer un nouveau projet que de réutiliser un projet avancé préexistant.
Le pilote automatique présenté utilise une approche de conception basée sur modèle (Model Based Design, MBD) : le code du pilote automatique est généré à partir d'un unique modèle Simulink. Tout se trouve dans le diagramme, de la gestion bas niveau des capteurs jusqu'à la synthèse du correcteur. Cette approche MBD est également appelée prototypage rapide de commande (Rapid Control Prototyping, RCP).

La boucle de commande du pilote automatique utilise des blocs mathématiques standard. La couche bas niveau est assurée par le blockset Microchip, qui gère les périphériques du microcontrôleur. Le blockset UxV donne un accès simple au GPS, à la radiocommande (S.BUS), aux protocoles F.Port et Smart Port, ainsi qu'à la messagerie MAVLink, y compris les protocoles de points de passage (Way Point) et de paramètres.
Un tel modèle Simulink permet d'« entrer » dans le projet de manière graphique. Il permet de simuler des parties du système à partir d'un avion simulé ou à partir de valeurs préalablement enregistrées lors d'un vol réel, ce qui est utile pour concevoir des algorithmes de fusion de capteurs avec anticipation (feed-forward).

Une autre différence essentielle est l'utilisation d'un microcontrôleur 16 bits, alors que les autres pilotes automatiques utilisent des microcontrôleurs 32 bits. Les dsPIC 16 bits disposent de toutes les ressources nécessaires grâce à leur architecture efficace, qui gère aisément les nombreux périphériques utilisés (UART, I2C, Output Compare, Input Capture...).

Signalons toutefois qu'une démarche de conception basée sur modèle similaire, utilisant un microcontrôleur dsPIC, a été développée à l'UCSC par le Pr G.H. Elkaim dans un projet nommé SLUG. Leur conception est indépendante de celle présentée ici. Le projet original mené par M.I. Lizarraga [SLUG] (https://slugsuav.soe.ucsc.edu/) est disponible en ligne. La version [SLUG II](https://doi.org/10.1155/2018/6892153) s'appuie sur le même outil que celui utilisé ici pour cibler le dsPIC : le blockset pour microcontrôleurs Microchip (gratuit).

### Liste du matériel ###

Plusieurs configurations matérielles ont été évaluées. Voici une sélection de composants ayant donné des résultats satisfaisants.

{{< figure 
src="/img/firstar1600-qx7.jpg"
link="/img/firstar1600-qx7.jpg"
width="80%"
title="plateforme du pilote automatique"
caption="Volantex Firstar 1600 avec la télécommande Qx7."
numbered="true"
>}}

- **Avion radiocommandé** : Volantex Firstar 1600 avec moteurs et servos d'origine (Bixler 2 et Ranger 1600 sont des plateformes alternatives)
- **Télécommande** : FrSky QX7
- **Récepteur** : FrSky XSR-M / XSR utilisé soit avec le protocole S.Bus (sortie des voies du récepteur) et Smart Port (télémétrie), soit avec le protocole F.Port qui combine S.Bus et Smart Port et économise un périphérique UART du microcontrôleur. Chaque protocole n'utilise qu'un seul fil, par conséquent une liaison UART en half-duplex. Le module UART du dsPIC permet de regrouper Tx et Rx sur une seule broche.  
- **Microcontrôleur** : dsPIC 33EP sur une carte AUAV V3. Un capteur de mouvement externe est utilisé à la place des capteurs intégrés à l'AUAV3. Une petite carte capteur équipée d'un circuit récent se fixe plus facilement et rigidement près du centre de gravité (CG), ce qui réduit les vibrations. Une carte sur mesure basée sur un dsPIC pourrait remplacer la carte AUAV3, devenue difficile à se procurer. L'UDB5 mini est similaire et reste disponible.
- **Capteur IMU** : Gy-91 (10 DoF avec 3 accéléromètres, 3 gyromètres, 3 magnétomètres et un baromètre). Fixé rigidement près du CG de l'avion. Un bus I2C relie les capteurs au microcontrôleur.
- **Tube de Pitot** : 
  - Un tube intérieur et un tube extérieur sur lequel quatre trous sont percés latéralement.
  - Conditionnement du signal : le capteur de pression du tube de Pitot (MP3V 5004 DP) est lu par un convertisseur ADC MCHP qui intègre un amplificateur analogique. La pression convertie est envoyée au microcontrôleur par le bus I2C. Voir la page [construction et test](/post/pitot-build/).
- **GPS** : basé sur un module $\mu$blox M8N offrant jusqu'à 10 Hz de rafraîchissement, avec des résultats satisfaisants par rapport aux autres modules du marché.
- **Enregistreur de données** : carte OpenLager pour l'enregistrement sur carte SD. Elle permet d'enregistrer en continu le flux de sortie d'une UART à une vitesse allant jusqu'à 2 470 000 bauds (bien supérieure aux 115 200 bauds que l'enregistreur OpenLog ne peut pas suivre). 
- **Liaison radio** : module radio de type 3DR Sik pour la télémétrie MAVLink (attitude de l'avion, position, points de passage et réglage des paramètres) avec la station sol [qgroundcontrol](https://qgroundcontrol.com/) qui fonctionne sur la plupart des plateformes (PC, Android, Windows, Linux).
- **Caméra d'action** : RunCam2 pour filmer l'avion et ses gouvernes depuis le dessus ; on observe ainsi le comportement du pilote automatique en fonctionnement.

{{< figure 
src="/img/autopilot-electronic-sensors-bundle_1.jpg"
link="/img/autopilot-electronic-sensors-bundle_1.jpg"
width="80%"
title="Électronique embarquée. Une des premières configurations destinées à évaluer divers capteurs. Éléments utilisés : récepteur X8R, carte de distribution PDB-XPM, enregistreur de données sur SD OpenLager, microcontrôleur dsPIC 16 bits AUAV3 avec capteurs (MPU6050), carte IMU 1, carte IMU 2, capteur de pression MP3V5004DP pour le tube de Pitot, GPS1, GPS2, batterie LiPo 3S 2200 mAh, émetteur Qx7."
numbered="true"
>}}


### Résultats ###

Un correcteur par modes glissants a été évalué sur les axes de tangage et de roulis, selon deux modes :

- Commande de la vitesse angulaire de l'avion (consigne de vitesse angulaire donnée par la télécommande)
- Commande de l'angle d'attitude de l'avion (consigne d'angle donnée par la télécommande)

La charge moyenne du processeur était de 7 à 8 % sur un dsPIC 33EP cadencé à 70 MIPS. Elle inclut l'algorithme d'estimation de l'IMU, la boucle de commande du pilote automatique et toutes les tâches de bas niveau (gestion de divers protocoles (I2C, NMEA pour le GPS, F.Port, MAVLink) et enregistrement des données capteurs à 1 kHz via une UART configurée à 2 470 000)

Le dispositif a été éprouvé par vent fort. Il met en évidence une robustesse satisfaisante malgré le faible nombre de paramètres réglés jusqu'ici (lien vidéo en haut de page).

L'estimation de la vitesse air par le tube de Pitot a été validée en prenant la vitesse GPS comme référence ([ici](/post/pitot-build/)).

L'estimation de la vitesse et de la direction du vent, basée sur la différence entre les mesures de vitesse GPS et du tube de Pitot en tenant compte de l'orientation de l'avion, a été validée.

L'étalonnage automatique du décalage et du gain des axes du magnétomètre a été validé. Une fois en vol, les perturbations magnétiques près du sol sont négligeables. Un algorithme détermine automatiquement si l'étalonnage peut être affiné avec les données courantes (à partir de données de vol standard, sans looping ni tonneau).



### Prochaines étapes ###

Réduire le broutement (chattering) sur les ailerons lorsque la commande par modes glissants est activée.

Valider en vol le réglage des paramètres via le protocole MAVLink.

Mettre en œuvre le guidage automatique de l'avion, à l'aide de points de cheminement (waypoints) MAVLink.


### Contenu du site ###

Faute de temps, il n'est pas possible de rédiger une description complète du projet comme initialement prévu. Les parties les plus pertinentes seront publiées.

Idées à développer :

- IMU
- [Tube de Pitot](/post/pitot-build/)
- [Estimation du vent](/post/pitot-build/#wind-estimation) combinant la vitesse sol GPS et la vitesse air du tube de Pitot
- Blocs UxV, dont les blocs et fonctionnalités GPS, radiocommande et MAVLink
- Étalonnage automatique des magnétomètres
