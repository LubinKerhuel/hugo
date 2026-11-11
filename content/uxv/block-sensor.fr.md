---
linktitle: bloc Sensor
title: bloc Sensor
summary: Le bloc Sensor définit l'identifiant du capteur et les valeurs de données à envoyer à la radiocommande par télémétrie. Les données sont transmises au récepteur soit par le F.Port, soit par le Smart Port.
weight: 10

tags:
    - rapid prototyping
    - model based design (MBD)
    - matlab
    - simulink
    - UAV
    - UxV
    - Sensor
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
        name: sensor
        identifier: sensor
        weight: 25
         

---
<!-- Enable Photo Swipe + gallery features -->
{{< load-photoswipe >}}

Le bloc ajoute un « paquet » capteur à transmettre à un récepteur par le Smart Port ou le F.Port. Le récepteur envoie le paquet de télémétrie à la radiocommande (RC). Le modèle Simulink doit par conséquent comporter soit un bloc Smart Port, soit un bloc F.Port.

Chaque bloc Sensor déclare la référence du capteur, composée des deux paramètres PhysId et {Address+Offset}. La valeur du capteur est fournie par l'entrée du bloc sous la forme d'un tableau de 4 octets. Plusieurs instances du bloc Sensor peuvent être ajoutées dans un modèle. Deux instances peuvent avoir la même référence de capteur, ce qui convient à un capteur qui envoie plusieurs paquets de valeurs différentes (voir le capteur FrSky FVLSS ou GPS).

Chaque instance du bloc ajoute un tampon de 4 octets qui stocke la valeur du capteur, mise à jour à l'exécution du bloc. Le temps d'échantillonnage du bloc définit la cadence de mise à jour du tampon interne.

Le comportement diffère entre les protocoles Smart Port et F.Port :

### Comportement avec le Smart Port

Le récepteur interroge (ping) l'électronique connectée au Smart Port pour une référence de capteur donnée. Lorsqu'un capteur donné est interrogé, il doit répondre en fournissant ses 4 octets de valeur dans un délai de 3 ms. 

Si plusieurs instances du bloc Sensor utilisent la même référence de capteur (PhysId, Address+Offset), les paquets de données de chaque bloc sont envoyés les uns après les autres.

- Si un identifiant de capteur donné est interrogé deux fois sans que son bloc (aucun de ses blocs, s'il y en a plusieurs) n'ait été mis à jour entre-temps, le même contenu est renvoyé.
- Si un bloc Sensor est mis à jour alors que son contenu précédent n'a pas encore été envoyé, la mise à jour est sans effet et la nouvelle valeur est perdue. 

### Comportement avec le F.Port

Le contrôleur unique connecté au F.Port envoie une valeur de capteur à chaque paquet de canaux RC reçu. Le capteur à envoyer dépend uniquement du contrôleur, qui peut envoyer un capteur quelconque.

Chaque mise à jour d'un bloc Sensor ajoute le capteur dans une file FIFO de demandes d'envoi de capteurs.
Une seule demande par instance de bloc Sensor peut être présente dans cette FIFO.

- Si un bloc Sensor est mis à jour alors que sa valeur précédente n'a pas encore été envoyée, c'est-à-dire que sa demande d'envoi est toujours dans la FIFO, la mise à jour est sans effet et la nouvelle valeur est perdue.

Contrairement au Smart Port, un capteur ne peut pas être envoyé deux fois sans avoir été mis à jour entre-temps, car le capteur est placé dans la FIFO des demandes d'envoi au moment de sa mise à jour.


pour le capteur correspondant
 La cadence de mise à jour du bloc est choisie par l'utilisateur final.    dont la valeur sera envoyée au récepteur. Le récepteur envoie ensuite l'identifiant du capteur et les valeurs correspondantes à la radiocommande par télémétrie.

La communication avec le récepteur peut utiliser soit le Smart Port, soit le F.Port.

Le PhyId du capteur, l'APPID et la variante d'offset d'APPID sont définis dans le bloc.
Le champ PRIM doit être positionné à 0X10 pour un capteur. L'unité de la valeur du capteur est définie dans le bloc.
L'entrée du bloc est le codage sur 4 octets de la valeur du capteur. 