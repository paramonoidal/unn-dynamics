#import "../template.typ": *
#import "../figures.typ": *

#lecture(1, none, [Теорема Пикара])
#note[Дата лекции в рукописном конспекте не указана.]

*Литература.*
- В. И. Арнольд --- _Дополнительные главы теории ОДУ_; _Математические методы классической механики_.
- Ф. Хартман --- _Обыкновенные дифференциальные уравнения_.

== Условие Липшица

#definition([условие Липшица])[
  $ abs(f(x_1) - f(x_2)) <= L abs(x_1 - x_2) quad forall x_k in [a, b], quad t in T. $
]

== Теорема Пикара

#theorem([Пикара])[
  Теорема даёт локальное $exists!$ решение задачи Коши (З.К.)

  $ dot(X) = vec(dot(x)_1 (t), dots.v, dot(x)_n (t)), quad X in Rn, quad t in bb(R), quad X(t_0) = X_0, quad R := T times Rn, $

  $ dot(X) = F(t, X), wide A = {(t, X) : abs(t - t_0) <= a, norm(X - X_0)_(Rn) <= b}. $

  Пусть
  + $F in C^0_R$, причём $exists M >= 0 : norm(F(t, X))_(Rn) <= M$ на $A$;
  + $exists L >= 0$ такое, что для всех $t in [t_0 - a, t_0 + a]$ и всех $X_1, X_2$ с $norm(X_k - X_0)_(Rn) <= b$
    $ norm(F(t, X_1) - F(t, X_2))_(Rn) <= L norm(X_1 - X_2). $

  Тогда $exists!$ решение $X = X(t)$ на отрезке $[t_0 - h, t_0 + h]$, где
  $ h = min(a, b / M) = h(sup_((t, X) in A) norm(F(t, X))_(Rn), a, b). $
]

#note[
  Непрерывность $F$ даёт существование решения (теорема Пеано, см. лекцию 2), липшицевость $F$ по $X$ добавляет единственность.
]

#proof[
  _Метод последовательных приближений._ Следующие задачи равносильны:
  $ dot(X) = F(t, X), thick X(t_0) = X_0 quad <==> quad X(t) = X_0 + integral_(t_0)^t F(s, X) dif s. $
  Метод: $X_0 (s) equiv X_0$, и для всех $m >= 1$
  $ X_m (t) = X_0 + integral_(t_0)^t F(s, X_(m-1) (s)) dif s. $

  Оценка первого приближения:
  $ norm(X_1 (t) - X_0)_(Rn) = norm(integral_(t_0)^t F(s, X_0) dif s) <= abs(integral_(t_0)^t norm(F(s, X_0)) dif s) <= M h. $

  По индукции:
  $ norm(X_m (t) - X_0) = norm(integral_(t_0)^t F(s, X_(m-1)) dif s) <= abs(integral_(t_0)^t norm(F(s, X_(m-1))) dif s) <= M h. $

  Рассмотрим ряд
  $ X_0 (t) + (X_1 - X_0)(t) + (X_2 - X_1)(t) + dots + (X_m - X_(m-1))(t) + dots $
  с частичными суммами $S_m (t) = X_m (t)$. Тогда
  $ S_m (t) unif(m -> +oo) X(t) quad "на" thin U_h (t_0) = [t_0 - h, t_0 + h]. $

  При всех $m >= 2$
  $ norm(X_m (t) - X_(m-1)(t)) &<= norm(integral_(t_0)^t (F(s, X_(m-1)(s)) - F(s, X_(m-2)(s))) dif s) \
    &<= abs(integral_(t_0)^t norm(F(s, X_(m-1)(s)) - F(s, X_(m-2)(s))) dif s) <= M / L dot (L h)^m / m!. $

  #homework[Провести все выкладки, по индукции вывести последнюю оценку.]

  Мажорантный ряд сходится:
  $ M / L L h + dots + M / L (L h)^m dot 1 / m! + dots = (e^(L h) - 1) M / L < oo. $
  Значит, по признаку Вейерштрасса ряд сходится равномерно:
  $ X_m (t) unif(#[$[t_0 - h, t_0 + h]$]) overline(X)(t). $

  Предельная функция --- решение:
  $ norm(integral_(t_0)^t F(s, X_m (s)) - F(s, overline(X)(s)) dif s) &<= abs(integral_(t_0)^t norm(F(s, X_m (s)) - F(s, overline(X)(s))) dif s) \
    &<= L abs(integral_(t_0)^t norm(X_m (s) - overline(X)(s)) dif s) <= L epsilon h. $

  _Единственность._ Пусть существует решение $Z != overline(X)$. Тогда
  $ norm(Z(t) - X_m (t)) <= L abs(integral_(t_0)^t norm(Z(s) - X_(m-1)(s)) dif s) <= M h = M / L dot L h $
  (и далее по индукции, как выше).

  #homework[Подробное доказательство единственности.]
]

#solution([Решение Д/з 1.1])[
  Пусть $Delta_m (t) = norm(X_m (t) - X_(m-1)(t))$, $abs(t - t_0) <= h$. Докажем по индукции, что
  $ Delta_m (t) <= M L^(m-1) abs(t - t_0)^m / m!. $
  _База_ $m = 1$: $Delta_1 (t) <= M abs(t - t_0)$ (оценка первого приближения выше).

  _Шаг._ Все приближения лежат в шаре: $norm(X_k (s) - X_0) <= M h <= b$ (по индукции), поэтому условие Липшица применимо к $X_m (s)$ и $X_(m-1)(s)$:
  $ Delta_(m+1)(t) = norm(integral_(t_0)^t (F(s, X_m (s)) - F(s, X_(m-1)(s))) dif s) <= abs(integral_(t_0)^t L Delta_m (s) dif s)
    <= L dot (M L^(m-1)) / m! abs(integral_(t_0)^t abs(s - t_0)^m dif s) = M L^m abs(t - t_0)^(m+1) / (m+1)!. $
  При $abs(t - t_0) <= h$ получаем $Delta_m (t) <= M L^(m-1) h^m / m! = M / L dot (L h)^m / m!$ (при $L = 0$ функция $F$ не зависит от $X$ и $Delta_m equiv 0$ для $m >= 2$).
]

#solution([Решение Д/з 1.2])[
  Пусть $Z$ --- другое решение З.К. на $J subset [t_0 - h, t_0 + h]$, $t_0 in J$, с графиком в $A$, а $overline(X)$ --- построенное решение. Положим $D(t) = norm(Z(t) - overline(X)(t))$. Оба решения лежат в шаре радиуса $b$, поэтому $D <= 2b$. Из интегрального уравнения и условия Липшица
  $ D(t) <= abs(integral_(t_0)^t norm(F(s, Z(s)) - F(s, overline(X)(s))) dif s) <= L abs(integral_(t_0)^t D(s) dif s). $
  Индукцией по $k$ докажем $D(t) <= 2b (L abs(t - t_0))^k / k!$: при $k = 0$ это $D <= 2b$, а
  $ D(t) <= L abs(integral_(t_0)^t 2b (L abs(s - t_0))^k / k! dif s) = 2b (L abs(t - t_0))^(k+1) / (k+1)!. $
  Правая часть --- общий член сходящегося ряда $e^(L abs(t - t_0))$, поэтому стремится к нулю при $k -> oo$. Значит, $D equiv 0$, то есть $Z = overline(X)$. (Это неравенство Гронуолла.)
]

#homework[
  Привести пример непрерывной на компакте не липшицевой $f$. Если $f$ липшицева, всегда ли $f in C^0$?
]

#remark[
  Липшицева функция всегда непрерывна. Разрывная функция условию Липшица не удовлетворяет. Пример: $f(x) = {x}$ (дробная часть), $L = 1$?
  Возьмём $x_1 = 1$, $x_2 = 1 - epsilon$: $abs(0 - {1 - epsilon}) <= L abs(1 - 1 + epsilon)$, то есть $1 - epsilon <= L epsilon$, откуда
  $ L >= (1 - epsilon) / epsilon limits(-->)_(epsilon -> 0) oo. $
]

#fig(fig-frac-part(), cap: [График $f(x) = {x}$: разрывы в целых точках.])

#solution([Решение Д/з 1.3])[
  _Пример._ $f(x) = sqrt(x)$ на компакте $[0, 1]$ непрерывна, но не липшицева: $abs(f(x) - f(0)) / abs(x - 0) = 1 / sqrt(x) -> oo$ при $x -> 0+$, так что никакая константа $L$ не годится.

  _Липшицева $==>$ непрерывна._ Если $abs(f(x) - f(y)) <= L abs(x - y)$, то для любого $epsilon > 0$ при $delta = epsilon / L$ ($L > 0$) из $abs(x - y) < delta$ следует $abs(f(x) - f(y)) < epsilon$, то есть $f$ даже равномерно непрерывна (при $L = 0$ функция постоянна). Обратное неверно --- пример выше. Итого $C^1 [a, b] subset Lip subset C^0$, а $f(x) = {x}$ из замечания --- пример разрывной, поэтому не липшицевой.
]

== Достаточное условие липшицевости

Функция $f(x)$ липшицева, если $exists f'(x)$ и она ограничена на $[a, b]$ (например, $f' in C^0 [a, b]$, по теореме Вейерштрасса). Тогда по теореме Лагранжа
$ abs(f(a) - f(b)) <= L abs(a - b), quad L = sup_([a, b]) abs(f'(x)) < oo. $

Для $F(X) : bb(R)^m -> Rn$, $F_i in C^1_R$, при всех $X_(1,2) in R$
$ norm(F(X_1) - F(X_2))_(Rn) <= sup norm(D F) dot norm(X_1 - X_2) = norm((partial_j F_i)) dot norm(X_1 - X_2), $
$ L = max_(1 <= i <= n) sum_(j=1)^m sup_(X in R) abs(partial_j F_i). $
