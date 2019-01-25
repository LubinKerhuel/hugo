+++
# Display name
name = "Lubin Kerhuel"

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
bio = "Interrested in signal processing and control theory, 10 years of experience with rapid control prototyping tools."

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


 
+++

During my schrool time (1999-2005), writing C program for embedded system absorbed all the effort therefore control projects ended up with simple PID algorithm tuned with successive trials. **Time dedicated to modeling, identification and simulation were null**.

I developed a blockset to target dsPIC Micro-Controllers Unit (MCU) from simulink in 2005. It enables testing a model on real hardware through a single push button:

- code generation,
- compilation,
- download on the target done all at once.

I used this model based designed from 2006 to complete a [PhD thesis](http://www.kerhuel.eu/publi/Kerhuel_2009_PhD.pdf) on robots inspired from the fly's visual control system. It reduces the time from the simulation or dSPACE test bench platform to our [autonomous robot](https://www.researchgate.net/figure/a-OSCAR-II-like-its-predecessor-OSCAR-I-is-a-tethered-aerial-robot-that-orients-its_fig11_261957721). 

Thereafter I joined [MOVEA](https://www.ideas-laboratory.com/projects/movea/), where I designed various data fusion algorithm for sports applications using the same rapid control prototyping approach. 

I ended-up at [Microchip](https://www.microchip.com/) developping the [MPLAB blockset](https://www.microchip.com/simulinkblocks/) to target dsPIC and PIC32 microcontrollers.

For company, scientists, and student, *model-based design enable focusing on ideas behind algorithm* rather than developping time consuming C program including peripheral drivers. Shortening the loop-(back) $\lbrace Simulation \Leftrightarrow Hardware \rbrace$ allows improving algorithms, getting better results, product, and possibly reduce the time to market.

The present website shares my experience of Rapid Control Prototyping tools through simple but fun projects. All are based on the [Microchip blockset](https://www.microchip.com/simulinkblocks/) which is available for free but requires matlab/simulink with embedded coder. 

