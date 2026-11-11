---
title: 'Moteur de remplacement pour l''aile volante FPV Parrot Disco'
subtitle: 'Évaluation du moteur SURPASS Hobby C2826 (taille 2208) 1350KV'
summary: Moteur pouvant remplacer le moteur d'origine PF070253 de l'aile volante Parrot Disco.
authors:
- Lubin
tags: ["Parrot","Disco","Motor"]
categories: ["DIY"]
date: "2020-10-11"
#lastmod: "2019-04-12T00:00:00Z"
featured: false
draft: false

sitemap:
  priority: 0.25

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal point options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
image:
  caption: Parrot Disco avec le moteur Surpass Hobby C2826 (2208) 1350KV
#  focal_point: TopLeft
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

Le moteur d'origine de mon aile volante Parrot Disco est tombé en panne après quelques vols. Il n'est pas électriquement défectueux. Le contrôleur CHUCK reste fonctionnel, y compris l'étage de puissance du moteur. La défaillance provient de fils rompus à la jonction entre le moteur et le câble d'alimentation. La réparation est difficile, car la rupture se situe à quelques millimètres seulement des bobinages du moteur.

L'origine de ces ruptures de fils semble résider dans les vibrations : sur le moteur DISCO d'origine PF070253, le câble d'alimentation n'est pas fixé au moteur mais relié directement au fin câblage du moteur. Les vibrations du câble d'alimentation du moteur risquent de rompre le fin câblage du moteur à la jonction entre le câble et le moteur.

{{< figure 
src="/img/parrot-original-motor-front-small.jpg"
link="/img/parrot-original-motor-front.jpg"
width="80%"
title="Moteur d'origine Parrot DISCO PF070253 (1280KV) avec connecteurs ajoutés - face avant"
caption="Moteur d'origine Parrot DISCO PF070253 (1280KV) avec connecteurs ajoutés - face avant"
numbered="false"
>}}

{{< figure 
src="/img/parrot-original-motor-back-small.jpg"
link="/img/parrot-original-motor-back.jpg"
width="80%"
title="Tentative de réparation du moteur PF070253 du DISCO FPV"
caption="Moteur d'origine Parrot DISCO PF070253 - face arrière"
numbered="false"
>}}

Le moteur DISCO d'origine (PF070253, 1280KV) est difficile à se procurer et excessivement coûteux. Le SURPASS Hobby C2826 (taille 2208) - 1350KV présente une forme et des caractéristiques électriques similaires. Il est compatible avec l'hélice pliante d'origine de Parrot et avec le support moteur de l'aile DISCO. La référence du moteur est ambiguë : la taille correspond à un « 2208 », mais le moteur est estampillé (et vendu) sous la référence C2826. La boîte du moteur SURPASS Hobby indique « C2826 (2208) - 1350KV ».

Avec ce nouveau moteur, l'aile volante DISCO présente en vol le même comportement qu'avec le moteur d'origine. Le contrôleur Parrot CHUCK commande la vitesse du moteur comme s'il s'agissait du moteur d'origine. La consommation semble similaire à celle du moteur d'origine. Le montage a été évalué avec l'hélice DISCO d'origine.

Une hélice de rechange a été identifiée au cas où l'originale ne conviendrait pas à ce moteur : la GEMFAN 8040, qui s'y adapte et a la même taille que l'hélice d'origine (non évaluée).

{{< figure 
src="/img/parrot-surpass-c2826-mount-wires-small.jpg"
link="/img/parrot-surpass-c2826-mount-wires.jpg"
width="100%"
title="Parrot DISCO avec le moteur de remplacement SURPASS Hobby C2826 (2208) - 1350KV - vue intérieure"
caption="Parrot DISCO avec le moteur de remplacement SURPASS Hobby C2826 (2208) - 1350KV - vue intérieure"
numbered="false"
>}}

{{< figure 
src="/img/parrot-surpass-c2826-mount-final-small.jpg"
link="/img/parrot-surpass-c2826-mount-final.jpg"
width="100%"
title="Parrot DISCO avec le moteur de remplacement SURPASS Hobby C2826 (2208) - 1350KV - détail"
caption="Parrot DISCO avec le moteur de remplacement SURPASS Hobby C2826 (2208) - 1350KV - détail"
numbered="false"
>}}