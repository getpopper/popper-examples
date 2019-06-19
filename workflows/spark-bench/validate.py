import pandas as pd
import math
df = pd.read_csv('./workflows/spark-bench/results/outA.csv')
df = df.assign(difference=abs(df['pi_approximate']-math.pi))
print(df[['pi_approximate', 'slices', 'difference']])
