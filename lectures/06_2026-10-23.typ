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

*Цель:* построить функцию $U(t, u)$, непрерывную на всей плоскости $(t, u)$, такую, что для _каждой_ начальной точки $(t_0, u_0)$ задача Коши
$ dot(u) = U(t, u), quad u(t_0) = u_0 quad (23) $
имеет более одного решения на каждом отрезке $[t_0, t_0 + epsilon]$ и $[t_0 - epsilon, t_0]$ при любом $epsilon > 0$.

*Начальный набор дуг.* Пусть $S_0$ --- совокупность линий
$ u = 4p + cos pi t, quad u = 4p + 2 - cos pi t, quad t in bb(R), thick p in bb(Z), $
разбитых на дуги над отрезками $[k, k+1]$, $k in bb(Z)$. Соседние линии касаются друг друга в точках $t = k$: например, $cos pi t$ и $2 - cos pi t$ касаются в точке $(0, 1)$, а $cos pi t$ и $-2 - cos pi t$ --- в точке $(1, -1)$.

*Схема построения.* Для каждого $n >= 0$ строится множество $S_n$ дважды непрерывно дифференцируемых дуг
$ u = u_(j k)(t), quad k / 2^n <= t <= (k + 1) / 2^n, quad j, k in bb(Z), $
со свойствами:
+ $u_(j k)(t) < u_(j+1, k)(t)$ при $k / 2^n < t < (k + 1) / 2^n$ (дуги над одним отрезком упорядочены);
+ дуги $u_(j k)$ и $u_(j+1, k)$ имеют _ровно одну_ общую концевую точку;
+ для каждой пары $j, k$ есть индекс $h$ с $u_(h, k-1) = u_(h+1, k-1) = u_(j k)$ при $t = k / 2^n$ и индекс $i$ с $u_(i, k+1) = u_(i+1, k+1) = u_(j k)$ при $t = (k + 1) / 2^n$ (из каждого конца дуги можно продолжить путь по соседнему отрезку двумя способами);
+ любые две дуги из $S_n$ с общей точкой имеют в ней общую касательную;
+ поэтому любую непрерывную дугу $u = u(t)$ на $[a, b]$, составленную из дуг $S_n$, можно продолжить, добавляя дуги из $S_n$, на всю ось $-oo < t < +oo$, причём _не единственным образом_, оставаясь в классе $C^1$ (и кусочно в $C^2$);
+ если $U_n (t, u)$ на $S_n$ --- угловой коэффициент касательной к дуге в точке $(t, u)$, то $U_n$ равномерно непрерывна на $S_n$, а кривые из п. 5 --- решения уравнения $dot(u) = U_n (t, u)$;
+ $S_0 subset S_1 subset dots subset S_n subset dots$, так что $U_(n+1)$ --- продолжение $U_n$;
+ множество концевых точек $(k / 2^n, u_(j k)(k / 2^n))$ всех $S_n$ всюду плотно на плоскости, и $S = union.big_n S_n$ тоже всюду плотно;
+ функция $U(t, u) = lim U_n (t, u)$ на $S$ равномерно непрерывна и потому имеет единственное непрерывное продолжение на всю плоскость. Это и есть искомое уравнение.

#fig(fig-hartman(), cap: [Методичка, рис. 1. Жирные кривые --- дуги $S_0$, светлые --- дуги, добавленные в $S_1$ при $m_0 = 3$. На $[a, b] = [0, 1]$ между $u = cos pi t$ и $v = 2 - cos pi t$ (они касаются в точке $a$) вписаны $u_1, u_2$ на всём $[0, 1]$ и три дуги $v_0, v_1, v_2$ на $[c, b] = [1\/2, 1]$; на отрезках, где пара касается в правом конце, картина зеркальная. Дуги $S_0$ и $S_1$ делят плоскость на множества $G$.])

*Обоснование.* Возьмём $pi^2 = epsilon_0 > epsilon_1 > dots$ с $M = sum_(k=0)^oo epsilon_k < oo$, $M_n = sum_(k=0)^n epsilon_k$. Предположим, что $S_n$ построено и
+ $abs(dot(u)_(j k)), abs(dot.double(u)_(j k)) <= M_n$; #h(1fr) $(30)$
+ $d_n = sup_(j, k, t) max{abs(u_(j+1, k) - u_(j k)), thick abs(dot(u)_(j+1, k) - dot(u)_(j k))} <= epsilon_n$ --- соседние дуги близки в $C^1$-норме; #h(1fr) $(32)$
+ если $n > 0$ и между $u_(i k)$ и $u_(h k)$ нет дуг из $S_(n-1)$, то $abs(dot(u)_(i k) - dot(u)_(h k)) <= d_(n-1) + epsilon_n$. #h(1fr) $(33)$

_Переход $S_n -> S_(n+1)$._ Пусть $u = u_(j k)$, $v = u_(j+1, k)$, $a = k / 2^n$, $b = (k+1) / 2^n$, $c = (a + b) / 2$, и (для определённости) $u(a) = v(a)$, $dot(u)(a) = dot(v)(a)$. При целом $m = m_n > 0$ положим
$ u_i (t) = u(t) + i / m (v(t) - u(t)), quad i = 0, 1, dots, m, quad t in [a, b], $
так что $u_0 = u$, $u_m = v$, все $u_i$ выходят из одной точки $a$ с общей касательной, и $abs(u_h - u_i), abs(dot(u)_h - dot(u)_i) <= abs(h - i) d_n \/ m$. Чтобы получить свойство 2 (у соседних дуг одна общая концевая точка), на $[c, b]$ добавляются «переходные» дуги
$ v_i (t) = u_i (t) sin^2 2^n pi (t - c) + u_(i+1)(t) cos^2 2^n pi (t - c), quad i = 0, dots, m - 1. $
Тогда $u_i < v_i < u_(i+1)$ на $(c, b)$, $v_i = u_(i+1)$ и $dot(v)_i = dot(u)_(i+1)$ при $t = c$, $v_i = u_i$ и $dot(v)_i = dot(u)_i$ при $t = b$ (производная члена с $sin^2$ содержит множитель $sin 2^(n+1) pi (t - c)$, равный нулю в $c$ и в $b$). Множество $S_(n+1)$ --- это дуги $S_n$ плюс дуги $u_i$ на $[a, c]$, $[c, b]$ и $v_i$ на $[c, b]$. Выбрав $m_n$ столь большим, что $(2^(n+2) + 2^(2n+3) pi) pi d_n \/ m < epsilon_(n+1) \/ 3$, получаем $(30)$--$(33)$ с $n + 1$ вместо $n$. Отрезки $[a, b]$ имеют длину $2^(-n) -> 0$, а расстояние между соседними дугами $<= epsilon_n -> 0$, поэтому $S$ всюду плотно.

_Непрерывность $U$._ Дуги $S_n$ делят плоскость на замкнутые «линзы» $G = {gamma <= t <= delta, thick u^n (t) <= u <= v^n (t)}$, $delta - gamma = 2 \/ 2^n$, на которых граничные дуги сходятся в концах. Внутри $G$ значения $U_p$, $p >= n$, отличаются от значений на границе не больше чем на $eta_n = 4M \/ 2^n + 2 sum_(j >= n) epsilon_j -> 0$ (из $(30)$ и $(33)$). Отсюда $U$ равномерно непрерывна на $S$ и продолжается на плоскость.

_Неединственность._ Любая непрерывная кривая из дуг $S$ --- решение $(23)$. Если $(t_0, u_0)$ лежит в линзе $G$, то по теореме о продолжении решение доходит до общей концевой точки границы $G$ при $t = delta$ (или $t = gamma$), а оттуда продолжается по дугам $S_n$ не единственным образом (свойство 3). Так как при больших $n$ отрезок $[gamma, delta] in.rev t_0$ сколь угодно мал, неединственность есть на любом $[t_0, t_0 + epsilon]$ и $[t_0 - epsilon, t_0]$.

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
