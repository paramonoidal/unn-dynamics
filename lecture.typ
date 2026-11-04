// Отдельная лекция: typst compile lecture.typ out.pdf --input lec=lectures/07_2026-10-30.typ
#import "template.typ": *

#let lec = sys.inputs.at("lec", default: "lectures/07_2026-10-30.typ")

#show: notes.with(
  title: [ОДУ и дискретные динамические системы],
  author: "Конспект лекций, осень 2026",
  date: none,
)

#include lec
