#import "../../Accessories/note_for_myself.typ": *
#import "../../Accessories/my_macros.typ": *

#show: article_settings.with(
  section_level: "chapter",
  heading_number_mode: "level3-last",
  title: "title",
  author: "The author",
  date: datetime.today().display(),
  author_page: link("https://www.example.com")[My Homepage],
  version: "1.0.0",
)

#let kk = math.italic("k")

#outline()


#include "March_10/March_10.typ"
#include "Homework1/Homework1.typ"