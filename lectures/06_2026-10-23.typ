#import "../template.typ": *
#import "../figures.typ": *

#lecture(6, [23.10.26], [Теорема Лиувилля, пример Хартмана, неблуждающие точки])

== Теорема Лиувилля

#theorem([Лиувилля])[
  Пусть $dot(X) = F(X)$, $F in C^1 (D)$, $F : D -> F(D)$, и для любого $X in D$ выполнено $div F(X) = 0$. Тогда $exists delta > 0$: для всех $abs(t) < delta$ #hl-g[поток] $phi_t$ сохраняет меру $mu$, то есть для любого $mu$-измеримого $E$, $E in D_0 subset D$ ($D_0$ --- открытое ограниченное),
  $ mu(E) = mu(phi_t (E)). $
]

#note[Условие $F in C^1 (D)$ даёт липшицевость $F$.]

Для любого $underline(X) in D$ существует $U(X)$, в которой выполнены условия теоремы о $exists!$ решении З.К. Положим $phi_t := phi(t, X) : bb(R) times D -> D$, $X = phi(t)$. Тогда $phi in C^0 (bb(R) times D)$, и:
+ $phi_0 (X) = X$;
+ $phi_s (phi_t (X)) = phi_(t+s)(X)$;
+ если нет критических точек, то существует $(phi_t)^(-1)$: для любого $t$ это диффеоморфизм $D -> D$.

#proof[
  Мера $mu$ берётся в смысле Лебега: $mu(E) = integral_E 1 dif chi$. Действуя $phi_t$ на $E$ и делая замену $x = phi_t (eta)$,
  $ mu(phi_t (E)) = integral_(phi_t (E)) dif x = integral_E abs(J(t, eta)) dif eta, $
  где $J$ --- якобиан. Покажем, что $dot(J)(t, eta) = J(t, eta) div F(X(t, eta))$.

  По правилу дифференцирования определителя, из
  $ J(t, eta) = mat(delim: "|", partial_(eta_1) X_1 (t, eta), dots.c, partial_(eta_n) X_1 (t, eta); dots.v, , dots.v; partial_(eta_1) X_n (t, eta), dots.c, partial_(eta_n) X_n (t, eta)) $
  получаем
  $ dot(J)(t, eta) = mat(delim: "|", partial^2_(t, eta_1) X_1, dots.c, partial^2_(t, eta_n) X_1; partial_(eta_1) X_2, dots.c, partial_(eta_n) X_2; dots.v, , dots.v; partial_(eta_1) X_n, dots.c, partial_(eta_n) X_n) + dots
    + mat(delim: "|", partial_(eta_1) X_1, dots.c, partial_(eta_n) X_1; dots.v, , dots.v; partial^2_(t, eta_1) X_n, dots.c, partial^2_(t, eta_n) X_n) , $
  где
  $ partial^2_(t, eta_j) X_i (t, eta) = partial_t partial_(eta_j) X_i (t, eta) = partial_(eta_j) F_i (X(t, eta)) = sum_(k=1)^n partial_(x_k) F_i (X(t, eta)) dot partial_(eta_j) X_k (t, eta). $
  Первая строка первого определителя --- линейная комбинация строк якобиана с коэффициентами $partial_(x_k) F_1$:
  $ J_1 (t, eta) = mat(delim: "|", sum_k partial_(x_k) F_1 (X(t, eta)) partial_(eta_1) X_k, dots.c; partial_(eta_1) X_2, dots.c; dots.v, ; partial_(eta_1) X_n, dots.c) (t, eta) = partial_(x_1) F_1 (X(t, eta)) J(t, eta), $
  поскольку остальные слагаемые дают определители с двумя одинаковыми строками. Аналогично $J_i (t, eta) = partial_(x_i) F_i (X(t, eta)) J(t, eta)$. Итого
  $ dot(J)(t, eta) = J(t, eta) [sum_k (partial_(x_k) F_k)(X(t, eta))] = J(t, eta) dot div F(X(t, eta)) = 0. $
  Значит, $J(t, eta) equiv "const" = J(0, eta) = 1$, откуда $mu(phi_t (E)) = mu(E)$.
]

#example([гамильтонова система])[
  $ dot(X)_i = partial_(p_i) H, quad dot(P)_i = -partial_(x_i) H, quad 1 <= i <= n, quad vec(X, P) in bb(R)^(2n), quad H in C^2 (D), thick D subset bb(R)^(2n). $
  Здесь $div F = sum_i (partial^2 H / (partial x_i partial p_i) - partial^2 H / (partial p_i partial x_i)) = 0$, так что фазовый поток сохраняет меру.
]

== Выпрямление траекторий: повторение и пример

Пусть $dot(X) = F(X)$, $F in C^1 (E)$, $E subset bb(R)^n$, $exists a in E : F(a) != 0$, $exists U_a : F != 0$. Тогда существует диффеоморфизм $h : Q -> U_a$, $X = h(y)$, приводящий систему к виду
$ cases(dot(y)_1 = 0, dots.v, dot(y)_(n-1) = 0, dot(y)_n = 1) $
$ h(y_1, dots, y_(n-1), 0) = X(0, y_1, dots, y_(n-1), a_n) = (y_1, dots, y_(n-1), a_n), $
$ h(a_1, dots, a_(n-1), t) = X(t, a_1, dots, a_n), quad h(y) = X(y_n, y_*, a_n). $

#example[
  $ cases(dot(X)_1 = -X_1 + sin X_2, dot(X)_2 = 1) quad a = overline(0), quad exists U_0, thick h : Q^2 -> U_0. $
  Решаем. $X_2 = t + c_2$, $X_2 (0) = 0$ $==>$ $c_2 = 0$, $X_2 = t$. Тогда $dot(X)_1 + X_1 = sin t$. Однородное уравнение $dot(X)_1 + X_1 = 0$: $lambda + 1 = 0$, $lambda = -1$, $X_1^"об" = c_1 e^(-t)$, $X_1 (0) = a_1$.

  Вариация постоянной: $dot(c)_1 (t) e^(-t) - c_1 (t) e^(-t) + c_1 (t) e^(-t) = sin t$, откуда $dot(c)_1 (t) = e^t sin t$ и $c_1 (t) = integral_0^t e^k sin k dif k$. Интегрируя по частям дважды ($u' = e^k$, $v = -cos k$; затем $u' = e^k$, $v = sin k$):
  $ integral_0^t e^k sin k dif k = -e^k cos k |_0^t + integral_0^t e^k cos k dif k = -e^t cos t + 1 + e^k sin k|_0^t - integral_0^t e^k sin k dif k, $
  $ c_1 (t) = (e^t (sin t - cos t) + 1) / 2. $
  Следовательно,
  $ X_1 (t) = 1/2 (sin t - cos t + e^(-t)) + eta_1 e^(-t). $
  Для начального условия $X(0) = (eta_1, 0)^T$:
  $ X(t, eta_1, 0) = vec(1/2 (sin t - cos t + e^(-t)) + eta_1 e^(-t), t), $
  $ h(y_1, y_2) = X(y_2, y_1, 0) = vec(1/2 (sin y_2 - cos y_2 + e^(-y_2)) + y_1 e^(-y_2), y_2). $
]

== Пример сильной неединственности решения задачи Коши (пример Хартмана)

Нужно построить $dot(u) = U(t, u)$, $u(t_0) = u_0$ так, чтобы на любом отрезке $[t_0, t_0 + epsilon]$, $[t_0 - epsilon, t_0]$ существовало $> 1$ решение З.К.

Пусть $S_0$ --- множество решений
$ u = 4p + cos pi t, quad u = 4p + 2 - cos pi t, quad forall t in bb(R), thick p in bb(Z). $
Для $n >= 0$ и $k / 2^n <= t <= (k + 1) / 2^n$ положим $S_n = \{u_(j k)\}$.

#fig(fig-hartman(), cap: [Решения из $S_0$ на $[0, 2]$.])

+ $u_(j k) < u_(j+1, k)$ при всех $k / 2^n <= t <= (k+1) / 2^n$.
+ $u_(j k) = u_i$, $u = u_(j+1, k)$ --- (!) общие конечные точки.
+ Для всех $j, k$ существует $h$: $u_(h, k-1) = u_(h+1, k-1) = u_(j k)$ при $t = k / 2^n$ (и существует $m$: $u_(m, k+1) = u_(m+1, k+1) = u_(j k)$ при $t = (k+1) / 2^n$).
+ Для любых двух дуг из $S_n$ существует общая касательная.
+ Любое $u = u(t)$ на $[a, b]$ из $S_n$ можно продолжить на всё $bb(R)$ добавлением дуг из $S_n$. Такое продолжение неединственно, но оставляет решение в классе $C^1$ и в классе кусочно-$C^2$-функций.

  Дуги $S_(n+1)$ получены из $S_n$ добавлением на каждом отрезке $[k / 2^n, (2k + 1) / 2^(n+1)]$, $[(2k+1) / 2^(n+1), (k + 1) / 2^n]$; эти дуги располагаются между $u = u_(j k)$ и $u = u_(j+1, k)$.

  Пусть $u_(j k) = u(t)$, $u_(j+1, k) = v(t)$, $a = k / 2^n$, $b = (k + 1) / 2^n$ и середина $c = (a + b) / 2$. Тогда $u(a) = v(a)$ ($u$ --- самая нижняя, $v$ --- самая верхняя) $==>$ $dot(u)(a) = dot(v)(a)$.
+ $U_n (t, u)$ на $S_n$, $(t, u) in S_n$: $U_n (t, u)$ равномерно непрерывны, а дуги из п. 5 составляют множество решений $dot(u) = U_n (t, u)$.
+ Для каждого $n$ сначала строится $S_0 subset S_1 subset dots subset S_n$. Каждая $U_(n+1)(t, u)$ определяется как угловой коэффициент дуг $u_n$ и является продолжением построенного на предыдущем шаге.
+ $S = union.big_(k=0)^oo S_k$. Точки $(k / 2^n, u_(j k)(k / 2^n))$ и $((k+1) / 2^n, u_(j k)((k+1) / 2^n))$: дуги всё плотнее прилегают друг к другу. $S$ всюду плотно на плоскости.
+ Цель --- построить уравнение: $exists U(t, u) = lim U_n (t, u)$, $U : S -> bb(R)$, и $exists!$ продолжение $U$ на всю плоскость. Для любого $t_0$ существует $U$ с точками такого вида, что через каждую точку проходит счётное множество кривых, каждая кривая --- решение такого уравнения. (Шагов конечное число.) (Пример Хартмана.)

*Обоснование.*
+ Если функция равномерно непрерывна на всюду плотном подмножестве, её можно продолжить на всё множество.

  Положим $pi^2 = epsilon_0 > epsilon_1 > dots$, $M = sum_(k=0)^oo epsilon_k < oo$, $M_n = sum_(k=0)^n epsilon_k$. Тогда:
  + $abs(dot(u)_(j k)), abs(dot.double(u)_(j k)) <= M_n$;
  + $d_n = sup_(j k t) max{abs(u_(j+1, k) - u_(j k))(t), thick abs(dot(u)_(j+1, k) - dot(u)_(j k))(t)}$ --- $C^1$-норма, чтобы были малы;
  + если $S_(n-1)$ не лежит между $u_(j k)$ и $u_(h k)$, то $abs(dot(u)_(j k) - dot(u)_(h k)) <= d_(n-1) + epsilon_n$.

== Задачи по ДДС

#problem[
  Доказать, что ДДС $f$ на компакте $M$ минимальна $<==>$ не существует собственного инвариантного замкнутого подмножества $M$.
]
#proof[
  Пусть $f in C^0 M$, $M$ --- конечномерный компакт. $f$ минимальна $<==>$ $exists.not overline(S) = S subset.neq M : f(S) subset S$; при этом $f$ минимальна, если $forall x in M : cl(tr x) = M$.

  ($==>$) Пусть $exists S : f(S) subset S$, $S subset.neq M$. Тогда $S = union.big_(x in S) tr x$ и для любого $x in S$: $cl(tr x) = M$. Но $cl(tr x) subset S$, значит, $M subset S$ --- противоречие с $S != M$.

  ($<==$) Пусть $f$ не минимальна: $exists x : cl(tr x) != M$. Положим $S = cl(tr x)$. Это замкнутое множество, $f(S) subset S$, $S != M$, то есть собственное инвариантное замкнутое подмножество.
]

#problem[
  Пусть $f in C^(r_1)$, $g in C^(r_2)$, $f tilde^h g$: $h compose f = g compose h$ ($h$ --- гомеоморфизм). Существует $omega_f (x)$. Верно ли, что $h(omega_f (x)) = omega_g (h(x))$?
]
#proof[
  ($subset$) Для любого $y in omega_f (x)$ существует $n_1 < dots < n_k < dots$: $y = lim_(k -> oo) f^(n_k)(x)$. Так как $f = h^(-1) compose g compose h$, то $lim (h^(-1) compose g^(n_k) compose h)(x) = y$, то есть $((lim g^(n_k)) compose h)(x) = h(y)$ $==>$ $h(y) in omega_g (h(x))$.

  ($supset$) Для любого $z in omega_g (h(x))$ существуют $n_1 < dots < n_k < dots$: $z arrow.l g^(n_k)(h(x))$ $==>$ $h^(-1)(z) in omega_f (x)$; $h$ --- гомеоморфизм, по аналогии.
]

#problem[
  Существует ли отображение, имеющее $omega$-предельным множеством канторово множество?
]
#proof[
  Рассмотрим $E_3 (x) = 3x (mod 1)$. Для любого $x in K subset [0, 1]$:
  $ x = 0 + x_1 / 3 + dots + x_k / 3^k, quad x_i in {0, 2}. $
  Тогда $E_3$ действует как сдвиг: $(0, x_1, dots, x_k) mapsto (x_1, dots, x_k)$.

  Пусть $h : K -> [0, 1]$, $h(x) = (0. x_1/2, x_2/2, dots, x_k/2)$ --- сопоставляет все двоичные дроби. $h$ --- биекция $<==>$ в $h(x)$ нет повторяющихся блоков $0$ и $1$. Обозначим через $bb(Q)_2$ двоично-рациональные числа: $h$ взаимно однозначна в точках, где $h(x) in.not bb(Q)_2$ (то есть двоичная запись $h(x)$ единственна). Поэтому $h|_([0,1] without bb(Q)_2)$ --- биекция.

  Возьмём всюду плотное $S subset [0, 1] without bb(Q)_2$ #sym.arrow.r.double $h compose E_3 = E_2 compose h$, то есть $(E_2, E_3)$ _полусопряжены_ через $h$ ($h$ не биективна). $cl(h^(-1)(cal(D))) = K$, и $exists x^* in [0, 1]^*$: $cl(tr_(E_3) x^*) = K$.
]

== Неблуждающее множество и его свойства

#definition([неблуждающая точка])[
  Пусть $f in C^0 M$, $M$ --- конечномерный компакт. Точка $x in M$ _неблуждающая_, если $forall U(x)$ $exists m in bb(N) : U(x) inter f^m (U(x)) != emptyset$. Обозначение: $Omega_f$ --- множество неблуждающих точек.
]
#definition([блуждающая точка])[
  $x$ _блуждающая_, если $exists U(x)$ $forall m in bb(N) : U(x) inter f^m (U(x)) = emptyset$. Обозначение: $W_f = M without Omega_f$.
]

#problem[
  $h(Omega_f) = Omega_g$, то есть $x in Omega_f <==> h(x) in Omega_g$ ($h$ --- гомеоморфизм).
]
#proof[
  Пусть $x$ --- такая, что $forall U(x)$ $exists m in bb(N): U(x) inter f^m (U(x)) != emptyset$; $h compose f = g compose h$, $f = h^(-1) g h$. Для любого $y in h(Omega_f)$ существует $x$: $U(y) = h(U(x))$, и существует $m in bb(N)$:
  $ h(U(x)) inter h compose f^m (U(x)) != emptyset, $
  где $h compose f^m (U(x)) = g^m compose h (U(x)) = g^m (U(y))$. Значит, $U(y) inter g^m (U(y)) != emptyset$, и по определению $y in Omega_g$.
]

#problem[
  $x in Omega_f <==> exists \{x_k\}_(k >= 1) -> x$ и $\{n_k\}_(k >= 1) arrow.t oo$: $f^(n_k)(x_k) -> x$.
]
#proof[
  ($<==$) Пусть $U(x)$ --- окрестность. Существуют $k_0$ и $p_0$ такие, что при $k > k_0$ выполнено $x_k in U(x)$, а при $k > p_0$ выполнено $f^(n_k)(x_k) in U(x)$. Возьмём $s = max{k_0, p_0} + 1$: тогда $x_s in U(x)$ и $f^(n_s)(x_s) in U(x)$, то есть $U(x) inter f^(n_s)(U(x)) != emptyset$.

  ($==>$) Пусть $U_k = B_(1\/k)(x)$. Для $epsilon_k -> 0$ найдётся $n_k$: $U_(epsilon_k)(x) inter f^(n_k)(U_(epsilon_k)) != emptyset$. Значит, существует $overline(x)_k in U_(epsilon_k)$ с $f^(n_k)(overline(x)_k) in U_(epsilon_k)$. Тогда $overline(x)_k -> x$ и $f^(n_k)(overline(x)_k) -> x$.
]
