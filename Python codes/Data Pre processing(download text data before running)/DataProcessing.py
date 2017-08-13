
# coding: utf-8

# In[13]:

import pandas as pd

from matplotlib.font_manager import FontProperties

   


# In[2]:

data = pd.read_csv("LD2011_2014.txt",sep = ";")


# In[ ]:




# In[4]:

data.rename(columns={"Unnamed: 0": "Time"},inplace=True)


# In[5]:

#data.Time=data.Time.to_timestamp
data.MT_001= data.MT_001.replace(',','.')


# In[6]:

data['Time'] =  pd.to_datetime(data['Time'], format='%Y-%m-%d %H:%M:%S')


# In[7]:

data['Hour'] = data.Time.dt.hour


# In[8]:

data['Year'] = data.Time.dt.year
data['Month'] = data.Time.dt.month
data['Day'] = data.Time.dt.day


# In[9]:

data.replace({',': '.'}, regex=True,inplace=True)


# In[10]:

data.pop("Time")


# In[11]:

data.dtypes


# In[12]:

data=data.convert_objects(convert_numeric=True)


# In[13]:


g = data.groupby(['Year','Month','Day','Hour'],axis=0,as_index=False).sum()

g1 = data.groupby(['Year','Month','Day'],axis=0,as_index=False).sum()
g2 = data.groupby(['Year','Month'],axis=0,as_index=False).sum()


# data1

# In[14]:

g.drop([col for col, val in g[(g.Year==2011)].sum().iteritems() if val ==0], axis=1, inplace=True)
g1.drop([col for col, val in g1[(g1.Year==2011)].sum().iteritems() if val ==0], axis=1, inplace=True)
g2.drop([col for col, val in g2[(g2.Year==2011)].sum().iteritems() if val ==0], axis=1, inplace=True)


# In[15]:

print g.shape
list1=['Year','Month','Day','Hour']
cols1 = [col for col in g.columns if col not in list1]
print g1.shape
list2=['Year','Month','Day']
cols2 = [col for col in g1.columns if col not in list2]
print g2.shape
list3=['Year','Month']
cols3 = [col for col in g2.columns if col not in list3]


# In[18]:

g['Summation']=g[cols1].sum(axis=1)
g1['Summation']=g1[cols2].sum(axis=1)
g2['Summation']=g1[cols3].sum(axis=1)


# In[ ]:


g2.Summation.plot()


# In[ ]:

g.Summation.plot()


# In[22]:




# In[75]:

g.Summation.to_csv("TotalHourly.csv")
g1.Summation.to_csv("TotalDaily.csv")
g2.Summation.to_csv("Monthly.csv")


# In[112]:

g.head(2)


# In[54]:

g.MT_124.to_csv("MT_124hourly.csv")
g1.MT_124.to_csv("MT_124daily.csv")

