#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Aug 24 11:55:05 2022

@author: abrahamreines
"""


import matplotlib.pyplot as plt
import math
import numpy as np
'''
########## GAMMA DEPENDENCE DENSITY = 50 LUMINOSITY = 44 ##########################
x = []
y = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD50L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x.append(lines[0])
    y.append(math.log10(float(lines[1])))
    xvalues = range(len(x))
    yvalues = range(len(y))
    
plt.rcParams["figure.figsize"] = [7.50, 3.50]
plt.rcParams["figure.autolayout"] = True
fig= plt.figure()
plt.title("Column Density dependence on Power Law", fontsize = 20)
plt.xlabel(r'$\Gamma$', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 2))
#plt.yticks(np.arange(0, max(y), 2))
plt.plot(x, y, marker = 'o', markeredgecolor = 'red', c = 'black',linewidth = 1
         ,label = r'$n_{o}$ = 50 Luminosity = 10^44 ergs/s')
plt.legend(loc="upper left")
#for i,j in zip(x,y):
#    plt.annotate(str(i),xy=(i,j))
spacing = 0.1
fig.subplots_adjust(bottom=spacing)
plt.show()

########## GAMMA DEPENDENCE DENSITY = 50 LUMINOSITY = 45 ##########################

x = []
y = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD500L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x.append(lines[0])
    y.append(math.log10(float(lines[1])))
    xvalues = range(len(x))
    yvalues = range(len(y))
    
plt.rcParams["figure.figsize"] = [7.50, 3.50]
plt.rcParams["figure.autolayout"] = True
fig= plt.figure()
plt.title("Column Density dependence on Power Law", fontsize = 20)
plt.xlabel(r'$\Gamma$', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 2))
#plt.yticks(np.arange(0, max(y), 2))
plt.plot(x, y, marker = 'o', markeredgecolor = 'red', c = 'black',linewidth = 1
         ,label = r'$n_{o}$ = 50 Luminosity = 10^45 ergs/s')
plt.legend(loc="upper left")
#ax[1].bar(y, x, color = 'b', label = ')
#for i,j in zip(x,y):
#    plt.annotate(str(i),xy=(i,j))
spacing = 0.1
fig.subplots_adjust(bottom=spacing)
plt.show()

########## GAMMA DEPENDENCE DENSITY = 50 LUMINOSITY = 44 & 45 ##########################

x1 = []
y1 = []
x2 = []
y2 = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD50L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x1.append(lines[0])
    y1.append(math.log10(float(lines[1])))

    
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD500L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x2.append(lines[0])
    y2.append(math.log10(float(lines[1])))


fig, ax = plt.subplots()
plt.rcParams["figure.figsize"] = [5, 5]
#plt.rcParams["figure.autolayout"] = False
plt.title("Column Density dependence on Power Law fixing $n_{o}$ = 50", fontsize = 20)
plt.xlabel(r'$\Gamma$', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 2))
#plt.yticks(np.arange(0, max(y), 2))
ax.plot(x1, y1, marker = 'o', markeredgecolor = 'red', c = 'red',linewidth = 1
         ,label = 'Luminosity = 10^44 ergs/s')
ax.plot(x2, y2, marker = 'o', markeredgecolor = 'blue', c = 'blue',linewidth = 1
         ,label = 'Luminosity = 10^45 ergs/s')
plt.legend(loc="upper left")
fig.subplots_adjust(bottom=0.1)
plt.show()

########## GAMMA DEPENDENCE DENSITY = 50 LUMINOSITY = 45 ##########################

x = []
y = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD500L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x.append(lines[0])
    y.append(math.log10(float(lines[1])))
    xvalues = range(len(x))
    yvalues = range(len(y))
    
plt.rcParams["figure.figsize"] = [7.50, 3.50]
plt.rcParams["figure.autolayout"] = True
fig= plt.figure()
plt.title("Column Density dependence on Power Law", fontsize = 20)
plt.xlabel(r'$\Gamma$', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 2))
#plt.yticks(np.arange(0, max(y), 2))
plt.plot(x, y, marker = 'o', markeredgecolor = 'red', c = 'black',linewidth = 1
         ,label = r'$n_{o}$ = 500, Luminosity = 10^44 ergs/s')
plt.legend(loc="upper left")
#ax[1].bar(y, x, color = 'b', label = ')
#for i,j in zip(x,y):
#    plt.annotate(str(i),xy=(i,j))
spacing = 0.1
fig.subplots_adjust(bottom=spacing)
plt.show()

########## GAMMA DEPENDENCE DENSITY = 50 LUMINOSITY = 45 ##########################

x = []
y = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD500L45.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x.append(lines[0])
    y.append(math.log10(float(lines[1])))
    xvalues = range(len(x))
    yvalues = range(len(y))
    
plt.rcParams["figure.figsize"] = [7.50, 3.50]
plt.rcParams["figure.autolayout"] = True
fig= plt.figure()
plt.title("Column Density dependence on Power Law", fontsize = 20)
plt.xlabel(r'$\Gamma$', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 1.5))
#plt.yticks(np.arange(0, max(y), 2))
plt.plot(x, y, marker = 'o', markeredgecolor = 'red', c = 'black',linewidth = 1
         ,label = r'$n_{o}$ = 500, Luminosity = 10^45 ergs/s')
plt.legend(loc="upper left")
#ax[1].bar(y, x, color = 'b', label = ')
#for i,j in zip(x,y):
#    plt.annotate(str(i),xy=(i,j))
spacing = 0.1
fig.subplots_adjust(bottom=spacing)
plt.show()

########## GAMMA DEPENDENCE DENSITY = 50 LUMINOSITY = 44 & 45 ##########################

x1 = []
y1 = []
x2 = []
y2 = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD500L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x1.append(lines[0])
    y1.append(math.log10(float(lines[1])))

    
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD500L45.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x2.append(lines[0])
    y2.append(math.log10(float(lines[1])))


fig, ax = plt.subplots()
plt.rcParams["figure.figsize"] = [7.5, 3.5]
#plt.rcParams["figure.autolayout"] = False
plt.title("Column Density dependence on Power Law fixing $n_{o}$ = 500", fontsize = 20)
plt.xlabel(r'$\Gamma$', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 2))
#plt.yticks(np.arange(0, max(y), 2))
ax.plot(x1, y1, marker = 'o', markeredgecolor = 'red', c = 'red',linewidth = 1
         ,label = 'Luminosity = 10^44 ergs/s')
ax.plot(x2, y2, marker = 'o', markeredgecolor = 'blue', c = 'blue',linewidth = 1
         ,label = 'Luminosity = 10^45 ergs/s')
plt.legend(loc="upper left")
fig.subplots_adjust(bottom=0.1)
plt.show()

########## LUMINOSITY DEPENDENCE DENSITY = 50 GAMMA = 1.5 #####################

x = []
y = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingLuminosityD50G1.5.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x.append(lines[0])
    y.append(math.log10(float(lines[1])))
    xvalues = range(len(x))
    yvalues = range(len(y))
    
plt.rcParams["figure.figsize"] = [7.50, 3.50]
plt.rcParams["figure.autolayout"] = True
fig= plt.figure()
plt.title("Luminosity Dependent Column Density Distribution", fontsize = 20)
plt.xlabel(r'$L_X$', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 1.5))
#plt.yticks(np.arange(0, max(y), 2))
plt.plot(x, y, marker = 'o', markeredgecolor = 'red', c = 'black',linewidth = 1
         ,label = r'$n_{o}$ = 50, $\Gamma$ = 1.5')
plt.legend(loc="upper left")
#ax[1].bar(y, x, color = 'b', label = ')
#for i,j in zip(x,y):
#    plt.annotate(str(i),xy=(i,j))
spacing = 0.1
fig.subplots_adjust(bottom=spacing)
plt.show()

########## LUMINOSITY DEPENDENCE DENSITY = 50 GAMMA = 2.0 ##########################

x = []
y = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingLuminosityD50G2.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x.append(lines[0])
    y.append(math.log10(float(lines[1])))
    xvalues = range(len(x))
    yvalues = range(len(y))
    
plt.rcParams["figure.figsize"] = [7.50, 3.50]
plt.rcParams["figure.autolayout"] = True
fig= plt.figure()
plt.title("Luminosity Dependent Column Density Distribution", fontsize = 20)
plt.xlabel(r'$L_X$', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 1.5))
#plt.yticks(np.arange(0, max(y), 2))
plt.plot(x, y, marker = 'o', markeredgecolor = 'red', c = 'black',linewidth = 1
         ,label = r'$n_{o}$ = 50, $\Gamma$ = 2.0')
plt.legend(loc="upper left")
#ax[1].bar(y, x, color = 'b', label = ')
#for i,j in zip(x,y):
#    plt.annotate(str(i),xy=(i,j))
spacing = 0.1
fig.subplots_adjust(bottom=spacing)
plt.show()

########## LUMINOSITY DEPENDENCE DENSITY = 50 GAMMA = 1.5 & 2.0 & 2.5 ##########################

x1 = []
y1 = []
x2 = []
y2 = []
x3 = []
y3 = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingLuminosityD50G1.5.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x1.append(lines[0])
    y1.append(math.log10(float(lines[1])))

    
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingLuminosityD50G2.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x2.append(lines[0])
    y2.append(math.log10(float(lines[1])))
    
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingLuminosityD50G2.5.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x3.append(lines[0])
    y3.append(math.log10(float(lines[1])))


fig, ax = plt.subplots()
plt.rcParams["figure.figsize"] = [7.5, 3.5]
#plt.rcParams["figure.autolayout"] = False
plt.title("Luminosity Dependence Column Density Distribution", fontsize = 20)
plt.xlabel(r'$log(L_X)$', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 2))
#plt.yticks(np.arange(0, max(y), 2))
ax.plot(x1, y1, marker = 'o', markeredgecolor = 'red', c = 'red', linestyle = 'dashed', linewidth = 1
         ,label = r'$\Gamma$ = 1.5')
ax.plot(x2, y2, marker = 'v', markeredgecolor = 'blue', c = 'blue', linestyle = 'dotted', linewidth = 1
         ,label = r'$\Gamma$ = 2.0')
ax.plot(x3, y3, marker = 'X', markeredgecolor = 'green', c = 'green', linestyle = 'dashdot', linewidth = 1
         ,label = r'$\Gamma$ = 2.5')
plt.legend(loc="upper left")
fig.subplots_adjust(bottom=0.1)
plt.show()

########## SLOPE DEPENDENCE DENSITY = 50 GAMMA = 1.5 ##########################

x = []
y = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingSlopeD50G1.5L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x.append(lines[0])
    y.append(math.log10(float(lines[1])))
    xvalues = range(len(x))
    yvalues = range(len(y))
    
plt.rcParams["figure.figsize"] = [7.50, 3.50]
plt.rcParams["figure.autolayout"] = True
fig= plt.figure()
plt.title("Column Density dependence on Density Slope", fontsize = 20)
plt.xlabel('p', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 1.5))
#plt.yticks(np.arange(0, max(y), 2))
plt.plot(x, y, marker = 'o', markeredgecolor = 'red', c = 'black',linewidth = 1
         ,label = r'$n_{o}$ = 50, $\Gamma$ = 1.5, Luminosity = 10^44 ergs/s')
plt.legend(loc="lower left")
#ax[1].bar(y, x, color = 'b', label = ')
#for i,j in zip(x,y):
#    plt.annotate(str(i),xy=(i,j))
spacing = 0.1
fig.subplots_adjust(bottom=spacing)
plt.show()

########## SLOPE DEPENDENCE DENSITY = 50 GAMMA = 2.0 ##########################

x = []
y = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingSlopeD50G2L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x.append(lines[0])
    y.append(math.log10(float(lines[1])))
    xvalues = range(len(x))
    yvalues = range(len(y))
    
plt.rcParams["figure.figsize"] = [7.50, 3.50]
plt.rcParams["figure.autolayout"] = True
fig= plt.figure()
plt.title("Wind Density Gradient Dependence", fontsize = 20)
plt.xlabel('p', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 1.5))
#plt.yticks(np.arange(0, max(y), 2))
plt.plot(x, y, marker = 'o', markeredgecolor = 'red', c = 'black',linewidth = 1
         ,label = r'$n_{o}$ = 50, $\Gamma$ = 2.0, Luminosity = 10^44 ergs/s')
plt.legend(loc="lower left")
#ax[1].bar(y, x, color = 'b', label = ')
#for i,j in zip(x,y):
#    plt.annotate(str(i),xy=(i,j))
spacing = 0.1
fig.subplots_adjust(bottom=spacing)
plt.show()

########## SLOPE DEPENDENCE DENSITY = 50 GAMMA = 2.0 ##########################

x = []
y = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingSlopeD50G2.5L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x.append(lines[0])
    y.append(math.log10(float(lines[1])))
    xvalues = range(len(x))
    yvalues = range(len(y))
    
plt.rcParams["figure.figsize"] = [7.50, 3.50]
plt.rcParams["figure.autolayout"] = True
fig= plt.figure()
plt.title("Column Density dependence on Density Slope", fontsize = 20)
plt.xlabel('p', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 1.5))
#plt.yticks(np.arange(0, max(y), 2))
plt.plot(x, y, marker = 'o', markeredgecolor = 'red', c = 'black',linewidth = 1
         ,label = r'$n_{o}$ = 50, $\Gamma$ = 2.5, Luminosity = 10^44 ergs/s')
plt.legend(loc="lower left")
#ax[1].bar(y, x, color = 'b', label = ')
#for i,j in zip(x,y):
#    plt.annotate(str(i),xy=(i,j))
spacing = 0.1
fig.subplots_adjust(bottom=spacing)
plt.show()

#### SLOPE DEPENDENCE DENSITY = 50 LUMINOSITY = 44 GAMMA = 1.5 & 2.0 & 2.5 ####

x1 = []
y1 = []
x2 = []
y2 = []
x3 = []
y3 = []
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingSlopeD50G1.5L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x1.append(lines[0])
    y1.append(math.log10(float(lines[1])))

    
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingSlopeD50G2L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x2.append(lines[0])
    y2.append(math.log10(float(lines[1])))
    
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingSlopeD50G2.5L44.txt', 'r'):
    lines = [i for i in line.split()]
#    print(lines)
    x3.append(lines[0])
    y3.append(math.log10(float(lines[1])))


fig, ax = plt.subplots()
plt.rcParams["figure.figsize"] = [7.5, 3.5]
#plt.rcParams["figure.autolayout"] = False
plt.title("Column Density Dependence on Density Slope", fontsize = 20)
plt.xlabel('p', fontsize = 18)
plt.ylabel(r'$log(N_H)$', fontsize = 18)
plt.xticks(np.arange(0, len(x)+1, 2))
#plt.yticks(np.arange(0, max(y), 2))
ax.plot(x1, y1, marker = 'o', markeredgecolor = 'red', c = 'red', linestyle = 'dashed', linewidth = 1
         ,label = r'$\Gamma$ = 1.5')
ax.plot(x2, y2, marker = 'v', markeredgecolor = 'blue', c = 'blue', linestyle = 'dotted', linewidth = 1
         ,label = r'$\Gamma$ = 2.0')
ax.plot(x3, y3, marker = 'X', markeredgecolor = 'green', c = 'green', linestyle = 'dashdot', linewidth = 1
         ,label = r'$\Gamma$ = 2.5')
plt.legend(loc="lower left")
fig.subplots_adjust(bottom=0.1)
plt.show()
'''
#################################### COPLOT  #################################

x1 = []
y1 = []
x2 = []
y2 = []
x3 = []
y3 = []
x4 = []
y4 = []

for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD50L44.txt', 'r'):
    lines = [i for i in line.split()]
    x1.append(lines[0])
    y1.append(math.log10(float(lines[1])))
    
for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD500L44.txt', 'r'):
    lines = [i for i in line.split()]
    x2.append(lines[0])
    y2.append(math.log10(float(lines[1])))

for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD500L44.txt', 'r'):
    lines = [i for i in line.split()]
    x3.append(lines[0])
    y3.append(math.log10(float(lines[1])))

for line in open('/Users/abrahamreines/Desktop/Plots/ExaminingGammaD500L45.txt', 'r'):
    lines = [i for i in line.split()]
    x4.append(lines[0])
    y4.append(math.log10(float(lines[1])))

'''
fig, (ax, ax) = plt.subplots(2)
fig.suptitle('Column Density dependence on Power Law', fontsize = 22)
ax.plot(x1, y1, marker = 'o', markeredgecolor = 'red', c = 'red',linewidth = 1
         ,label = 'Luminosity = 10^44 ergs/s')
ax.plot(x2, y2, marker = 'o', markeredgecolor = 'blue', c = 'blue',linewidth = 1
         ,label = 'Luminosity = 10^45 ergs/s')
ax.plot(x3, y3, marker = 'o', markeredgecolor = 'red', c = 'red',linewidth = 1
         ,label = 'Luminosity = 10^44 ergs/s')
ax.plot(x4, y4, marker = 'o', markeredgecolor = 'blue', c = 'blue',linewidth = 1
         ,label = 'Luminosity = 10^45 ergs/s')'''

fig, ax = plt.subplots()
fig.suptitle('Column Density Dependence on Power Law', fontsize = 22)
ax.plot(x1, y1, marker = 'o', markeredgecolor = 'green', linestyle = 'dashed', c = 'green',linewidth = 1
         ,label = 'Luminosity = 10^44 ergs/s, $n_{o}$ = 50')
#ax.plot(x2, y2, marker = 'x', markeredgecolor = 'blue', c = 'blue', linestyle = 'dotted', linewidth = 1)
ax.plot(x3, y3, marker = 'v', markeredgecolor = 'red', c = 'red', linestyle = 'dashdot', linewidth = 1
         ,label = 'Luminosity = 10^44 ergs/s, $n_{o}$ = 500')
ax.plot(x4, y4, marker = 'X', markeredgecolor = 'blue', c = 'blue',linestyle = 'dashdot', linewidth = 1
         ,label = 'Luminosity = 10^45 ergs/s, $n_{o}$ = 500')

ax.set_ylabel(r'$log(N_H)$', fontsize = 18)
ax.set_xlabel(r'$\Gamma$', fontsize = 18)
ax.set_xticks(np.arange(0, len(x1)+1, 2))
ax.legend(loc="upper left")
plt.rcParams["figure.figsize"] = [7.5, 7.5]
#fig.subplots_adjust(bottom=.8)
plt.show()