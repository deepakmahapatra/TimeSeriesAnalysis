
# coding: utf-8

# In[1]:

import pandas as pd
from numpy.linalg import inv
import matplotlib.pyplot as plt
import numpy as np
import statsmodels.api as sm
from statsmodels.regression.linear_model import OLS
from statsmodels.tsa.ar_model import AR


# In[4]:

#give the resude files for each model to calculate the acf.

resid=[]
with open('A_det_arma.txt','r') as f:#change the name of the file for residuals
    for line in f:
        for word in line.split():
           resid.append(float(word))


# In[5]:

#resid = pd.read_csv("A.txt", header=None,sep=" ")
#


# In[6]:

#resid.dropna(inplace=True)
#resid=resid.T


# In[7]:

resid =np.asarray(resid)


# In[8]:

resid.shape


# In[10]:


N = len(resid)
S = [1]
for l in range(1, 31):
    t = range(0, N-l, 1)
    t_l = range(l, N, 1)
    s = (sum(resid[t]*resid[t_l])*N)/(sum(resid**2)*(N-l))
    S.append(s)
ax1 = [2/np.sqrt(N)]*31
ax2 = [-2/np.sqrt(N)]*31
plt.plot(S)
plt.plot(ax1)
plt.plot(ax2)
plt.xlabel("Lag (k)")
plt.ylabel("ACF")
plt.title("ACF For the non stationary ARMA (8,7) model",y=1.08) #change title accordingly
plt.legend(('ACF', 'UB', 'LB'),loc='top right')
plt.show()


# In[ ]:




# In[ ]:



