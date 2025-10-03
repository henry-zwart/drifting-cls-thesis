#import "@preview/hydra:0.6.2": hydra

#let latex-margins = (
  top: 0.6in,
  right: 1.0in,
  bottom: 0.8in,
  left: 1.5in,
  head-height: 20pt,
  head-sep: 0.25in,
  foot-height: 9pt,
  foot-sep: 0.3in,
)

#let text-or-link(name, site) = {
  if site != none {
    link(site, name)
  } else {
    name
  }
}

#let titlepage(
  title: "Your Thesis Title",
  university-name: link("http://www.uva.nl", smallcaps[University of Amsterdam]),
  author: (first-name: "First name", surname: "Surname"),
  degree: "Degree Name",
  examiner: "Examiner Name",
  supervisor: "Supervisor Name",
  assessor: "Assessor Name",
  group: (name: "Group Name"),
  dept: (name: "Department Name")

) = {
  let author-display = text-or-link(
    [#author.first-name #upper(author.surname)],
    author.at("site", default: none)
  )
  let group-display = text-or-link(group.name, group.at("site", default: none))
  let dept-display = text-or-link(dept.name, dept.at("site", default: none))

  set align(center)
  show link: it => {
    set text(fill: rgb("#0000FF"))
    it
  }

  // "University of Amsterdam"
  {
    set text(size: 17pt)
    university-name
    v(1.2cm - 1em)
  }

  // "Master's Thesis"
  {
    set text(size: 14pt)
    smallcaps[Master's Thesis]
    v(0.2cm - 1em)
  }

  // Thesis title
  {
    set text(size: 20pt)
    line(length: 100%, stroke: 0.5mm)
    //v(0.2cm - 1em)
    v(-1.2em)
    strong(title)
    //v(0.4cm - 1em)
    v(-0.6em)
    line(length: 100%, stroke: 0.5mm)
    //v(1.5cm - 1em)
  }

  // Author, examiner, supervisor, assessor
  let display-person(title, name) = [#emph[#title:] #linebreak() #name]
  block(
    width: 80%,
    inset: 0pt,
    grid(
      columns: (1fr, 1fr),
      align: (left + horizon, right),
      display-person([Author], author-display),
      grid(
        rows: 3,
        gutter: 1em,
        align: right,
        display-person([Examiner], examiner),
        display-person([Supervisor], supervisor),
        display-person([Assessor], assessor),
      )
    )
  )
  v(0.5em)

  // Submission statement
  {
    set text(size: 12pt)
    emph[A thesis submitted in partial fulfilment of the requirements #linebreak() for the degree of #degree]
    v(0.3cm - 1em)
    [_in the_]
    v(0.4cm - 1em)
    group-display
    linebreak()
    dept-display
    v(2cm - 1em)
  }

  // Current date
  {
    set text(size: 12pt)
    datetime.today().display("[month repr:long] [year repr:full]")
    v(1.5cm - 1em)
  }

  // CSL Logo
  image(width: 60%, "resources/clslogo.png")

  pagebreak()
}

#let declaration-of-authorship(
  author: (first-name: "", surname: ""),
  title: "Your Thesis Title",
) = {
  let author-name = [#author.first-name #upper(author.surname)]
  set list(marker: $square.filled.small$)


  [
    #v(0.8fr)
    #{
      set text(size: 20pt)
      align(center, [Declaration of Authorship])
    }

    I, #author-name, declare that this thesis, entitled '#title' and the work presented in it are my own.
    I confirm that:
    #v(1em)

    - This work was done wholly or mainly while in candidature for a research degree at the University 
      of Amsterdam.

    - Where any part of this thesis has previously been submitted for a degree or any other qualification 
      at this University or any other institution, this has been clearly stated.

    - Where I have consulted the published work of others, this is always clearly at-
      tributed.

    - Where I have quoted from the work of others, the source is always given. With the exception of such 
      quotations, this thesis is entirely my own work.

    - I have acknowledged all main sources of help.

    - Where the thesis is based on work done by myself jointly with others, I have made clear exactly 
      what was done by others and what I have contributed myself.

    #v(3em)

    Signed:
    #v(2cm)

    Date: #datetime.today().display("[day] [month repr:long] [year repr:full]")
    #v(1fr)
  ]

}

#let thesis(
  title: "", 
  author: (first-name: "", surname: ""),
  degree: "",
  group: (name: ""),
  dept: (name: ""),
  fontsize: 11pt,
  body,
) = {
  // Page setup as in CLS LaTeX thesis template:
  //   https://www.overleaf.com/project/64ec7fc55c7249235bb1e9ed
  // Adapt margins -- in Typst the header is inside the margin rather than below it.
  let margin = (
    right: 1.0in,
    left: 1.5in,
    top: latex-margins.top + latex-margins.head-height + latex-margins.head-sep,
    bottom: latex-margins.bottom + latex-margins.foot-height + latex-margins.foot-sep,
  )

  set page(
    paper: "a4",
    numbering: none,
    columns: 1,
    margin: margin,
    header-ascent: latex-margins.head-sep,
    footer-descent: latex-margins.foot-sep,
  )

  set par(
    first-line-indent: 0pt,   // No indendation
    spacing: 2em,             // 2x fontsize space betw. paragraphs
    leading: 0.9em,             // Line spacing
    justify: true,
  )

  titlepage(
    title: title,
    author: author,
    degree: degree,
    group: group,
    dept: dept,
  )

  declaration-of-authorship(
    author: author,
    title: title,
  )

  // Header: Show (LHS) section title and (RHS) page number
  counter(page).update(0)
  pagebreak()
  set page(
    header: context [
      #grid(
        columns: (1fr,),
        inset: (bottom: 0.5em),
        [#emph(hydra(1)) #h(1fr) #counter(page).display("1")],
        grid.hline(),
      )
    ]
  )


  body
}

