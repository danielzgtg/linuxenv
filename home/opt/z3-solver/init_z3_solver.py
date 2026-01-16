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
