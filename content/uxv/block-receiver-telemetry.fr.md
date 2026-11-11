---
linktitle: bloc récepteur & télémétrie
title: "bloc récepteur & télémétrie : S.BUS, Smart Port, F.Port"
summary: Blocs Simulink pour acquérir les données d'un récepteur et définir les données à envoyer à la radiocommande par le canal de télémétrie. Les blocs S.BUS, Smart Port et F.Port prennent en charge les protocoles respectifs. 
weight: 10

tags:
    - rapid prototyping
    - model based design (MBD)
    - matlab
    - simulink
    - UAV
    - UxV
    - receiver-telemetry
    - S.BUS
    - F.Port
    - Smart Port
    - block


#aliases = ["project/inverted_pendulum_flywheels/"]

draft: false  # Is this a draft? true/false
toc: true  # Show table of contents? true/false
type: docs  # Do not modify.

#date = 2018-09-09T00:00:00
#lastmod = 2018-09-09T00:00:00

# math: true

# date = 2018-09-09T00:00:00
# lastmod = 2018-09-09T00:00:00

# GitRepo = "hugo"

sitemap:
    priority: 1

# Add menu entry to sidebar.
# parent = "inverted_pendulum_flywheels"
menu:
    uxv:
        parent: blocks
        name: receiver-telemetry
        identifier: receiver-telemetry
        weight: 20
         

---
<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

Trois blocs ajoutent la prise en charge de trois protocoles présents sur les récepteurs. Un récepteur traditionnel à sortie PWM se traite directement avec le périphérique Input Capture ou Change Notification : il n'exige pas de bloc spécifique.

## S.BUS, Smart Port et F.Port

S.BUS, Smart Port (également appelé S.Port) et F.Port sont trois protocoles disponibles sur les récepteurs RC FrSky et compatibles. Les trois protocoles reposent sur le périphérique UART avec des réglages différents. Chacun remplit un rôle propre :

- **S.BUS** est un protocole unidirectionnel du récepteur vers un équipement externe, qui fournit les valeurs des canaux et le RSSI[^RSSI] (c.-à-d. la qualité de la liaison radio).
- **Smart Port (S.Port)** est un protocole bidirectionnel. Le récepteur interroge (ping) les différents capteurs connectés et acquiert les mesures à envoyer par télémétrie à la radiocommande.
- **F.Port** est un protocole bidirectionnel dans lequel le récepteur communique les valeurs des canaux et le RSSI, et obtient les valeurs des capteurs connectés pour les envoyer par télémétrie à la radiocommande.

Les deux protocoles bidirectionnels *Smart Port* et *F.Port* utilisent un seul fil pour Tx et Rx. La communication s'effectue en mode half duplex (semi-duplex).

Les récepteurs FrSky existent en deux variantes (modèles livrés avec le Smart Port : x4r, rx4r, x6r, s6r, rx6r, x8r, s8r, xsr, xsr-m, r-xsr ...) :

1. **S.Bus & Smart Port** (d'origine), disponibles sur deux ports à trois broches distincts
2. **F.Port** disponible sur un unique port à trois broches, qui remplace le Smart Port

Un récepteur d'origine possède deux ports : S.BUS et Smart Port. Le passage à un F.Port unique s'effectue en installant un micrologiciel alternatif fourni par [FrSky](https://www.frsky-rc.com/). Ce micrologiciel supprime le port S.BUS et convertit le Smart Port en F.Port.

### Réglages UART et mise en œuvre

S.BUS, S.Port et F.Port ont des réglages UART différents, définis dans le tableau :

|            | Débit (baud) |  Duplex |     Logique     | Parité | Bits de stop | Contrôle de flux |
|------------|:--------:|:-------:|:-------------:|:------:|:--------:|:---------:|
| S.BUS      |  100000  | Rx seul | 3,3V inversée |  paire  |     2    |     non    |
| Smart Port |   57600  | **Half**| 3,3V inversée |   aucune   |     1    |     non    |
| F.Port     |  115200  | **Half**| 3,3V inversée |   aucune   |     1    |     non    |

La mise en œuvre sur dsPIC avec le bloc MPLAB pour Simulink a donné des résultats satisfaisants avec les réglages ci-dessous, définis dans le bloc UART Configuration :

|               |  Mise en œuvre | Taille du tampon | Priorité d'interruption |
|---------------|:---------------:|:-----------:|:------------------:|
| S.BUS Rx      | Circular Buffer |      64     |          5         |
| S.BUS Tx      |       None      |      -      |          -         |
| Smart Port Rx | Circular Buffer |      32     |          5         |
| Smart Port Tx | Circular Buffer |      32     |          6         |
| F.Port Rx     | Circular Buffer |      32     |          5         |
| F.Port Tx     | Circular Buffer |      64     |          5         |

### Connexion des blocs Simulink S.BUS, Smart Port et F.Port à l'UART Rx & Tx

Les blocs S.Bus, F.Port et Smart Port xxx prennent le flux de sortie du récepteur pour en extraire les valeurs de commande envoyées par la radiocommande. Le flux d'entrée est un vecteur dont la longueur est définie par l'utilisateur. Toutes les valeurs du vecteur n'ont pas à être renseignées. Le bloc utilise le scalaire N, longueur d'entrée, pour savoir combien d'octets du vecteur d'entrée sont des valeurs reçues et doivent être traités. Le vecteur d'entrée du bloc peut recevoir des paquets de données partiels. Le paquet complet du récepteur peut être découpé dans le temps et envoyé au fur et à mesure que le MCU reçoit les valeurs ; ces blocs reconstituent le paquet avant de le traiter.

## Protocole S.BUS

Configuration de l'UART :

Seul le canal Rx est utilisé, avec les paramètres suivants :

- 100 000 bauds/s
- Logique Rx inversée (l'état de repos est le niveau bas), 3,3V
- Parité paire
- 2 bits de stop
- Pas de contrôle de flux

Rx utilise un Circular Buffer de 64 octets, avec une priorité d'interruption de 5.

Le bloc UART Rx est échantillonné à 1kHz (1ms).
La taille du vecteur de sortie, réglée sur « inherited via internal rule », prend la valeur 10 (pas plus de 10 octets ne peuvent être reçus en 1 ms à 100000 bauds/s avec deux bits de stop).

Dans l'interface graphique du bloc S.BUS, on sélectionne les sorties à décoder et la mise à l'échelle de chaque canal décodé.

{{< figure 
src="/img/uxv-block-sbus-gui-control-frame.png"
link="/img/uxv-block-sbus-gui-control-frame.png"
width="40%"
title="Interface utilisateur du bloc Simulink S.BUS"
caption="Ce bloc Simulink décode le flux d'entrée S.BUS. On choisit la mise à l'échelle de chaque canal RC de sortie."
numbered="true"
>}}

{{< figure 
src="/img/uxv-block-sbus-scheme-uart-connection.png"
link="/img/uxv-block-sbus-scheme-uart-connection.png"
width="100%"
title="Schéma du bloc UART Rx connecté au bloc S.BUS."
caption="Schéma de décodage du S.BUS pour un dsPIC"
numbered="true"
>}}

{{< figure 
src="/img/uxv-block-sbus-sport-channels-scaling.png"
link="/img/uxv-block-sbus-sport-channels-scaling.png"
width="100%"
title="Schéma de centrage et de mise à l'échelle des canaux S.BUS en sortie dans [-1000 1000]"
caption="Les valeurs brutes du S.BUS ne sont ni centrées ni mises à l'échelle par une puissance de 2."
numbered="true"
>}}

## Protocole Smart Port

Le Smart Port (S.Port) utilise un UART dont les broches Rx et Tx sont affectées à la même broche, en logique inversée (1 est le niveau haut). Un seul fil est utilisé, en communication half duplex.

Configuration de l'UART :

- 57600 bauds/s
- Half duplex
- Logique Rx et Tx inversée (l'état de repos est le niveau bas), 3,3V
- Pas de parité
- 1 bit de stop
- Pas de contrôle de flux

Mise en œuvre :

Rx utilise un Circular Buffer de 32 octets, avec une priorité d'interruption de 5.<br>
Tx utilise un Circular Buffer de 32 octets, avec une priorité d'interruption de 6.

Le bloc Smart Port décode les entrées provenant du récepteur et des autres capteurs connectés au bus à un seul fil.

Si une trame de capteur est reçue, elle est décodée et les valeurs sont disponibles en sortie du bloc.

Lorsqu'une requête du récepteur pour un identifiant de capteur est reçue et que cet identifiant est défini dans l'un des blocs Sensor du modèle, le bloc Smart Port génère la trame du capteur avec les dernières valeurs définies dans le bloc Sensor.
Le message est envoyé par un bloc UART Tx.

## Protocole F.Port

{{< figure 
src="/img/uxv-block-fport-gui-control-frame.png"
link="/img/uxv-block-fport-gui-control-frame.png"
width="40%"
title=""
caption=""
numbered="true"
>}}

{{< figure 
src="/img/uxv-block-fport-scheme-uart-connection.png"
link="/img/uxv-block-fport-scheme-uart-connection.png"
width="80%"
title=""
caption=""
numbered="true"
>}}

{{< gallery >}}
{{< figure 
src="/img/uxv-block-rc-pwm-gui.png"
link="/img/uxv-block-rc-pwm-gui.png"
title="Title"
caption="caption"
numbered="true"
>}}

{{< figure 
src="/img/uxv-block-rc-pwm-input-scaling.png"
link="/img/uxv-block-rc-pwm-input-scaling.png"
title="title"
caption="caption"
numbered="true"
>}}
{{< /gallery >}}




Configuration de l'UART :
Les canaux Rx et Tx sont utilisés. Ils sont affectés à la même broche. L'UART est configuré en half duplex.

- 115200 bauds/s
- Half duplex
- Logique Rx et Tx inversée (l'état de repos est le niveau bas), 3,3V
- Pas de parité
- 1 bit de stop
- Pas de contrôle de flux

Rx utilise un Circular Buffer de 32 octets, avec une priorité d'interruption de 5.

Tx utilise un Circular Buffer de 64 octets, avec une priorité d'interruption de 5.

### Ressources

Les protocoles FrSky ne sont pas toujours documentés. Les sites web suivants ont contribué à la compréhension des différents protocoles :

- [Smart Port sur ROBOTmaker](https://www.robotmaker.eu/home/quadcopters-360-degree-proximity-sensing-project-overview/frsky-s-port-interface)
- [Smart Port, projet telemetry-convert](https://code.google.com/archive/p/telemetry-convert/wikis/FrSkySPortProtocol.wiki)
- [Smart Port, TelemetryScript d'Allesandro Apostoli](https://github.com/yaapu/FrskyTelemetryScript/wiki/FrSky-SPort-protocol-specs)
- [S.BUS, bibliothèque Arduino](https://github.com/bolderflight/SBUS)
- [Smart Port, projet MavLink-FrSkySPort](https://github.com/athertop/MavLink_FrSkySPort/wiki)
- [code source de Betaflight](https://github.com/betaflight/betaflight/tree/master/src/main/telemetry)
- [projet ArduCopter](https://ardupilot.org/copter/docs/common-frsky-passthrough.html)
- [SBUS2, par Jerry Chapman](https://sbustelemetrysensors.blogspot.com/)


[^RSSI]: Received Signal Strength Indicator (indicateur de puissance du signal reçu)