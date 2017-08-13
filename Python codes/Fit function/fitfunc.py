
# coding: utf-8

# In[3]:

import pandas as pd

from matplotlib.font_manager import FontProperties

   


# In[4]:

data2 = pd.read_csv("/Users/deepakmahapatra/Downloads/TotalDaily.csv",header=None)


# In[5]:

#data2.head(2)


# In[6]:

data2[1].plot(kind="line")


# In[7]:

import numpy as np
from numpy import pi, r_
import matplotlib.pyplot as plt
from scipy import optimize

# Generate data points with noise
#num_points = 150
#Tx = np.linspace(5., 8., num_points)
#Ty = Tx

#tX = 11.86*np.cos(2*pi/0.81*Tx-1.32) + 0.64*Tx+4*((0.5-np.random.rand(num_points))*np.exp(2*np.random.rand(num_points)**2))
#tY = -32.14*np.cos(2*np.pi/0.8*Ty-1.94) + 0.15*Ty+7*((0.5-np.random.rand(num_points))*np.exp(2*np.random.rand(num_points)**2))


# In[8]:

tX=data2[1]
Tx=data2[0]


# In[ ]:




# In[10]:

fitfunc = lambda p, x: p[0]*np.sin(2*np.pi/p[1]*x+p[2])+p[3]*x +p[4]+p[5]*np.sin(2*np.pi/p[6]*x+p[7])# Target function
errfunc = lambda p, x, y: fitfunc(p, x) - y # Distance to the target function
p0 = [100000, 300, 0,-0.8,10000,10000,7,0] # Initial guess for the parameters
p1, success = optimize.leastsq(errfunc, p0[:], args=(Tx, tX))

time = np.arange(Tx.min(), Tx.max()+1)

plt.plot(Tx, tX, "ro", time, fitfunc(p1, time), "b-") # Plot of the data and the fit



# Legend the plot
plt.title("Oscillations in the compressed trap")
plt.xlabel("time [hours]")
plt.ylabel("Consumption")
plt.legend(('Fit', 'Actual'))

ax = plt.axes()

#plt.text(0.8, 0.07,
         #'x freq :  %.3f kHz \n ' % (1/p1[1]),
         #fontsize=16,
         #horizontalalignment='center',
        # verticalalignment='center',
         #transform=ax.transAxes)

plt.show()


# In[11]:

tXprime=fitfunc(p1, time)


# In[12]:

tXprime.shape


# In[13]:

tXprime=tX-tXprime


# In[14]:

tXprime.to_csv("HourlyDeterministic.csv")


# In[15]:

plt.plot(time,tXprime)
plt.show()

