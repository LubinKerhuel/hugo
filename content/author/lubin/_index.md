+++
# Display name
name = "Lubin Kerhuel"

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

 math = true

+++

Most projects to practice control theory done during my school time (1999-2005) ended-up with simple PID algorithm tuned with successive trials.
Developpements on embedded systems requires so much time than the **remaining time for modeling, identification and simulation was almost null**.

Looking at a better possibility, the first attempt to target dsPIC 16f with the Simulink code generator failed due to compiler incompatibility. 
In 2005 however, the dsPIC 33f compiler and the generated code gets compatible thus I continued testing which ended up with a blockset targetting dsPIC 33f.

$$
\text{One push button}
\left\\{ \begin{array}{l}
\text{- C code generation,} \\\\\\
\text{- Compilation,} \\\\\\
\text{- Upload \& run on the target.} \\\\\\
\end{array} \right.
$$ 


This model based design method helped a lot to completed a [PhD thesis](http://www.kerhuel.eu/publi/Kerhuel_2009_PhD.pdf) on bio-robotics from 2006 to 2009.
It reduces the time from the simulation or dSPACE test bench platform to our [autonomous robot](https://www.researchgate.net/figure/a-OSCAR-II-like-its-predecessor-OSCAR-I-is-a-tethered-aerial-robot-that-orients-its_fig11_261957721). 

The same rapid prototyping scheme helped in developping various data fusion algorithm for sports applications at [MOVEA](https://www.ideas-laboratory.com/projects/movea/) in 2010-2011. 

I am now developping the [MPLAB blockset](https://www.microchip.com/simulinkblocks/) at [Microchip](https://www.microchip.com/) to target dsPIC and PIC32 microcontrollers.

For company, scientists, and students, *model-based design enable focusing on ideas* rather than getting lost in the embedded programming requirements.
Shortening the loop-(back) $\lbrace Simulation \Leftrightarrow Hardware \rbrace$ allows improving algorithms, getting better results, product, and possibly reduce the time to market.

The present website shares some experience with simulink as Rapid Prototyping tools through custom projects.
All are based on the [Microchip blockset](https://www.microchip.com/simulinkblocks/) targetting dsPIC. It uses matlab/simulink with embedded coder toolboxes and its dependancies.

None of the examples presented are a reference design endorsed by Microchip.  
