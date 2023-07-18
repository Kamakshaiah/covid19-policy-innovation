import os
os.getcwd()
os.listdir()

import topmodpy as tmp
data = tmp.fileImport('D:\Research\PAPERS\covid19\policy innovation\scopus.csv')
type(data) # <class 'pandas.core.frame.DataFrame'>
data.columns # find 'Abstract' column 

var = tmp.createVariable(data, 'Abstract')
cleanedVar = tmp.cleanVar(var)
##cleanedVar.head()

tww = tmp.printTopicsWithWeights(cleanedVar, 10, 15)
for i in tww:
    print(i)

os.chdir(r'D:\Research\PAPERS\covid19\policy innovation')
