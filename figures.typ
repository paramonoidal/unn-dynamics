// Рисунки к конспектам (cetz). Эскизы воспроизводят рукописные картинки.
#import "@preview/cetz:0.3.4"

#let ink = luma(40)
#let red = rgb("#d03a3a")
#let green = rgb("#3a9a4a")
#let purple = rgb("#7a4ac0")
#let orange = rgb("#e08a20")
#let blue = rgb("#3a6ad0")

#let sample(f, a, b, n: 80) = range(n + 1).map(i => {
  let x = a + (b - a) * i / n
  (x, f(x))
})

#let axes(x0, x1, y0, y1, xl: $x$, yl: none) = {
  import cetz.draw: *
  line((x0, 0), (x1, 0), mark: (end: ">", fill: ink), stroke: 0.6pt + ink)
  line((0, y0), (0, y1), mark: (end: ">", fill: ink), stroke: 0.6pt + ink)
  if xl != none { content((x1, 0), xl, anchor: "north-west", padding: 2pt) }
  if yl != none { content((0, y1), yl, anchor: "south-east", padding: 2pt) }
}

#let fig-frac-part() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  axes(-1.4, 3.4, -0.4, 1.5)
  for k in (-1, 0, 1, 2) {
    line((k, 0), (k + 1, 1), stroke: 1pt + blue)
    circle((k, 0), radius: 0.06, fill: blue, stroke: blue)
    circle((k + 1, 1), radius: 0.06, fill: white, stroke: blue)
  }
  for k in (1, 2, 3) { line((k, 0), (k, 0.1), stroke: 0.5pt) }
  content((1, 0), [$1$], anchor: "north", padding: 3pt)
  content((0, 1), [$1$], anchor: "east", padding: 3pt)
})

#let fig-sqrt() = cetz.canvas(length: 3.2cm, {
  import cetz.draw: *
  axes(-0.1, 1.25, -0.1, 1.2)
  line(..sample(x => calc.sqrt(x), 0, 1, n: 60), stroke: 1pt + blue)
  line((1, 0), (1, 1), stroke: (dash: "dotted", thickness: 0.5pt))
  line((0, 1), (1, 1), stroke: (dash: "dotted", thickness: 0.5pt))
  content((0, 1), [$1$], anchor: "east", padding: 3pt)
  content((1, 0), [$1$], anchor: "north", padding: 3pt)
  content((0, 0), [$0$], anchor: "north-east", padding: 3pt)
})

#let fig-flow-traj() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  merge-path(close: true, stroke: 0.8pt + ink, fill: luma(245), {
    bezier((0, 0), (7, 0.4), (2, -0.6), (5, 1.0))
    bezier((7, 0.4), (6, 3.6), (8, 1.8), (7, 3.0))
    bezier((6, 3.6), (0, 2.6), (4, 4.2), (1.5, 3.2))
    bezier((0, 2.6), (0, 0), (-0.8, 1.8), (-0.6, 0.8))
  })
  content((-0.3, 3.1), [$R$])
  let p0 = (1.2, 0.9)
  let p1 = (3.4, 2.0)
  let p2 = (5.6, 1.4)
  bezier(p0, p1, (1.8, 1.8), (2.6, 2.3), stroke: 1pt + blue)
  bezier(p1, p2, (4.2, 1.8), (4.9, 2.0), stroke: 1pt + blue)
  circle(p0, radius: 0.08, fill: ink)
  circle(p1, radius: 0.08, fill: ink)
  circle(p2, radius: 0.08, fill: ink)
  content(p0, $(X_0, t_0)$, anchor: "north", padding: 6pt)
  content(p1, $(X_1, t_1)$, anchor: "south", padding: 6pt)
  content(p2, $(X_2, t_2)$, anchor: "north", padding: 6pt)
})

#let fig-poincare() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  // поверхность S
  line((0, 0), (5, 0.6), (6.4, 3.0), (1.4, 2.4), close: true, fill: luma(240), stroke: 0.8pt + ink)
  content((0.2, 1.4), [$S$])
  let pts = ((1.2, 1.0), (2.8, 1.3), (4.2, 1.7), (3.4, 2.0))
  for i in range(3) {
    let p = pts.at(i)
    let q = pts.at(i + 1)
    bezier(p, q, (p.at(0) + 0.3, p.at(1) - 2.0), (q.at(0) - 0.3, q.at(1) + 2.2), stroke: (paint: blue, dash: "dashed", thickness: 0.7pt))
  }
  for p in pts { circle(p, radius: 0.09, fill: blue, stroke: blue) }
})

#let fig-lamerey() = cetz.canvas(length: 3cm, {
  import cetz.draw: *
  axes(-0.1, 1.2, -0.1, 1.15)
  line((0, 0), (1.05, 1.05), stroke: (dash: "dotted", thickness: 0.6pt))
  line(..sample(x => calc.sqrt(x) * 0.95 + 0.0, 0, 1, n: 60), stroke: 1pt + ink)
})

#let fig-baire-boxes() = {
  let b(body) = box(width: 100%, inset: 6pt, stroke: (dash: "dotted", thickness: 0.7pt), body)
  grid(
    columns: (1fr, 1fr, 1fr, 1.5fr, 1.5fr), gutter: 5pt, align: center + horizon,
    b[Нигде не плотные],
    b[Всюду плотные],
    b[Граничные],
    b[Кат. Бэра 1: \ $union.big_(bb(N)) A_n$ --- нигде не плотные],
    b[#strike[Кат. Бэра 2] $arrow.b$ \ массивные: \ $inter.big_(bb(N)) O_n$ --- всюду плотные],
  )
}

#let tri-sierp(p, q, r, d) = {
  import cetz.draw: *
  if d == 0 { return }
  let mid(a, b) = ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2)
  let pq = mid(p, q)
  let qr = mid(q, r)
  let rp = mid(r, p)
  line(pq, qr, rp, close: true, stroke: 0.4pt + ink)
  tri-sierp(p, pq, rp, d - 1)
  tri-sierp(pq, q, qr, d - 1)
  tri-sierp(rp, qr, r, d - 1)
}

#let fig-sierpinski-triangle() = cetz.canvas(length: 4.2cm, {
  import cetz.draw: *
  line((0, 0), (1, 0), (0.5, 0.866), close: true, stroke: 1pt + ink)
  tri-sierp((0, 0), (1, 0), (0.5, 0.866), 4)
})

#let carpet(x, y, s, d) = {
  import cetz.draw: *
  if d == 0 { return }
  let t = s / 3
  rect((x + t, y + t), (x + 2 * t, y + 2 * t), fill: white, stroke: 0.4pt + ink)
  for i in range(3) {
    for j in range(3) {
      if not (i == 1 and j == 1) { carpet(x + i * t, y + j * t, t, d - 1) }
    }
  }
}

#let fig-sierpinski-carpet() = cetz.canvas(length: 4cm, {
  import cetz.draw: *
  rect((0, 0), (1, 1), fill: luma(225), stroke: 1pt + ink)
  carpet(0, 0, 1, 3)
})

#let fig-antoine() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let n = 12
  let cols = (red, orange, green, blue, purple, rgb("#d0409a"))
  for i in range(n) {
    let a = 360deg * i / n
    group({
      translate((2.1 * calc.cos(a), 1.3 * calc.sin(a)))
      rotate(a + 90deg)
      circle((0, 0), radius: (0.75, 0.38), stroke: 1.6pt + cols.at(calc.rem(i, cols.len())))
    })
  }
})

#let diagram-conj() = grid(
  columns: (auto, auto, auto), gutter: 0.8em, align: center + horizon,
  $M_f$, $limits(-->)^f$, $M_f$,
  $arrow.b phi$, [], $arrow.b phi$,
  $M_g$, $limits(-->)_g$, $M_g$,
)

#let pw(n) = range(calc.pow(2, n) + 1).map(j => (j / calc.pow(2, n), calc.rem(j, 2)))

#let fig-tent-iter() = cetz.canvas(length: 5cm, {
  import cetz.draw: *
  axes(-0.05, 1.12, -0.05, 1.1)
  line((0, 0), (1, 1), stroke: 0.7pt + ink)
  line(..pw(1), stroke: 1pt + red)
  line(..pw(2), stroke: 1pt + green)
  line(..pw(3), stroke: 1pt + purple)
  for p in ((2 / 5, 2 / 5), (4 / 5, 4 / 5)) {
    line((p.at(0) - 0.02, p.at(1) - 0.02), (p.at(0) + 0.02, p.at(1) + 0.02), stroke: 1.2pt + orange)
    line((p.at(0) - 0.02, p.at(1) + 0.02), (p.at(0) + 0.02, p.at(1) - 0.02), stroke: 1.2pt + orange)
  }
  content((0, 1), [$1$], anchor: "east", padding: 3pt)
  content((0, 0.5), [$1\/2$], anchor: "east", padding: 3pt)
  content((0.5, 0), [$1\/2$], anchor: "north", padding: 3pt)
  content((1, 0), [$1$], anchor: "north", padding: 3pt)
  content((0, 0), [$0$], anchor: "north-east", padding: 3pt)
})

#let fig-logistic-iter() = cetz.canvas(length: 5cm, {
  import cetz.draw: *
  axes(-0.05, 1.12, -0.05, 1.1)
  line((0, 0), (1, 1), stroke: (dash: "dotted", thickness: 0.6pt))
  line(..sample(x => 4 * x * (1 - x), 0, 1), stroke: 1pt + red)
  line(..sample(x => 16 * x * (1 - x) * calc.pow(2 * x - 1, 2), 0, 1, n: 160), stroke: 1pt + green)
  content((0, 1), [$1$], anchor: "east", padding: 3pt)
  content((0.5, 0), [$1\/2$], anchor: "north", padding: 3pt)
  content((1, 0), [$1$], anchor: "north", padding: 3pt)
  content((0, 0), [$0$], anchor: "north-east", padding: 3pt)
})

#let fig-circle() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  line((-2.6, 0), (2.6, 0), mark: (end: ">", fill: ink), stroke: 0.6pt + ink)
  line((0, -2.2), (0, 2.2), mark: (end: ">", fill: ink), stroke: 0.6pt + ink)
  circle((0, 0), radius: 1.5, stroke: (dash: "dashed", paint: orange, thickness: 1pt))
})

// Пример Хартмана (методичка, рис. 1): жирные кривые --- дуги S_0 (u = 4i + cos πt, u = 4i + 2 - cos πt),
// светлые --- дуги, добавленные в S_1 при m_0 = 3:
// u_i = u + (v - u) i/m на [a, b] и v_i = u_i sin^2 π(t - c) + u_(i+1) cos^2 π(t - c) на [c, b]
// (если u(a) = v(a); если u(b) = v(b) --- зеркально, на [a, c]).
#let fig-hartman() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let sx = 2.0            // масштаб по t
  let (t0, t1, u0, u1) = (-1.25, 2.6, -3.3, 3.6)
  let P(t, u) = (sx * t, u)
  // рисуем только куски кривой внутри полосы u0 <= u <= u1
  let pl(pts, st) = {
    let seg = ()
    for p in pts + ((0, u1 + 99),) {
      if p.at(1) >= u0 and p.at(1) <= u1 { seg.push(p) } else {
        if seg.len() >= 2 { line(..seg, stroke: st) }
        seg = ()
      }
    }
  }
  let curve(f, a, b, n: 60) = range(n + 1).map(i => { let t = a + (b - a) * i / n; P(t, f(t)) })
  let pi = calc.pi
  // оси
  line(P(t0, 0), P(t1, 0), mark: (end: ">", fill: ink), stroke: 0.6pt + ink)
  line(P(0, u0), P(0, u1 + 0.2), mark: (end: ">", fill: ink), stroke: 0.6pt + ink)
  content(P(t1, 0), $t$, anchor: "north-west", padding: 2pt)
  content(P(0, u1 + 0.2), $u$, anchor: "south-east", padding: 2pt)
  for t in (-1, 1, 2) { content(P(t, 0), text(size: 0.75em)[$#t$], anchor: "north-west", padding: 2pt) }
  content(P(0.5, 0), text(size: 0.75em)[$1/2$], anchor: "north-west", padding: 2pt)
  for u in (-2, 2) { content(P(0, u), text(size: 0.75em)[$#u$], anchor: "east", padding: 2pt) }
  // S_0
  let fs = ()
  for i in (-2, -1, 0, 1) {
    fs.push(t => 4 * i + calc.cos(pi * t))
    fs.push(t => 4 * i + 2 - calc.cos(pi * t))
  }
  let m = 3
  let light = 0.7pt + luma(150)
  for k in (-2, -1, 0, 1, 2) {
    let (a, b) = (k, k + 1)
    let c = a + 0.5
    let mid = a + 0.5
    let srt = fs.sorted(key: f => f(mid))
    for q in range(srt.len() - 1) {
      let (u, v) = (srt.at(q), srt.at(q + 1))
      let ui(i) = t => u(t) + (v(t) - u(t)) * i / m
      let A = calc.abs(u(a) - v(a)) < 1e-6
      let (ta, tb) = (calc.max(a, t0), calc.min(b, t1))
      for i in range(1, m) { pl(curve(ui(i), ta, tb), light) }
      for i in range(m) {
        let vi = if A {
          t => ui(i)(t) * calc.pow(calc.sin(pi * (t - c)), 2) + ui(i + 1)(t) * calc.pow(calc.cos(pi * (t - c)), 2)
        } else {
          t => ui(i)(t) * calc.pow(calc.sin(pi * (c - t)), 2) + ui(i + 1)(t) * calc.pow(calc.cos(pi * (c - t)), 2)
        }
        let (va, vb) = if A { (calc.max(c, t0), tb) } else { (ta, calc.min(c, t1)) }
        if va < vb { pl(curve(vi, va, vb, n: 40), light) }
      }
    }
  }
  for f in fs { pl(curve(f, t0, t1, n: 200), 1.4pt + ink) }
  // подписи на [0, 1]: u = u_0 = cos πt, v = u_3 = 2 - cos πt
  content(P(1, 3), text(size: 0.75em, fill: blue)[$v$], anchor: "south", padding: 3pt)
  content(P(1, -1), text(size: 0.75em, fill: blue)[$u$], anchor: "north", padding: 3pt)
  content(P(0, 1), text(size: 0.75em, fill: blue)[$a$], anchor: "south-east", padding: 3pt)
  line(P(0.5, u0), P(0.5, u1), stroke: (paint: luma(170), thickness: 0.4pt, dash: "dotted"))
})

// H(x) = lim F^n(x) / 2^n для F(x) = 2x + sin(2 pi x) / (4 pi) (пример Шуба)
#let fig-shub-h() = cetz.canvas(length: 5cm, {
  import cetz.draw: *
  axes(-0.05, 1.12, -0.05, 1.1)
  line((0, 0), (1, 1), stroke: (dash: "dotted", thickness: 0.6pt))
  line((0.0000, 0.0000), (0.0100, 0.0242), (0.0200, 0.0414), (0.0300, 0.0550), (0.0400, 0.0720), (0.0500, 0.0829), (0.0600, 0.0931), (0.0700, 0.1043), (0.0800, 0.1158), (0.0900, 0.1332), (0.1000, 0.1442), (0.1100, 0.1525), (0.1200, 0.1624), (0.1300, 0.1692), (0.1400, 0.1772), (0.1500, 0.1875), (0.1600, 0.1979), (0.1700, 0.2061), (0.1800, 0.2134), (0.1900, 0.2240), (0.2000, 0.2332), (0.2100, 0.2468), (0.2200, 0.2629), (0.2300, 0.2728), (0.2400, 0.2832), (0.2500, 0.2908), (0.2600, 0.2977), (0.2700, 0.3042), (0.2800, 0.3144), (0.2900, 0.3223), (0.3000, 0.3287), (0.3100, 0.3339), (0.3200, 0.3395), (0.3300, 0.3478), (0.3400, 0.3539), (0.3500, 0.3610), (0.3600, 0.3694), (0.3700, 0.3819), (0.3800, 0.3903), (0.3900, 0.3972), (0.4000, 0.4040), (0.4100, 0.4123), (0.4200, 0.4182), (0.4300, 0.4253), (0.4400, 0.4329), (0.4500, 0.4447), (0.4600, 0.4532), (0.4700, 0.4613), (0.4800, 0.4725), (0.4900, 0.4829), (0.5000, 0.5000), (0.5100, 0.5171), (0.5200, 0.5275), (0.5300, 0.5387), (0.5400, 0.5468), (0.5500, 0.5553), (0.5600, 0.5671), (0.5700, 0.5747), (0.5800, 0.5818), (0.5900, 0.5877), (0.6000, 0.5960), (0.6100, 0.6028), (0.6200, 0.6097), (0.6300, 0.6181), (0.6400, 0.6306), (0.6500, 0.6390), (0.6600, 0.6461), (0.6700, 0.6522), (0.6800, 0.6605), (0.6900, 0.6661), (0.7000, 0.6713), (0.7100, 0.6777), (0.7200, 0.6856), (0.7300, 0.6958), (0.7400, 0.7023), (0.7500, 0.7092), (0.7600, 0.7168), (0.7700, 0.7272), (0.7800, 0.7371), (0.7900, 0.7532), (0.8000, 0.7668), (0.8100, 0.7760), (0.8200, 0.7866), (0.8300, 0.7939), (0.8400, 0.8021), (0.8500, 0.8125), (0.8600, 0.8228), (0.8700, 0.8308), (0.8800, 0.8376), (0.8900, 0.8475), (0.9000, 0.8558), (0.9100, 0.8668), (0.9200, 0.8842), (0.9300, 0.8957), (0.9400, 0.9069), (0.9500, 0.9171), (0.9600, 0.9280), (0.9700, 0.9450), (0.9800, 0.9586), (0.9900, 0.9758), (1.0000, 1.0000), stroke: 1pt + blue)
  content((0, 1), [$1$], anchor: "east", padding: 3pt)
  content((1, 0), [$1$], anchor: "north", padding: 3pt)
  content((0, 0), [$0$], anchor: "north-east", padding: 3pt)
})

// ───────── лекция 7 (30.10.26) ─────────

// Лист Декарта x^3 + 3xy - y^3 = 0 (линия уровня C = 0 из задачи 7.1).
// Параметризация y = kx: x = -3k/(1-k^3), y = -3k^2/(1-k^3).
#let folium-pts(k0, k1, n: 160, R: 2.6) = range(n + 1).map(i => {
  let k = k0 + (k1 - k0) * i / n
  let d = 1 - k * k * k
  (-3 * k / d, -3 * k * k / d)
}).filter(p => calc.abs(p.at(0)) <= R and calc.abs(p.at(1)) <= R)

#let fig-folium() = cetz.canvas(length: 1.1cm, {
  import cetz.draw: *
  axes(-2.7, 2.9, -2.7, 2.9, yl: $y$)
  // парабола x = y^2, на которой правая часть y' = -(x^2+y)/(x-y^2) не определена
  line(..range(81).map(i => { let y = -1.6 + 3.2 * i / 80; (y * y, y) }), stroke: (paint: luma(150), dash: "dashed", thickness: 0.6pt))
  content((2.56, 1.6), text(fill: luma(110), size: 0.8em)[$x = y^2$], anchor: "west", padding: 2pt)
  // ветвь x = psi(y) (вертикальная касательная в 0)
  line(..folium-pts(-60, -1.2), stroke: 1pt + blue)
  line(..folium-pts(-1.2, -0.45), stroke: 1pt + blue)
  line(..folium-pts(1.15, 60), stroke: 1pt + blue)
  line(..folium-pts(0.45, 0.93), stroke: 1pt + blue)
  // ветвь y = phi(x): решение задачи Коши y(0) = 0
  line(..folium-pts(-0.45, 0.45, n: 120), stroke: 1.6pt + red)
  circle((0, 0), radius: 0.06, fill: ink, stroke: ink)
  circle((1, -1), radius: 0.06, fill: white, stroke: ink)
  content((1, -1), text(size: 0.8em)[$(1, -1)$], anchor: "east", padding: 4pt)
  content((-1.3, 0.1), text(fill: red, size: 0.85em)[$y = phi(x)$], anchor: "south")
})

// Траектории dot(x)_1 = 2x_1 - x_2, dot(x)_2 = x_1 + 2x_2 (раскручивающийся фокус)
// и выпрямляющие координаты: y_2 = const --- лучи, y_1 = const --- спирали.
#let fig-focus() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  axes(-2.6, 2.8, -2.4, 2.6, xl: $x_1$, yl: $x_2$)
  for th in range(6) {
    let a = th * calc.pi / 3
    line(..range(121).map(i => {
      let t = -3.2 + 3.6 * i / 120
      let r = 0.9 * calc.exp(2 * t / 6.0 * 1.0)
      (r * calc.cos(t + a), r * calc.sin(t + a))
    }).filter(p => calc.abs(p.at(0)) <= 2.5 and calc.abs(p.at(1)) <= 2.3), stroke: 0.8pt + blue)
  }
  circle((1, 0), radius: 0.06, fill: red, stroke: red)
  content((1, 0), text(fill: red, size: 0.85em)[$a = (1, 0)$], anchor: "north-west", padding: 3pt)
  line((-2.5, 0), (0, 0), stroke: (paint: orange, thickness: 1.4pt, dash: "dashed"))
  content((-1.8, 0), text(fill: orange, size: 0.8em)[разрез], anchor: "south", padding: 3pt)
})

// ───────── лекция 7 (27.10.26) ─────────

// Три типа траекторий потока: покой, цикл, неособая траектория.
#let fig-traj-types() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  // покой
  circle((0, 0), radius: 0.08, fill: blue, stroke: blue)
  content((0, -1.5), text(size: 0.85em)[покой: точка])
  // цикл
  let cyc = range(73).map(i => {
    let a = i * 5 * calc.pi / 180
    (3.4 + 1.2 * calc.cos(a) + 0.15 * calc.cos(2 * a), 1.0 * calc.sin(a))
  })
  line(..cyc, stroke: 1pt + blue, close: true)
  line((3.4 + 1.35, -0.05), (3.4 + 1.35, 0.1), mark: (end: ">", fill: blue), stroke: 1pt + blue)
  content((3.4, -1.5), text(size: 0.85em)[период $tau$: окружность])
  // неособая
  let pts = range(101).map(i => {
    let s = -1 + 2 * i / 100
    (7.6 + 1.5 * s, 0.6 * calc.sin(3.2 * s) + 0.25 * s)
  })
  line(..pts, stroke: 1pt + blue)
  line(pts.at(49), pts.at(52), mark: (end: ">", fill: blue), stroke: 1pt + blue)
  content((7.6, -1.5), text(size: 0.85em)[неособая: образ прямой])
})

// «Картинка центра»: в любой окрестности точки покоя лежат целые замкнутые траектории.
#let fig-center() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  for r in (0.45, 0.9, 1.35, 1.8) {
    circle((0, 0), radius: (r * 1.25, r), stroke: 0.8pt + blue)
    line((r * 1.25, -0.05), (r * 1.25, 0.08), mark: (end: ">", fill: blue), stroke: 0.8pt + blue)
  }
  circle((0, 0), radius: 0.06, fill: ink, stroke: ink)
  content((0, 0), [$x$], anchor: "north-east", padding: 2pt)
  circle((0, 0), radius: 0.75, stroke: (paint: red, dash: "dashed", thickness: 0.8pt))
  content((0.55, 0.55), text(fill: red, size: 0.85em)[$U_epsilon (x)$], anchor: "south-west", padding: 2pt)
})

// Теорема Биркгофа: вне U(Omega) лежит лишь конечное число «уходящих от себя» окрестностей V_i;
// каждую из них траектория посещает не более одного раза.
#let fig-birkhoff() = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  rect((-0.4, -0.4), (8.4, 3.6), stroke: 0.6pt + ink, fill: luma(248))
  content((8.2, 3.4), [$M$], anchor: "north-east")
  // неблуждающее множество и его окрестность
  circle((6.4, 1.6), radius: (1.0, 0.6), fill: rgb("#d8e4f8"), stroke: 0.8pt + blue)
  content((6.4, 1.6), text(fill: blue)[$Omega(f)$])
  circle((6.4, 1.6), radius: (1.6, 1.15), stroke: (paint: blue, dash: "dashed", thickness: 0.8pt))
  content((6.4, 2.75), text(fill: blue, size: 0.85em)[$U$], anchor: "south", padding: 2pt)
  // окрестности V_i
  let vs = ((0.6, 2.7), (1.6, 0.6), (2.4, 2.4), (3.4, 1.0), (3.9, 2.9))
  for (i, c) in vs.enumerate() {
    circle(c, radius: 0.5, stroke: 0.7pt + orange, fill: orange.lighten(85%))
    content((c.at(0) + 0.42, c.at(1) + 0.42), text(fill: orange, size: 0.75em)[$V_#i$])
  }
  // траектория: по одному визиту в некоторые V_i, затем в U
  let orb = ((0.5, 2.6), (1.7, 0.7), (3.3, 1.1), (2.5, 2.3), (5.4, 1.2), (6.9, 2.1), (5.9, 1.0))
  for k in range(orb.len() - 1) {
    line(orb.at(k), orb.at(k + 1), stroke: (paint: luma(90), thickness: 0.5pt, dash: "dotted"), mark: (end: ">", fill: luma(90), scale: 0.6))
  }
  for p in orb { circle(p, radius: 0.06, fill: ink, stroke: ink) }
  content(orb.at(0), text(size: 0.8em)[$x$], anchor: "east", padding: 4pt)
})

// Поднятие сохраняющего ориентацию гомеоморфизма окружности: F(t) = t + 0.3 + 0.1 sin(2 pi t).
#let fig-lift() = cetz.canvas(length: 1.6cm, {
  import cetz.draw: *
  let F(t) = t + 0.3 + 0.1 * calc.sin(2 * calc.pi * t)
  axes(-0.3, 2.4, -0.3, 2.6, xl: $t$, yl: none)
  line((-0.2, -0.2), (2.2, 2.2), stroke: (dash: "dotted", thickness: 0.6pt))
  line(..sample(F, -0.2, 2.15, n: 120), stroke: 1pt + blue)
  line(..sample(t => F(t) + 1, -0.2, 1.15, n: 80), stroke: (paint: orange, thickness: 0.8pt, dash: "dashed"))
  for k in (1, 2) {
    line((k, -0.05), (k, 0.05), stroke: 0.5pt)
    content((k, 0), [$#k$], anchor: "north", padding: 3pt)
    line((-0.05, k), (0.05, k), stroke: 0.5pt)
    content((0, k), [$#k$], anchor: "east", padding: 3pt)
  }
  content((2.15, F(2.15)), text(fill: blue, size: 0.85em)[$F$], anchor: "west", padding: 3pt)
  content((1.15, F(1.15) + 1), text(fill: orange, size: 0.85em)[$F + 1$], anchor: "west", padding: 3pt)
  content((2.2, 2.2), text(size: 0.8em)[$y = t$], anchor: "south-west", padding: 2pt)
})
