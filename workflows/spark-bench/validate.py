import pandas as pd
import math

df = pd.read_csv('./workflows/spark-bench/results/outA.csv')
df = df.assign(difference=abs(df['pi_approximate'] - math.pi))

is_10 = (df['slices'] == 10)
is_100 = (df['slices'] == 100)
is_1000 = (df['slices'] == 1000)

mean_10 = df[is_10]["difference"].mean()
mean_100 = df[is_100]["difference"].mean()
mean_1000 = df[is_1000]["difference"].mean()

perc_error_10 = (mean_10/math.pi) * 100
perc_error_100 = (mean_100/math.pi) * 100
perc_error_1000 = (mean_1000/math.pi) * 100

print("Percent Error with 10 slices: {:.4f}%".format(perc_error_10))
print("Percent Error with 100 slices: {:.4f}%".format(perc_error_100))
print("Percent Error with 1000 slices: {:.4f}%".format(perc_error_1000))

