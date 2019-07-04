---
title: miniature air-speed sensor

sitemap:
  priority: 1

slides:
  # Choose a theme from https://github.com/hakimel/reveal.js#theming
  theme: black  # Reveal JS theme name
  highlight_style: dracula  # Highlight JS theme name
  
  #slide_number: true
  progress: true 
  transition: zoom
  transition_speed: fast
  history: false

  defaultTiming: 120
  mouseWheel: true

  previewLinks: true

  backgroundTransition: fade

  # width: 100%
  # height: 100%
  # margin: 0
  # minScale: 1
  # maxScale: 3  

  
  
#markup: mmark 

---

## Pitot tube

### Miniature air-speed sensor
#### for RC plane & UAV

[full](/post/pitot-build) description

---

![/post/pitot-build/featured.jpg](/post/pitot-build/featured.jpg)

---
## Brass tube

![/img/pitot-darcy-prandtl-build-brasstubes.jpg](/img/pitot-darcy-prandtl-build-brasstubes.jpg)

---

## mp3v5004dp & mcp3428

![/img/pitot-darcy-prandtl-build-mp3v5004dp-mcp3428.jpg](/img/pitot-darcy-prandtl-build-mp3v5004dp-mcp3428.jpg)

- Resolution: 0.2041 Pa/LSB
- Range: [0 836] Pa ($\approx 100km/h $)

---

## Static sensor noise

- 90 min log @ 100Hz, indoor, still
- Standard Dev : 0.5 Pa 

---

<section data-background-image="/img/pitot-darcy-prandtl-static-characteristic.png" data-background-opacity=1 data-background-position="center" data-background-size="contain">
</section>

---

## Flight tests

![Plane](/img/firstar1600-qx7.jpg)

---

<p class="stretch">
<img data-src="/img/pitot-darcy-prandtl-wing-brass-mp3v5004dp-mcp3428.jpg">
</p>

<!-- ![Wing with Pitot](/img/pitot-darcy-prandtl-wing-brass-mp3v5004dp-mcp3428.jpg) -->

---

<p class="stretch">
<img data-src="/img/pitot-darcy-prandtl-wing-carbon2.jpg">
</p>

<!-- <section data-background-image="/img/pitot-darcy-prandtl-wing-carbon2.jpg" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section> -->

---

## Pressure - Speed

$P\_{diff} = \frac{1}{2}\rho v^2$


$v = \sqrt{\frac{2}{\rho} * P\_{diff}}$

with $\rho = 1.16 $

---

<section data-background-image="/img/pitot-darcy-prandtl-gps-wind-calibration-0.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>

---

<section data-background-image="/img/pitot-darcy-prandtl-gps-wind-calibration-1.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>

---

<section data-background-image="/img/pitot-darcy-prandtl-speed-error-wind-estimation.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>

---

<section data-background-image="/img/pitot-darcy-prandtl-gps-wind-calibration-2.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>

---

<section data-background-image="/img/pitot-darcy-prandtl-gps-wind-calibration-3.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>

---

<section data-background-image="/img/pitot-darcy-prandtl-gps-wind-calibration.png" data-background-opacity=1 data-background-position="center" data-background-size="contain" >
</section>


---

## results

|  $\underbrace{v\_{pitot}-v_{wind}^{p}-v\_{gps}}\_{error}$ | m/s | km/h |
|:--:|:--:|:--:|
| mean | 0.017 | 0.06 |
| standard deviation | 0.74 | 2.6 |
| | | |

with wind: 

- 2.6 m/s
- from 101° (east)

---

[page](/post/pitot-build) with further details

---

### flight trace

<section data-background-iframe="https://www.google.com/maps/d/u/0/embed?mid=1-K7dsmfbMCDL3IQK1z3IEtSduB2OWXr9" data-background-opacity=1>
</section>

---

### connecting (fish line protection)

![/img/pitot-darcy-prandtl-tubesoupledecathlon.jpg](/img/pitot-darcy-prandtl-tubesoupledecathlon.jpg)
