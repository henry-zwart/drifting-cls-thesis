#import "@preview/hydra:0.6.2": hydra, anchor

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
    [#author.first-name #smallcaps(author.surname)],
    author.at("site", default: none)
  )
  let group-display = text-or-link(group.name, group.at("site", default: none))
  let dept-display = text-or-link(dept.name, dept.at("site", default: none))

  set align(center)

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
    v(-1.2em)
    strong(title)
    v(-0.6em)
    line(length: 100%, stroke: 0.5mm)
  }

  // Spacing between title and author/examiner block
  v(0.2em)

  // Author, examiner, supervisor, assessor
  {
    set par(leading: 1em)
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
  }
  v(0.5em)

  // Submission statement
  {
    set text(size: 12pt)
    emph[A thesis submitted in partial fulfilment of the requirements #linebreak() for the degree of #degree]
    v(0.3cm - 1.05em)
    [_in the_]
    v(0.4cm - 1.05em)
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
  let author-name = [#author.first-name #smallcaps(author.surname)]
  set list(marker: $square.filled.small$)

  show heading: it => {
    set text(size: 20pt)
    set align(center)
    it
    v(1em)
  }

  v(0.8fr)
  [
    = Declaration of Authorship

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

  pagebreak()
}

#let quotation-page(quotation) = {
  set quote(block: true)
  
  v(1.2fr)
  quote(attribution: quotation.attrib, quotes: true, emph(quotation.quote-text))
  v(6fr)

  pagebreak()
}
#let abstract-page(
  title: "Your Thesis Title",
  university-name: link("http://www.uva.nl", [UNIVERSITY OF AMSTERDAM]),
  author: (first-name: "First name", surname: "Surname"),
  degree: "Degree Name",
  faculty: (name: "Faculty Name"),
  dept: (name: "Department Name"),
  abstract
) = {
  let author-display = [#author.first-name #smallcaps(author.surname)]
  let faculty-display = text-or-link(faculty.name, faculty.at("site", default: none))
  let dept-display = text-or-link(dept.name, dept.at("site", default: none))

  // Reduce paragraph spacing -- we want finegrained control over this on Abstract page
  set par(spacing: 1em)

  set text(size: 11pt)
  set align(center)

  // Vertically centre page (this and closing one below)
  v(1fr)

  // "University of Amsterdam"
  university-name
  v(0.85em)

  // "Abstract" (page title)
  {
    show heading: it => {
      set text(size: 20pt, weight: "regular")
      set align(center)
      emph(it)
      v(0.2em)
    }
    [= Abstract] 
  }
  v(1em)

  // "Group" and "Department" names
  {
    faculty-display
    linebreak()
    dept-display
  }
  v(1em)

  // Degree name
  degree
  v(1em)

  // Thesis title and author
  {
    strong(title)
    v(0.5em)
    [by #author-display]
  }
  v(2em)

  // Display the actual abstract
  set align(left)
  set par(spacing: 2em, justify: true)
  abstract

  // Closing vertical space to vertically centre text
  v(1fr)

  pagebreak()
}

#let acknowledgements-page(acknowledgements) = {
  // Defaults
  set text(size: 11pt)
  set align(left)
  set par(justify: true)

  // Page title
  {
    show heading: it => {
      set text(size: 20pt, weight: "regular")
      set align(center)
      emph(it)
      v(1em)
      //v(0.2em)
    }
    // set align(center)
    // set text(size: 20pt)
    [= Acknowledgements]  
  }

  acknowledgements
  
  pagebreak()
}

// TODO: Link colours, entry spacing
#let main-contents-page() = {
  // Default spacing
  show outline.entry.where(level: 1): set block(above: 1.75em) 

  // First make outline for non-index frontmatter
  {
    show outline.entry.where(
      level: 1
    ): set block(below: 2.5em)

    set outline.entry(fill: none)

    outline(
      title: [Contents],
      target: selector(heading).before(<index-start>)
    )
  }

  
  // Then for index frontmatter
  {
    set outline.entry(fill: none)
    outline(
      title: none,
      target: selector(heading).after(<index-start>).and(selector(heading).before(<thesis-start>))
    )
  }
  v(2em)
  
  // Then for the actual thesis 
  outline(
    title: none,
    target: selector(heading).after(<thesis-start>).and(selector(heading).before(<bibliography-start>))
  )
  v(2em)

  // Finally, include bibliography
  {
    set outline.entry(fill: none)
    outline(
      title: none,
      target: selector(heading).after(<bibliography-start>)
    )
  }
 
  pagebreak()
  
}

#let thesis(
  title: "", 
  author: (first-name: "", surname: ""),
  degree: "",
  group: (name: ""),
  dept: (name: ""),
  faculty: (name: ""),
  quotation: none,
  abstract: none,
  acknowledgements: none,
  abbreviations: none,
  fontsize: 11pt,
  font: "New Computer Modern",
  rawfont: "New Computer Modern Mono",
  references: none,
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

  // LaTeX-style font
  set text(font: font)
  show raw: set text(font: font)

  // Make links blue
  show link: it => {
    set text(fill: rgb("#0000FF"))
    it
  }

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

  // Set roman numeral page numbering for frontmatter
  set page(numbering: "i")
  counter(page).update(1)

  declaration-of-authorship(
    author: author,
    title: title,
  )

  if quotation != none {
    page(numbering: none, quotation-page(quotation))
  }

  // TODO: This should not have page numbering, but removing the page number reverts to arabic numerals in outline 
  abstract-page(
    title: title,
    author: author,
    degree: degree,
    faculty: faculty,
    dept: dept,
    abstract
  )

  acknowledgements-page(
    acknowledgements,
  )

  // Index pages
  [#metadata("Index Start") <index-start>]
  
  // Header style for outline pages
  show heading.where(level: 1): it => {
    v(3em)
    it
    v(1.5em)
  }
  show heading.where(level: 1): set text(size: 25pt)

  // Include 'outline' pages, in the main outline
  show outline: set heading(outlined: true)
  show outline.entry.where(
    level: 1
  ): it => {
    strong(it)
  }

  // Main contents page
  main-contents-page()

  // Figures 
  outline(
    title: [List of Figures],
    target: figure.where(kind: image),
  )
  pagebreak()
  
  // Tables 
  // TODO: Make this and 'algorithms' optional
  outline(
    title: [List of Tables],
    target: figure.where(kind: table),
  )
  pagebreak()

  // Algorithms 
  outline(
    title: [List of Algorithms #label("frontmatter")] ,
    target: figure.where(kind: "algorithm"),
  ) 
  pagebreak()

  // Abbreviations page
  [= Abbreviations <frontmatter>]
  {
    set align(center)
    block(
      width: 70%,
      abbreviations
    )
  }
  pagebreak()
  
  // ===== Styling for main content =====
  // Set arabic numeral page numbering for main content
  set page(numbering: "1")
  counter(page).update(1)
  {
    // == Headings:
    //  - Use arabic numerals
    //  - Add extra space between number and heading title
    //  - Treat L1 headings as 'chapters': weak pagebreak + "Chapter X" + chapter name
    //      (https://forum.typst.app/t/how-to-display-chapter-x-above-level-1-heading-name/4105/3)
    set heading(numbering: "1.1", supplement: [Chapter])
    show heading: it => block(counter(heading).display(it.numbering) + h(2em) + it.body)

    show heading.where(level: 1): it => {
      // Weak pagebreak (don't break if the page is already empty)
      pagebreak(weak: true)
      block(below: 23pt * 2.5, {
        set text(size: 20pt)
        v(4.5em)
        block(below: 2.5em)[Chapter #counter(heading).display()]
        set text(size: 23pt)
        block(above: 1em,  it.body)
      }) 
    }

    show heading.where(level: 2): it => {
      set text(size: 14pt)
      block(above: 2.5em, below: 2em, it)
    }

    show heading.where(level: 3): it => {
      set text(size: 12pt)
      block(above: 2.5em, below: 2em, it)
    }

    // Header: Show (LHS) section title and (RHS) page number
    set page(
      header: context {
        if hydra(1) != none {
          grid(
            columns: (1fr,),
            inset: (bottom: 0.5em),
            [#emph(hydra(skip-starting: true, 1)) #h(1fr) #counter(page).display("1")],
            grid.hline(),
          )
        }
      },
      footer: none // TODO: Ideally this would should page numbers on the chapter pages, and otherwise be none.
    )

    // Mark the start of the thesis -- used for outline (ToC) logic
    [#metadata("Thesis Start") <thesis-start>]

    body
  }

  pagebreak(weak: true)

  [#metadata("Bibliography Start") <bibliography-start>]
  [= Bibliography]
  references
}

