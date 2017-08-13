
# coding: utf-8

# In[3]:

import pandas as pd

from matplotlib.font_manager import FontProperties
from matplotlib import pyplot as plt


   


# In[4]:




# In[25]:

test=pd.read_csv("TotalDaily_test.csv")
forecast_arma=pd.read_csv("forecast_arma.csv")
UB_arma=pd.read_csv("range_upper.csv")
LB_arma=pd.read_csv("range_lower.csv")


# In[28]:

test.plot(kind="line")


# In[39]:

plt.plot(test, "r-", forecast_arma, "b-",UB_arma, "g-",LB_arma,"g-")
plt.legend(('Actual', 'Forecast', 'Upper Bound', 'Lower Bound'))
plt.legend(('Predictions', 'Upper Bound', 'Lower Bound', 'Actual'),loc='center left', bbox_to_anchor=(1, 0.5))
plt.title("Predictions for 30 days when using Stationary ARMA (10,9) model ",y=1.08)
plt.xlabel("Days ")
plt.ylabel("Power Consumption in kW ")

plt.show()
# In[32]:




# In[11]:

forecast_arma_det=pd.read_csv("forecast_arma_det.csv")
UB_arma_det=pd.read_csv("range_upper_det_arma.csv")
LB_arma_det=pd.read_csv("range_lower_det_arma.csv")
actual_arma_det=pd.read_csv("actual_test_arma_det.csv")


# In[38]:

plt.plot(  forecast_arma_det, "b-",UB_arma_det, "g-",LB_arma_det,"g-",actual_arma_det,"r-")
plt.legend(('Forecast', 'UB', 'LB', 'Actual'))
plt.legend(('Predictions', 'Upper Bound', 'Lower Bound', 'Actual'),loc='center left', bbox_to_anchor=(1, 0.5))
plt.title("Predictions for 30 days when using Non stationary ARMA (8,7) model ",y=1.08)
plt.xlabel("Days ")
plt.ylabel("kW after removing deterministics trend ")
plt.show()


# In[37]:

forecast_arma_pars=pd.read_csv("forecast_pars (2).csv")
UB_arma_pars=pd.read_csv("range_upper_pars (1).csv")
LB_arma_pars=pd.read_csv("range_lower_pars (1).csv")
actual_arma_pars=pd.read_csv("actual_test_pars.csv")
plt.plot(  forecast_arma_pars, "b-",UB_arma_pars, "g-",LB_arma_pars,"g-",actual_arma_pars,"r-")
#plt.legend(('Predictions', 'Upper Bound', 'Lower Bound', 'Actual'))
plt.legend(('Predictions', 'Upper Bound', 'Lower Bound', 'Actual'),loc='center left', bbox_to_anchor=(1, 0.5))
plt.title("Predictions for 30 days when using Stationary Parsimonous model ARMA (8,9)",y=1.08)
plt.xlabel("Days ")
plt.ylabel("kW in terms of parsimonious model ")
plt.show()

# In[35]:

forecast_pars_det=pd.read_csv("forecast_pars_det.csv")
UB_arma_pars_det=pd.read_csv("range_upper_det_pars.csv")
LB_arma_pars_det=pd.read_csv("range_lower_det_pars.csv")
actual_det_pars=pd.read_csv("actual_test_pars_det.csv")
plt.plot(  forecast_pars_det, "b-",UB_arma_pars_det, "g-",LB_arma_pars_det,"g-",actual_det_pars,"r-")
#plt.legend(('Predictions', 'Upper Bound', 'Lower Bound', 'Actual'))
plt.legend(('Predictions', 'Upper Bound', 'Lower Bound', 'Actual'),loc='center left', bbox_to_anchor=(1, 0.5))
plt.title("Predictions for 30 days when using Non Stationary Parsimonous model ARMA (6,7)",y=1.08)
plt.xlabel("Days ")
plt.ylabel("kW after removing deterministic trend ")
plt.show()

# In[ ]:



