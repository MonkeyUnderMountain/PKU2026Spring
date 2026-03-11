// noteformyself.typ




//---------------------------------------------------------------------------------
// theorem-like environments and proof environments
//---------------------------------------------------------------------------------
// the package `ctheorems` is used to create theorem-like environments with custom styling
#import "@preview/ctheorems:1.1.3": *

// Define a helper function to create your specific box style
#let my-thm(name, color) = thmbox(
  "theorem", 
  name,
  base: none,
  fill: color.lighten(90%),
  stroke: (
    left: 2pt + color,
    top: none,
    right: none,
    bottom: none,
  ),
  inset: (top: 6pt, left: 8pt, right: 8pt, bottom: 6pt),                  // The "left" and "right" padding
  radius: 0pt,                 // Sharp corners
  padding: (top: 0em, bottom: 0em),
  breakable: true,
  supplement: name
)
// Define a helper function for plain styled environments without background fill
#let my-plain-thm(name, color) = thmbox(
  "theorem", 
  name,
  base: none,
  fill: none,
  stroke: (
    left: 2pt + color,
    top: none,
    right: none,
    bottom: none,
  ),  
  inset: (
    top: 3pt,
    bottom: 3pt,
    left: 8pt,
    right: 8pt,
  ),
  // radius: 0pt,                 // Sharp corners
  padding: (top: 0em, bottom: 0em),
  breakable: true,
  supplement: name
)
// define specific theorem-like environments with different colors
#let definition = my-thm("Definition", blue)
#let proposition = my-thm("Proposition", rgb("#C00040"))
#let theorem = my-thm("Theorem", red)
#let lemma = my-thm("Lemma", orange)
#let corollary = my-thm("Corollary", rgb("#FF00FF"))
#let conjecture = my-thm("Conjecture", rgb("#EE82EE"))
#let question = my-thm("Question", rgb("#D8BFD8"))
// define plain styled environments without background fill
#let remark = my-plain-thm("Remark", rgb("#808000"))
#let claim = my-plain-thm("Claim", orange)
#let example = my-plain-thm("Example", green)
#let exercise = my-plain-thm("Exercise", rgb("#008080"))
#let construction = my-plain-thm("Construction", rgb("#0000FF"))
#let notation = my-plain-thm("Notation", rgb("#191970"))

// the slogan environment is a special case with custom formatting
#let slogan = thmbox(
  "slogan",
  "Slogan",
  fill: green.lighten(90%),
  stroke: 2pt + green,
  radius: 0pt,
  inset: 8pt,
  padding: (top: 0pt, bottom: 0pt),
  bodyfmt: x => emph(x),
  titlefmt: _ => strong("Slogan"),
)

//the step and case environments, their numbering will be handled in the proof environment section below
#let my-stepbox(identifier, name, color) = thmbox(
  identifier,
  name,
  base: none,
  fill: none,
  stroke: (
    left: 2pt + color,
    top: none,
    right: none,
    bottom: none,
  ),inset: (
    top: 3pt,
    bottom: 3pt,
    left: 8pt,
    right: 8pt,
  ),                 // The "left" and "right" padding
  // radius: 0pt,                 // Sharp corners
  padding: (top: 0em, bottom: 0em),
  breakable: true,
  supplement: name
)
#let _local_num = (..nums) => str(nums.pos().last())

#let step = my-stepbox("step", "Step", orange).with(
  base: "proof",
  numbering: _local_num,
  refnumbering: _local_num,
)
#let case = my-stepbox("case", "Case", orange).with(
  base: "proof",
  numbering: _local_num,
  refnumbering: _local_num,
)

// Proof has its own hidden numeric counter so Step/Case can attach with base: "proof".
#let proof = thmproof(
  "proof",
  "Proof",
  padding: (top: 0pt, bottom: 0pt),
  inset: (top: 3pt, left: 8pt, right: 8pt, bottom: 3pt),
  breakable: true,
  stroke: (
    left: 2pt + rgb("#A7C8C9"),
    top: none,
    right: none,
    bottom: none,
  ),
  titlefmt: _ => emph("Proof"),
).with(
  numbering: "1",
)
// -----------------------------------------------------------------------------
// Proof-local Step/Case design notes
// -----------------------------------------------------------------------------
// Goal:
// - Inside each #proof[...], Step/Case should restart at 1.
// - Labels on steps/cases (e.g. <step:cosets>) must be referenceable via
//   @step:cosets.
// - Display should be "Step 1", "Step 2", ... (not composite forms like
//   "Step 0.1.2").
//
// Why this works with ctheorems:
// - ctheorems tracks theorem counters by identifier and optional base.
// - We define "step" and "case" once as theorem environments.
// - We set base: "proof", so whenever the proof counter changes, step/case
//   restart automatically for that proof.
//
// Important implementation detail:
// - The proof environment must actually be numbered for base: "proof" to have
//   a counter to attach to. We keep numbering: "1" on _proof_env, but hide the
//   visual number by overriding titlefmt to always print just "Proof".
//
// Reference behavior:
// - We avoid wrapping step/case themselves in a top-level `context` expression,
//   because Typst cannot reference a `context` node.
// - Using direct thmbox environments keeps labels attachable and refs valid.
//
// Number formatting:
// - ctheorems passes all counter components to numbering/refnumbering.
// - _local_num takes only the last component so rendered numbers are local:
//   Step 1, Step 2, ... and Case 1, Case 2, ...
// -----------------------------------------------------------------------------















//---------------------------------------------------------------------------------
// The main class wrapper for the document, which can be customized with different section levels and metadata
// The `article_settings` function takes in parameters for section level, title, author, date, author page link, version, and the main body content of the document.
//----------------------------------------------------------------------------------

#let article_settings(
  section_level: "section",

  title: none,
  author: none,
  date: datetime.today().display(),
  author_page: none,
  version: none,
  page_paper: "a4",
  page_margin: 36pt,
  font: none,
  font_size: 12pt,
  
  heading_number_mode: "full",

  make_title: true,

  body,

  ref_color: rgb("#C00040"),
  heading_ref_color: rgb("#005F73"),
  equation_ref_color: rgb("#AE2012"),
  cite_color: rgb("#6D597A"),
  external_link_color: rgb("#0A66C2"),
  internal_link_color: rgb("#0077B6"),
) = {
  // Make theorem figure styling active at the document level via the class wrapper.
  show: thmrules.with(qed-symbol: $square$)
  //-- make outline entries link to their location in the document
  show outline.entry: it => link(it.element.location(), it)




  //-- Set up page layout, document metadata, and text styling based on the provided parameters.
  set page(
    paper: page_paper,
    margin: page_margin,
  )
  set document(title: title, author: author)
  set text(size: font_size)
  if font != none and font != "" {
    set text(font: font)
  }
  set par(justify: true, first-line-indent: 2em)



  // Section heading customization (compute sizes first to avoid `set` inside `if`):
  let heading_size_1 = if section_level == "book" or section_level == "chapter" or section_level == "section" {2.1em} 
    else {1.728em}
  let heading_size_2 = if section_level == "book" or section_level == "chapter" or section_level == "section" {1.728em} 
    else {1.44em}
  let heading_size_3 = if section_level == "book" or section_level == "chapter" or section_level == "section" {1.44em} 
    else {1.2em}
  show heading.where(level: 1): set text(
    size: heading_size_1,
    weight: "bold",
    fill: black,
  )
  show heading.where(level: 2): set text(
    size: heading_size_2,
    weight: "bold",
    fill: black,
  )
  show heading.where(level: 3): set text(
    size: heading_size_3,
    weight: "bold",
    fill: black,
  )

  // Number only level-3 headings in section mode.
  // `hanging-indent: 0em` removes leftover prefix spacing on unnumbered levels.
  let heading_numbering = if section_level == "section" {
    (..nums) => {
      let parts = nums.pos()
      if parts.len() == 3 {
        numbering("1.", parts.last())
      } else {
        none
      }
    }
  } else if section_level == "chapter" {
    (..nums) => {
      let parts = nums.pos()
      if parts.len() == 2 {
        numbering("1.", parts.last())
      } else if parts.len() == 3 {
        none
      }
    }
  } else {
    "1."
  }
  set heading(numbering: heading_numbering, hanging-indent: 0em)





  // Distinguish hyperlinks by semantic kind: refs, citations, and raw links.
  show ref: it => {
    let el = it.element
    if el == none {
      [
        #set text(fill: ref_color)
        #it
      ]
    } else if el.func() == heading {
      [
        #set text(fill: heading_ref_color)
        #it
      ]
    } else if el.func() == math.equation {
      [
        #set text(fill: equation_ref_color)
        #it
      ]
    } else {
      [
        #set text(fill: ref_color)
        #it
      ]
    }
  }
  show cite: it => {
    text(fill: cite_color)[#it]
  }
  show link: it => {
    let is_external = if type(it.dest) == str {
      it.dest.starts-with("http://") or it.dest.starts-with("https://") or it.dest.starts-with("mailto:")
    } else {
      false
    }
    let c = if is_external { external_link_color } else { internal_link_color }
    if is_external {
      text(fill: c)[#underline(it)]
    } else {
      text(fill: c)[#it]
    }
  }

  


  //-- Conditionally render the title section if a title is provided, including author metadata as a footnote.
  let author_meta = [
    #author, #h(2pt) #date
    #if author_page != none [ ,#h(2pt) #author_page .
    ]
  ]
  show page: it => {
    let page_number = it.number()
    if page_number == 1 {
      footer[align(left)[small[author_meta]]]
    } else {
      none
    }
  }




  // Finally, render the main body content of the document.
  body
}