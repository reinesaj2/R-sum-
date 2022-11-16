# -*- coding: utf-8 -*-
"""
Created on Sat Sep 11 18:11:26 2021

@author: Abraham Reines
"""

# Problem 1.24 ######################################
print('Problem 1.24%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

N = (6.02*10**23)*(207.2)**-1 # molecules per grams yields molecules
fs = 3 + 3 # 3 translational degrees of freedom, 3 vibrational degrees of freedom
kb = 1.381*10**-23 # Boltzman things 
T = 300 # Kelvin

U = 2**-1*N*fs*kb*T # U is thermal energy of system 
print('%.2f Joules, Total Thermal Energy of System'% U)

# Problem 1.28 ######################################
print('Problem 1.28%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')


m = 236 # grams of cup of water
Cw= 4.186 # Joules per grams by Celsius, specific heat of water
T = 80 # degrees Celsius
P = 600 # watts, Power of microwave

Q = m*Cw*T # heat energy

Time = Q*P**-1 
print('%.2f minutes'%Time)

# Problem 1.33 ####################################
print('Problem 1.33%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

from sympy import *
init_printing(use_unicode=True)

Pi = symbols('Pi')
Pf = symbols('Pf')
Vi = symbols('Vi')
Vf = symbols('Vf')
f = symbols('f')
#Total Thermal energy simplification
expr = f/2*(Pi*Vf-Pi*Vi)+f/2*(Pf*Vf-Pi*Vf)+f/2*(Pi*Vi-Pf*Vf)
smpl = simplify(expr) 
    
print("After Simplification : {}".format(smpl)) 

# Problem 1.35 ####################################
print('Problem 1.35%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

from sympy import symbols, solve
init_printing(use_unicode=True)

P = symbols('P')
V = symbols('V')
n = symbols('n')
R = symbols('R')

G = (f +2)/f
# Expansion of variables to make some statement on algebra
expr = P*V**G 
exp = expand(expr) 
print("After Expansion : {}".format(exp)) 

# Problem 1.44 ####################################
print('Problem 1.44%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

R = 8.314 # Joules per mole by Kelvin
Cp = 2.5

Cppermole = Cp*R
print('%.2f Joules per Kelvin for monoatomic gas'%Cppermole)

Cp = 3.5
Cppermole = Cp*R

print('%.2f Joules per Kelvin for diatomic gas'%Cppermole)

Cp = 4
Cppermole = Cp*R

print('%.2f Joules per Kelvin for polyatomic gas'%Cppermole)

Cp = 3
Cppermole = Cp*R

print('%.2f Joules per Kelvin for polyatomic gas'%Cppermole)

# Problem 1.46 ####################################
print('Problem 1.46%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

# part a
dV = symbols('dV')
V = symbols('V')
dT = symbols('dT')
B = (dV*V**-1)/dT

expr = B*V*dT # Change in volume should be dV!
exp = expand(expr) 
print("dV upholds expression : {}".format(exp)) 
#part b
dV = symbols('dV')
dP = symbols('dP')
V = symbols('V')
kT = -V**-1*(dV*dP**-1)

expr = -kT*V*dP # Change in volume should be dV!
exp = expand(expr)
print("dV upholds expression! : {}".format(exp))
#part c
V = symbols('V')
dT = symbols('dT')
B = (dV*V**-1)/dT
dP = symbols('dP')
V = symbols('V')
kT = -V**-1*(dV*dP**-1)

expr = B*V*dT + kT*V*dP
smpl = simplify(expr)
print("0 upholds change in volume for parts a and b : {}".format(smpl))

expr = B/kT
smpl = simplify(expr)
print("Result is mathematical relation desired for part c : {}".format(smpl))
# part d
from sympy import symbols, diff
V, N, k, T, P, dV, dT = symbols(' V N k T P dV dT', real=True)
V = N*k*T*P**-1

B = V**-1*diff(V, T)
print("Result is check for Beta: {}".format(B))

kT = -V**-1*diff(V, P)
print("Result is check for isothermal compression: {}".format(kT))

exp = B/kT
smpl = simplify(expr)
print("B/kT is equal to mathematical relation from part c : {}".format(smpl))

exp = (V**-1*diff(V, T))/(-V**-1*diff(V, P))
smpl = simplify(expr)
print("B/kT is equal to mathematical relation from part c : {}".format(smpl))\
    
dT = 10 # Kelvin
B = 2.57*10**-4 # pascals
kT = 4.52*10**-10 # pascals
dP = B*kT**-1*dT

print("Pressure neccessary to stop expansion of water : %.4f" %dP)

B = 1.81*10**-4 # pascals
kT = 4.04*10**-11 # pascals
dP = B*kT**-1*dT

print("Pressure neccessary to stop expansion of water : %.4f" %dP)
