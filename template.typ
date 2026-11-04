// Единый шаблон конспектов: ilm (оформление книги) + ctheorems (теоремные окружения) + cetz (рисунки).
#import "@preview/ilm:1.4.1": ilm
#import "@preview/ctheorems:1.1.3": *
#import "@preview/cetz:0.3.4"

// ───────── цвета ─────────
#let c-thm = rgb("#2b5fa8")
#let c-def = rgb("#2e7d4f")
#let c-rem = rgb("#8a6d1d")
#let c-hw = rgb("#a33a3a")
#let c-ex = rgb("#6b4aa0")

// ───────── окружения ─────────
#let box-env(id, head, color, fill-tint) = thmbox(
  id, head,
  base: "heading", base_level: 1,
  fill: fill-tint,
  stroke: (left: 2pt + color),
  inset: (x: 1em, y: 0.8em),
  radius: 0pt,
  padding: (top: 0.4em, bottom: 0.4em),
  namefmt: name => [(#name)],
  titlefmt: t => text(fill: color, weight: "bold", t),
  separator: [.#h(0.4em)],
)
#let plain-env(id, head, color) = thmplain(
  id, head,
  base: "heading", base_level: 1,
  titlefmt: t => text(fill: color, weight: "bold", t),
  namefmt: name => [(#name)],
  separator: [.#h(0.4em)],
  inset: (x: 0em, y: 0.2em),
)

#let theorem = box-env("theorem", "Теорема", c-thm, c-thm.lighten(94%))
#let lemma = box-env("lemma", "Лемма", c-thm, c-thm.lighten(94%))
#let prop = box-env("prop", "Утверждение", c-thm, c-thm.lighten(94%))
#let definition = box-env("definition", "Определение", c-def, c-def.lighten(93%))
#let remark = plain-env("remark", "Замечание", c-rem)
#let example = plain-env("example", "Пример", c-ex)
#let problem = plain-env("problem", "Задача", c-hw)
// Контрольные вопросы и задачи на подумать из методичек (отдельная нумерация, чтобы не сдвигать номера задач с лекций)
#let question = plain-env("question", "Вопрос", c-hw)
#let homework = plain-env("homework", "Д/з", c-hw)
#let proof = thmproof("proof", "Доказательство", base: "heading", base_level: 1, titlefmt: emph, inset: (x: 0em, y: 0.2em))

// Блок с полным решением домашнего задания
#let solution(title, body) = block(
  width: 100%, breakable: true,
  fill: c-hw.lighten(94%),
  stroke: (left: 2pt + c-hw),
  inset: (x: 1em, y: 0.8em),
  above: 1.2em, below: 1.2em,
)[
  #text(fill: c-hw, weight: "bold")[#title.] #h(0.3em) #body
]

// ───────── пометки из рукописного конспекта ─────────
#let hl-g(body) = highlight(fill: rgb("#b9f0c4"), extent: 1pt, body)
#let hl-r(body) = highlight(fill: rgb("#ffc2c2"), extent: 1pt, body)
#let note(body) = block(
  inset: (left: 0.8em, y: 0.1em),
  stroke: (left: 1pt + luma(170)),
  text(size: 0.9em, fill: luma(60), body),
)
#let todo(body) = text(fill: c-hw, style: "italic", [\[#body\]])

// ───────── математические сокращения ─────────
#let unif(..a) = {
  let p = a.pos()
  if p.len() == 1 { $limits(⇉)_(#p.at(0))$ } else { $limits(⇉)^(#p.at(0))_(#p.at(1))$ }
}
#let dd = $"d"$
#let lim-to(sub) = $limits(lim)_(#sub)$
#let Rn = $bb(R)^n$
#let cl(x) = $overline(#x)$
#let tr = math.op("tr")
#let Per = math.op("Per")
#let fix = math.op("fix")
#let div = math.op("div")
#let diam = math.op("diam")
#let Lip = math.op("Lip")

// Заголовок лекции: (номер, дата, тема)
#let lecture(n, date, topic) = {
  counter(heading).update(n - 1)
  heading(level: 1)[#if date != none [#date · ]#topic]
}

// Подпись к рисунку без нумерации «Рис.»
#let fig(body, cap: none) = figure(body, caption: cap, kind: "scheme", supplement: [Рис.], numbering: none)

// ───────── главный шаблон ─────────
#let notes(title: [], author: "", date: none, body) = {
  set text(lang: "ru", font: ("Libertinus Serif", "New Computer Modern"))
  show math.equation: set text(font: "New Computer Modern Math")
  show: ilm.with(
    title: title,
    author: author,
    date: date,
    date-format: "[day].[month].[year]",
    external-link-circle: false,
  )
  show: thmrules.with(qed-symbol: $square$)
  set math.equation(numbering: none)
  // Длинные выключные формулы сжимаются до ширины строки, а не выезжают за поля.
  show math.equation.where(block: true): it => layout(size => {
    let w = measure(it).width
    if w > size.width { scale(size.width / w * 100%, reflow: true, it) } else { it }
  })
  set heading(numbering: (..n) => {
    let p = n.pos()
    if p.len() == 1 { [Лекция #p.at(0).] } else { numbering("1.1", ..p) }
  })
  show heading: set par(justify: false)
  show heading.where(level: 1): set text(size: 1.5em)
  show figure.where(kind: "scheme"): set figure.caption(position: bottom)
  body
}
