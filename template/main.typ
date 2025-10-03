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

#let degree = "Master of Science in Computational Science"

#show: thesis.with(
  title: "Your Thesis Title",
  author: author,
  degree: degree,
  group: group,
  dept: dept,
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
