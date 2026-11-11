+++
# Project title.
title = "TP INSA - Commande temps réel d'un moteur DC / PMSM"

aliases = ["/project/lab_dc_motor/"]

# Date this page was created.
date = 2018-12-01
lastMod = 2019-06-01
draft = false

authors = ["lubin","romain-delpoux"]

# Project summary to display on homepage.
summary = "Simulation et commande temps réel d'un moteur avec la carte MCLV 2"

# Tags: can be used for filtering projects.
# Example: `tags = ["machine-learning", "deep-learning"]`
tags = ["simulink","matlab","motor","control","rapid prototyping"]

# Optional external URL for project (replaces project detail page).
external_link = ""

share = false  # Show social sharing links?
profile = false  # Show author profile? Show only first profile
comments = false  # Show comments?

# Slides (optional).
#   Associate this project with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides = "example-slides"` references 
#   `content/slides/example-slides.md`.
#   Otherwise, set `slides = ""`.
slides = "slides_dcmotor_insa_2022_12" 
# "slides_dcmotor_insa"

# Links (optional).
url_pdf = ""
url_preprint = ""
url_code = ""
url_dataset = ""
url_project = ""
url_slides = ""
url_video = ""
url_poster = ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.
#links = [{icon_pack = "fab", icon="twitter", name="Follow", url = "https://twitter.com/georgecushen"}]

links = [
	{name = "TP moteur DC", url = "https://rtdc.ctrl-elec.fr/"},
  {name = "TP moteur PMSM", url = "https://rcp.ctrl-elec.fr/"},
	{name = "Modèles Simulink", url = "https://github.com/rdelpoux/INSA_TP_CommandeTempsReel_MCC/tree/master/LABMatlabFiles/"},
	]

# Featured image
# To use, add an image named `featured.jpg/png` to your project's folder. 
[image]
  # Caption (optional)
  caption = "Moteur Pravalux"
  
  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = "Smart"
+++

Commande d'un moteur 24 V (Pravalux 24 V DC) avec la carte MCLV-V2 équipée d'un dsPIC 33EP256MC506.
Ce TP s'adresse aux étudiants de 5e année de l'INSA-Lyon.

Le sujet du TP est disponible à l'adresse : https://rtdc.ctrl-elec.fr/.

Les diapositives présentent les adaptations nécessaires pour passer d'un modèle Simulink de simulation (ou dSPACE) à un modèle Simulink ciblant un microcontrôleur. Deux sujets sont abordés :

- Ordonnancement temps réel / analyse de la charge du processeur
- Types de données en virgule fixe

2021 : le TP sur dSPACE n'étant pas envisageable en salle à cause de la pandémie de Covid-19, il a été remplacé par un TP à domicile sur des cartes MCLV-2 envoyées aux étudiants.
Le sujet du TP est disponible à l'adresse : https://rcp.ctrl-elec.fr/
