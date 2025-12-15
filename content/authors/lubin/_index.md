---
# Display name
title: Lubin Kerhuel

# Username (this should match the folder name)
authors: lubin

# Is this the primary user of the site?
superuser: true

# Role/position
role: Engineer, PhD


# Details for the Contact Widget
address: Lubin Kerhuel, 19 rue Adrien Barthe, 64100 Bayonne, FRANCE

# Organizations/Affiliations
#   Separate multiple entries with a comma, using the form: `[ {name="Org1", url=""}, {name="Org2", url=""} ]`.
organizations:
- name: Microchip Technology Inc
  url: https://www.microchip.com/

# Short bio (displayed in user profile at end of posts)
bio: Interested in signal processing and control theory. 10 years experience with rapid control prototyping.

# Enter email to display Gravatar (if Gravatar enabled in Config)
email: lubin@kerhuel.eu

# List (academic) interests or hobbies
interests:
- Control Theory \& applied math
- Embedded system
- Swimming

# List qualifications (such as academic degrees)
education:
  courses:
  - course: Ph.D Automatic, Signal Processing & Aerial Robotics
    institution: National Center for Scientific Research (CNRS) / University Montpellier II
    year: 2009
  - course: Master of Research - Signal Processing and Digital Communication
    institution: University of Nice Sophia-Antipolis
    year: 2004
  - course: Engineer - System on Chip
    institution: ESIEE Paris
    year: 2004

# Social/Academic Networking
#
# Icon pack "fab" includes the following social network icons:
#
#   twitter, weibo, linkedin, github, facebook, pinterest, google-plus,
#   youtube, instagram, soundcloud
#
#   For email icon, use "fas" icon pack, "envelope" icon, and
#   "mailto:your@email.com" as the link.
#
#   Full list: https://fontawesome.com/icons
#
# Icon pack "ai" includes the following academic icons:
#
#   cv, google-scholar, arxiv, orcid, researchgate, mendeley
#
#   Full list: https://jpswalsh.github.io/academicons/


# Social/Academic Networking
# For available icons, see: https://sourcethemes.com/academic/docs/page-builder/#icons
#   For an email link, use "fas" icon pack, "envelope" icon, and a link in the
#   form "mailto:your-email@example.com" or "/#contact" for contact widget.
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

# Link to a PDF of your resume/CV.
# To use: copy your resume to `static/media/resume.pdf`, enable `ai` icons in `params.toml`, 
# and uncomment the lines below.
# - icon: cv
#   icon_pack: ai
#   link: media/resume.pdf

# Highlight the author in author lists? (true/false)
highlight_name: false

# Create Simulink toolbox for dsPIC Microcontrollers.
#	Write rate-monotonic scheduler (multitasking RTOS)
#	- sum-up hardware capabilities in an easy to use graphical interface. Generate C code.
#	- Optimize code implementing through Simulink Code Replacement Library. Wrote low level code in C or assembly for best use of the hardware
#	- add PIC32 chip
#		- Scheduler, Peripheral user interface and code, enabling CMSIS Optimisation
#	- add SAMx2, SAMx5 and SAMx7 chip family (respectively for Cortex M0+, Cortex M4 and Cortex M7) 
#		- Scheduler, Peripheral user interface and code, enabling CMSIS Optimisation


#	- 2022, recenter on dsPIC. Adding dsPIC A chip (Scheduler, Peripheral user interface)

# MBSE: Model Based Design Engineer
# Digital Twin
# modeling from first principle modeling (or physical modeling), or data driven model

---

{{% callout warning %}}
Postings on this website are my own and do not represent Microchip's positions, strategies, or opinions.
{{% /callout %}}

Embedded systems requires programming skills and an important set-up effort. Control algorithm is typically implemented last with a PI feedback loop. However control theory provides many solutions to explore improving systems dynamic responses, perturbation rejection and robusness to model mismatch.

Interested in applied math, I developed a blockset for Matlab/Simulink targeting dsPIC microcontrollers in 2005. It enables focusing on the controller part using simulink simulation rather than on implementation problems. Rapid Control Prototyping (RCP) became possible on any dsPIC based board. It is embedded on cheap demo or custom board and does not required budget to aquire high-end tools like dSPACE, SpeedGoat, National Instrument alternative. 

$$
\text{One push button}
\left\\{ \begin{array}{l}
\text{- Generate C code} \\\\\\
\text{- Compile} \\\\\\
\text{- Upload \& Run on the target} 
\end{array} \right.
$$ 

I used this dsPIC Target toolbox for my [PhD thesis](https://www.kerhuel.eu/publi/Kerhuel_2009_PhD.pdf) on bio-robotics from 2006 to 2009 on.
It shorten path from the visual signal processing simulation and control of our [aerial robot](https://www.researchgate.net/profile/Nicolas-Franceschini/publication/261957721/figure/fig11/AS:613971820285953@1523393697097/a-OSCAR-II-like-its-predecessor-OSCAR-I-is-a-tethered-aerial-robot-that-orients-its_W640.jpg) and replaced the original dSPACE platform in our lab.

The same approach was then used to develop data fusion algorithm on motion analysis in wearable sports article at [MOVEA](https://www.cea-tech.fr/cea-tech/english/Pages/success-stories/movea.aspx) in 2010-2011. 

I joined in 2011 [Microchip Technology](https://www.microchip.com/) to pursue the development of the [MPLAB blockset](https://www.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink). The tool target dsPIC and was extended to target: 
- dsPIC A
- PIC32 (MIPS core)
- SAMx2 (ARM Cortex M0+)
- SAMx5 (ARM Cortex M4)
- SAMx7 (ARM Cortex M7)

We implemented a rate-monotonic scheduler (multitasking system) and integrates completely to the MathWorks environment with support for PIL (Processor In the Loop), External-Mode...

The tool growth to target up to 650 chips. The development task and support was splitted in 2022. I will continue focusing on dsPIC new developments and support.

For company, scientists, and students, *rapid prototyping enables focusing on ideas* rather than getting lost into the details of embedded programming.
Shortening the loopback $Simulation \Leftrightarrow Hardware $ allows to 
- refine and validate a model thanks to early test
- develop controller using the system digital twin
- implement the final controller
- benefit from the wide MathWorks tools available

Electronics projects from this website use the [Microchip blockset](https://www.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink). Older project are available on my [old website](https://www.kerhuel.eu/wiki/).
