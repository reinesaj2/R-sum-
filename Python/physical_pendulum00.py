#Information about program
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#info='''Put info that the user will see'''
#print(info)

ii = int(input(position #: '))
df = pd.read_csv('position0.csv')

plt.ion()
plt.plot(df['time'], df['pos']

plt.grid()
plt.savefig('test.pdf')
plt.show()
