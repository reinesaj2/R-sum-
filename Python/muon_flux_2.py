# -*- coding: utf-8 -*-
"""
Created on Wed May  4 21:43:59 2022

@author: mayne
"""
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import random
import math

l = 9.7 # 9.7  length of detector in  cm (guessing)
w = 2.7 # 2.7 width of detector in cm (guessing) 
area = l*w
z = 3.0 #distance between giger meters in cm
r = 0.1
m = int(z/r)
x = 0
y = 0
time = 7 # time in minuites
"""I got the number for the muon flux based on the results of this study
   https://arxiv.org/ftp/arxiv/papers/1203/1203.0101.pdf. Based on the fact
   that they got 100 counts per squar-cm per minuite for the altitude of 4200ft
   , I got that their PMT had an area of 24 square-cm. which would make for an altidude
   1350 ft between 20.8 and 31.25. I choose 26
"""


muon_flux = 26# 26 counts per square-cm per minuite
expected_counts = int(muon_flux * area * time)
counts = 0.0

fig = plt.figure(figsize=(4,4))
ax = fig.add_subplot(111, projection='3d')

for i in range(0, expected_counts):
    x_start = random.uniform(0.0,l)
    y_start = random.uniform(0.0,w)
    x_angle = random.uniform(-20.0, 20.0)
    y_angle = random.uniform(-20.0, 20.0)
    x_slop = math.tan(math.degrees(x_angle))
    y_slop = math.tan(math.degrees(y_angle))
    X = np.zeros(m)
    Y = np.zeros(m)
    Z = np.zeros(m)
    for i in range(m-1, -1, -1):  # range is d/0.01
        x = x_slop * z + x_start
        y = y_slop * z + y_start
        z = z - r
        X[i] = x
        Y[i] = y
        Z[i] = z
    z = 3.0
    if ( 0 <= X[m-1] <= l) & (0 <= Y[m-1] <= w):
        counts += 1
        ax.plot(X,Y,Z)
print(X)
print(expected_counts)
print(counts)

        
        
    
 