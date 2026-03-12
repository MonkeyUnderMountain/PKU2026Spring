#import "../../../Accessories/note_for_myself.typ": *
#import "../../../Accessories/my_macros.typ": *

#show: article_settings.with(
  section_level: "section",

  heading_number_mode: "level3-last",

  title: "March 12",
  author: "The author",
  date: datetime.today().display(),
  author_page: link("https://www.tianleyang.com")[My Homepage],
  version: "1.0.0",

  make_title: false
)
#show: no-ref

#let Yang(content:"") = text(fill: red)[Yang: #content]

== March 12

=== Relation with representation theory

First, we recall some basic notions.

Let $G$ be a _Lie group_, i.e. $G$ is a group and a smooth manifold such that the group operations are smooth. 
For example, $GL_n (bb(R))$ is a Lie group.
For $g in G$, we have the left translation 
$ L_g : G to G, h mapsto g h $
and the right translation
$ R_g : G to G, h mapsto h g. $
Let $X$ be a vector field on $G$. 
If $(L_g)_* X = X$ for all $g in G$, then $X$ is called a _left-invariant vector field_.
The _Lie algebra_ of $G$ is defined as 
$ frak(g) := T_e G = {"all left invariant vector fields on " G }. $
On the Lie algebra $frak(g)$, we have a Lie bracket defined by
$ [-, -] : frak(g) times frak(g) to frak(g), #h(1em) (X, Y) mapsto [X, Y] = X Y - Y X. $
The Lie bracket is skew-symmetric, $RR$-bilinear and satisfies the Jacobi identity:
$ [[X, Y], Z] + [[Y, Z], X] + [[Z, X], Y] = 0. $
For example, the Lie algebra of $GL_n (bb(R))$ is $frak(g l)_n (bb(R))) = M_n (bb(R))$ with the Lie bracket given by the commutator of matrices.

For $g in G$, we have the adjoint action
$ C_g : G to G, h mapsto g h g^(-1). $
We have $C_g(e) = e$, hence $C_g$ induces a linear map on the Lie algebra $frak(g)$, which is called the _adjoint representation_ of $G$:
$ Ad : G to GL(frak(g)), #h(2em) g mapsto (Ad_g : frak(g) to frak(g), #h(0.5em) X mapsto Ad_g (X) = (C_g)_* X). $
// #linebreak()

#Yang()

We have the _exponential map_ from the Lie algebra to the Lie group.
For any $X in frak(g)$, let $gamma : RR to G$ be a $1$-parameter subgroup of $G$, i.e. $gamma$ is a smooth group homomorphism.
Suppose that $gamma'(0) = X$, then we define $exp(X) := gamma(1)$.
We have $exp(X)^(-1) = exp(-X)$.
For all $X,Y in frak(g)$, we have 
$ frac(d, d t)|_(t=0) Ad_(exp(t X)) (Y) = [X,Y]. $
#Yang()

Let $frak(g)^*$ be the linear dual of $frak(g)$, i.e. the space of linear functionals on $frak(g)$.
We have a natural pairing:
$ frak(g)^* times frak(g) to R, quad (phi, X) mapsto phi(X). $
#definition[
  For $g in G$, $phi in frak(g)^*$, we define $Ad_g^*$ by
  $ chevron.l Ad_g^* (phi), X chevron.r := chevron.l phi, Ad_(g^(-1))(X) chevron.r. $
  Then $g mapsto Ad_g^*$ is called the _coadjoint representation_ of $G$.
]





#proposition[
  Let $M$ be an orbit of the coadjoint representation of $G$ of positive dimension.
  Then $M$ has a symplectic structure.
]
#proof[
  For any $X in frak(g)$, it induces a vector field $tilde(X)$ on $frak(g)^*$ defined by
  $ tilde(X)(phi) = frac(d, d t)|_(t=0) Ad_(exp(t X))^* (phi). $
  We know that $tilde(X) (phi) in T_phi frak(g)^* = frak(g)^*$.
  For any $Y in frak(g)$, we have 
  $ chevron.l tilde(X)(phi), Y chevron.r = frac(d, d t)|_(t=0) ( chevron.l Ad_(exp(t X))^* (phi), Y chevron.r) = frac(d, d t)|_(t=0) ( chevron.l phi, Ad_(exp(-t X))(Y) chevron.r) = chevron.l phi, [-X, Y] chevron.r. $
  #Yang()

  #claim[
    If $phi in M$, then 
    $ T_phi M = {tilde(X)(phi) | X in frak(g) } $
  ]

  By the claim, we get a linear surjective map 
  $ frak(g) to T_phi M, quad X to tilde(X). $

  Define a $2$-form $omega$ on $M$ by 
  $ omega( tilde(X) (phi), tilde(Y) (phi)) := chevron.l phi, [X,Y] chevron.r , quad, forall X,Y in frak(g). $

  #exercise[
    $omega$ is a symplectic form on $M$.
  ]

  We are done.
]



=== More properties

#definition[
  Let $(M_1,omega_1)$, $(M_2, omega_2)$ be symplectic manifolds, $phi$ is a diffeomorphism for $M_1$ to $M_2$.
  We say that $phi$ is a _symplectomorphism_ if $phi^* omega_2 = omega_1$.

  We say that $(M_1,omega_1)$ and $(M_2,omega_2)$ are _equivalent_ if there exists a symplectomorphism from $M_1$ to $M_2$.

  Given a symplectic manifold $(M,omega)$.
  A _symplectic automorphism_ of $(M,omega)$ is a symplectomorphism from $M$ to itself.
  We denote by 
  $ op("Symp")(X) = {"all symplectic automorphism on " M }. $
]

Easily see that $op("Symp") (X)$ is a group.
It is a Lie subgroup of $op("Diff")(X)$.
#Yang() It has a "Lie group" structure.

Let $X$ be a vector field on $M$.
Assume $X$ is complete, i.e., the flow of $X$ is defined for all time.
Then $X$ generate a flow $phi^t: M to M, forall t in bb(R)$.
For any $p in M$, we get a curve $phi^t(p)$.
Its tangent space is just $frac(d, d t)|_(t_0) phi^t (p) = X (phi^ (t_0) (p))$ for all $t$.

#lemma[
  $(phi^t)^* omega = omega$ for all $t in bb(R)$ iff $cal(L)_X omega = 0$.
]
#proof[
  Note that 
  $ frac(d, d s)|_(s=0) (phi^(t+s))^* omega = frac(d, d s)|_(s=0) (phi^t)^* (phi^s)^* omega = (phi^t)^* frac(d, d s)|_(s=0) (phi^s)^* omega = (phi^t)^* cal(L)_X omega. $

  ($=>$) If $(phi^t)^* omega = omega$ for all $t$, then 

  ($< =$) If $cal(L)_X omega = 0$, $(phi^t)^* omega$ is independent of $t$.
  Then $(phi^t)^* omega = (phi^0) omega = omega$. 
]

#definition[
  We say that $X$ is a _symplectic vector field_ if $cal(L)_X omega = 0$.
]

#slogan[
  Symplectic vector field is the counterpart of killing vector field in Riemannian geometry.
]

#lemma[
  A vector field $X$ is a symplectic vector field iff $i_X omega = omega (X, -) in Omega_M$ is closed.
]
#proof[
  Recall the Cartan formula:
  $ cal(L)_X = d circle.small i_X + i_X circle.small d $
  when acting on differential forms.
  Then we have 
  $ cal(L)_X omega = d(i_X omega) + i_X (d omega) = d(i_X omega). $
  Hence 
  $ cal(L)_X omega = 0 <=> d (i_X omega) = 0. $
  We are done.
]

#definition[
  A vector field $X$ is called a _Hamiltonian vector field_ if $i_X omega$ is exact.
    
  If $X$ is Hamiltonian, then there exists $f in C^infinity (M)$ such that $i_X omega = - d f$.
  The function $f$ is call the _Hamiltonian (function)_ of $X$ and $X$ is call the _Hamiltonian vector field of $f$_.
]

Given $f in C^infinity (M)$, then there exists a unique $X$ such that $i_X omega = - d f$ since $omega$ is non-degenerate and hence induces an isomorphism $T M to T^* M$.

Then we have 
$ Lie (op("Symp") (M,omega)) = { "all symplectic vector fields" } supset C^infinity (M) / bb(R). $
Hence
$ dim op("Symp") (M,omega) = infinity. $


