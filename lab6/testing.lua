
Frac = require 'lab6.z2.Frac'


print ('Wynik: '..Frac(2, 3) + Frac(3, 4))  --> Wynik: 1 i 5/12
print (Frac.tofloat(Frac (2,3) * Frac (3 ,4)))  --> 0.5
print (Frac (2,3) < Frac (3,4))  --> true
print (Frac(2, 3) == Frac (8 ,12))  --> true
print (Frac(2, 3) + 2) --> 2 i 2/3
print (Frac(2, 3) + 2.5) --> ???
print (Frac(2, 3)^3)  --> 8/27


Vector = require 'lab6.z3.Vector'
print (Vector{1,2,3} + Vector{-2,0,4}) --> (-1,2,7)
print (Vector{1,2,3} * 2) --> (2, 4, 6)
print (Vector{1,2,3} * Vector{2,2,-1}) --> 3
print (# Vector{4, 3})  --> 5
print (Vector {1,2,3} * 2 == 2 * Vector {1,2,3})  --> true
print (Vector{3, 4, 5, 6}[3])  --> 5
for k, v in  ipairs(Vector {2,2,3}) do  print(k, '->', v) end
--> (1, 0, 0)   ->   2
--> (0, 1, 0)   ->   2
--> (0, 0, 1)   ->   3