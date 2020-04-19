+++
# Display name
title = "Lubin Kerhuel"

# Username (this should match the folder name)
authors = ["lubin"]

# Is this the primary user of the site?
superuser = true

# Role/position
role = ""



# Details for the Contact Widget
address = "Lubin Kerhuel, 8 Chemin de Madame, 64100 Bayonne, FRANCE"

# Organizations/Affiliations
#   Separate multiple entries with a comma, using the form: `[ {name="Org1", url=""}, {name="Org2", url=""} ]`.
organizations = [ { name = "Microchip Technology Inc", url = "https://www.microchip.com/" } ]

# Short bio (displayed in user profile at end of posts)
bio = "Interested in signal processing and control theory. 10 years’ experience with rapid control prototyping."

# Enter email to display Gravatar (if Gravatar enabled in Config)
email = "lubin@kerhuel.eu"

# List (academic) interests or hobbies
interests = [
  "Control Theory",
  "Embedded system",
  "Bodysurf"
]


# List qualifications (such as academic degrees)
[[education.courses]]
  course = "Ph.D Automatic, Signal Processing & Aerial Robotics"
  institution = "National Center for Scientific Research (CNRS) / University Montpellier II"
  year = 2009

[[education.courses]]
  course = "Master of Research - Signal Processing and Digital Communication"
  institution = "University of Nice Sophia-Antipolis"
  year = 2004

[[education.courses]]
  course = "Engineer - System on Chip"
  institution = "ESIEE Paris"
  year = 2004

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

[[social]]
  icon = "envelope"
  icon_pack = "fas"
  link = "#contact"  # For a direct email link, use "mailto:test@example.org".

[[social]]
    icon = "linkedin"
    icon_pack = "fab"
    link = "https://www.linkedin.com/in/kerhuel/"  # For a direct email link, use "mailto:test@example.org".

[[social]]
  icon = "google-scholar"
  icon_pack = "ai"
  link = "https://scholar.google.co.uk/citations?user=61SJU_sAAAAJ"



#[[social]]
#    icon = "twitter"
#    icon_pack = "fab"
#    link = "https://twitter.com/LubinKerhuel"


#[[social]]
#  icon = "github"
#  icon_pack = "fab"
#  link = "link = "https://github.com/LubinKerhuel"




# Link to a PDF of your resume/CV from the About widget.
# To enable, copy your resume/CV to `static/files/cv.pdf` and uncomment the lines below.
# [[social]]
#   icon = "cv"
#   icon_pack = "ai"
#   link = "files/cv.pdf"

 # math = true

+++

Control projects during my academic study ended-up with simplest PID algorithm tuned through successive trials.
Code implementation for embedded systems requires an important effort. Time left for modeling, identification and simulation is often null.

I started in 2005 developing a blockset for Matlab/Simulink targeting dsPIC 33F microcontrollers to overcome such constraint.
Without a budget for dSPACE, SpeedGoat or another NI alternative, rapid prototyping became possible on any dsPIC based board.

$$
\text{One push button}
\left\\{ \begin{array}{l}
\text{- C code generation,} \\\\\\
\text{- Compilation,} \\\\\\
\text{- Upload \& run on the target.} \\\\\\
\end{array} \right.
$$ 

This Model Based Design (MBD) approach enabled efficient research on signal processing validated with real robot for my [PhD thesis](http://www.kerhuel.eu/publi/Kerhuel_2009_PhD.pdf) on bio-robotics from 2006 to 2009.
It reduces the time from the simulation to our [autonomous robot](https://www.researchgate.net/figure/a-OSCAR-II-like-its-predecessor-OSCAR-I-is-a-tethered-aerial-robot-that-orients-its_fig11_261957721) and replaced somehow our dSPACE platform which was not embedded anyway.

I used the same Rapid Control Prototyping (RCP) to develop data fusion algorithm on motion analysis for wearable sports article at [MOVEA](https://www.ideas-laboratory.com/projects/movea/) in 2010-2011. 

I joined [Microchip Technology](https://www.microchip.com/) where I am pursuing the development of the [MPLAB blockset](https://www.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink) to target dsPIC and PIC32 microcontrollers.

For company, scientists, and students, *rapid prototyping enables focusing on new ideas* rather than getting into the details of embedded programming.
Shortening the loopback $\lbrace Simulation \Leftrightarrow Hardware \rbrace$ allows improving algorithms, obtaining better results, and reducing the time to market.

I am not academic. I have limited opportunity for traditional publication. I share custom projects as they come using the most practical format for me to maintain. 
Most projects uses the free [Microchip blockset](https://www.mathworks.com/matlabcentral/fileexchange/71892-mplab-device-blocks-for-simulink) targeting dsPIC, PIC32 and few others microcontrollers. Old project are available on my [old website](https://www.kerhuel.eu/wiki/).

None are reference design. None are endorsed by Microchip Technology.  
