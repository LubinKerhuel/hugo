---
title: 'Replacement motor for Parrot Disco FPV Flying Wing'
subtitle: 'SURPASS Hobby C2826 (size 2208) 1350KV motor test'
summary: Motor candidate to replace the original PF070253 motor on the Parrot Disco Flying Wing.
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
  caption: Parrot Disco with Surpass Hobby C2826 (2208) 1350KV motor
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

Original motor of my parrot Disco Flying wing is broken after few flights. It is not burned. The CHUCK controller is still ok including the motor power stage. The problem comes from wires connections cut at the interface between motor and power cable. It is difficult to repair as the connection break is just few millimeters from the motor windings.

The root cause for theses wire cuts seems to be vibrations: On the original PF070253 DISCO motor, the power cable is not attached on the motor but directly connected on the thin motor wiring. Vibration of the cable powering the motor is likely to break thin motor wiring at the interface between cable and motor.

{{< figure 
src="/img/parrot-original-motor-front-small.jpg"
link="/img/parrot-original-motor-front.jpg"
width="80%"
title="Parrot DISCO original PF070253 motor (1280KV) with added connectors - front"
caption="Parrot DISCO original PF070253 motor (1280KV) with added connectors - front"
numbered="false"
>}}

{{< figure 
src="/img/parrot-original-motor-back-small.jpg"
link="/img/parrot-original-motor-back.jpg"
width="80%"
title="Attempt to repair the motor PF070253 of the DISCO FPV"
caption="Parrot DISCO original PF070253 motor - back"
numbered="false"
>}}

The original DISCO motor (PF070253, 1280KV) is difficult to find and out-priced. The SURPASS Hobby C2826 (size 2208) - 1350KV have similar shape and electrical characteristics. It is compatible  with the Parrot stock foldable propeller and DISCO wing motor mount. The motor reference is unclear as the motor size correspond to a "2208" but the motor is stamped (and sold) with reference C2826. Box of the SURPASS Hobby motor mention is "C2826 (2208) - 1350KV".

With this motor upgrade, the DISCO Flying wing is flying as with the original motor. The Parrot CHUCK controller handle motor speed as if it was the original one. Power consumption seems similar than the one with the original motor. It has been tested with the original DISCO propeller. 

I get a propeller replacement candidate in case the original did not fit the motor: the GEMFAN 8040 which fit that motor and has the same size as the stock propeller (Not tested).

{{< figure 
src="/img/parrot-surpass-c2826-mount-wires-small.jpg"
link="/img/parrot-surpass-c2826-mount-wires.jpg"
width="100%"
title="Parrot DISCO with SURPASS Hobby C2826 (2208) - 1350KV replacement motor - inside"
caption="Parrot DISCO with SURPASS Hobby C2826 (2208) - 1350KV replacement motor - inside"
numbered="false"
>}}

{{< figure 
src="/img/parrot-surpass-c2826-mount-final-small.jpg"
link="/img/parrot-surpass-c2826-mount-final.jpg"
width="100%"
title="Parrot DISCO with SURPASS Hobby C2826 (2208) - 1350KV replacement motor - detail"
caption="Parrot DISCO with SURPASS Hobby C2826 (2208) - 1350KV replacement motor - detail"
numbered="false"
>}}