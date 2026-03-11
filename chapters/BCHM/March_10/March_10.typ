#import "./note_for_myself.typ": *

#show: article_settings.with(
  section_level: "section",
  heading_number_mode: "level3-last",
  title: "title",
  author: "The author",
  date: datetime.today().display(),
  author_page: link("https://www.example.com")[My Homepage],
  version: "1.0.0",
)

#let CH = math.op("CH")
#let kk = math.bold("k")
#let Div = math.op("Div")
#let Pic = math.op("Pic")
#let Cl = math.op("Cl")
#let ord = math.op("ord")
#let fkk = math.scr("K")
#let rank = math.op("rank")
#let supp = math.op("supp")
#let divisor = math.op("div")
#let Spec = math.op("Spec")
#let calO = math.cal("O")
#let calF = math.cal("F")
#let calN = math.cal("N")
#let calT = math.cal("T")
#let calE = math.cal("E")
#let Yang(content) = text(red)[Yang: #content]

== March 10

Goal of seminar: 
+ Existence of flips in dimension $3$.
+ Special termination (by scaling).




#question[
  definition of relative bigness.
]


log discrepancy: $A(Gamma_i ; X, Delta) = 1 + a(Gamma_i; X, Delta)$


klt $=>$ plt $=>$ dlt

klt

plt but not klt: $(PP^2, X=0)$.

dlt but not plt: $(PP^2, X Y Z = 0)$.

We can compute the log discrepancy by a *"good"* log resolution.

