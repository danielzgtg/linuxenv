from z3 import *
p, q, r = Bools("p q r")
i, j, k = Ints("i j k")
x, y, z = Reals("x y z")
f = Function("f", IntSort(), IntSort())
g = Function("g", IntSort(), IntSort())
h = Function("h", IntSort(), IntSort())
def PairSort(typ):
    Pair = Datatype("Pair")
    Pair.declare("new", ("left", typ), ("right", typ))
    return Pair.create()
Pair = PairSort(IntSort())
pair = lambda x, y: Pair.new(x, y)
s = Solver()  # For when solve() ain't enough
o = Optimize()
fp = Fixedpoint()
a = Array("a", IntSort(), IntSort())
def init_a(vals):
    # https://github.com/Z3Prover/z3/pull/8624 was declined
    if not isinstance(vals, list):
        raise TypeError
    if a.domain() != IntSort():
        raise ValueError
    return [a[i] == x for i, x in enumerate(vals)]
