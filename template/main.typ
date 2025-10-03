#import "@local/drifting-cls-thesis:0.1.0": thesis

#let author = (
  first-name: "First name",
  surname: "Surname",
)

#let group = (
  name: "Computational Science Lab",
  site: "https://uva.computationalscience.nl/"
)

#let dept = (
  name: "Informatics Institute",
  site: "https://ivi.uva.nl/"
)

#let faculty = (
  name: "Faculty of Science",
  site: "http://www.uva.nl/en/about-the-uva/organisation/organisational-structure/content/faculties/faculty-of-science-fnwi/faculty-of-science-fnwi.html"
)

#let degree = "Master of Science in Computational Science"

#let quotation = (attrib: [Richard P. Feynman], quote-text: [What I cannot create, I do not understand.])

#let abstract = [
  Include your abstract here. Abstracts must include sufficient information for reviewers to judge the nature 
  and significance of the topic, the adequacy of the investigative strategy, the nature of the results, and the
  conclusions. The abstract should summarize the substantive results of the work and not merely list topics to 
  be discussed. 

  Length 200-400 words.
]

#show: thesis.with(
  title: "Your Thesis Title",
  author: author,
  degree: degree,
  group: group,
  dept: dept,
  faculty: faculty,
  quotation: quotation,
  abstract: abstract,
)

= Introduction
#lorem(100)

#lorem(200)

#lorem(150)

= Methods
#lorem(100)

#lorem(150)

#lorem(130)

= Discussion
#lorem(200)

#lorem(300)

#lorem(200)

= Conclusion
#lorem(250)
