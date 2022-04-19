#%%
import pandas as pd 
import numpy as np

data = np.array([(1, 2, 3), (4, 5, 6), (7, 8, 9)],
                dtype=[("a", "i4"), ("b", "i4"), ("c", "i4")])

df = pd.DataFrame(data, columns=['c', 'a'])

print(df)
# %%
