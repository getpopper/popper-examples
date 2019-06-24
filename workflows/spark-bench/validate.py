import itertools
import math
import pandas as pd
import seaborn as sns

df = pd.read_csv('./workflows/spark-bench/results/results.csv')
df = df.assign(difference=abs(df['pi_approximate'] - math.pi))

# save plot
ax = sns.barplot(x="name", y="difference", hue="slices", data=df)
ax.figure.savefig('./workflows/spark-bench/results/plot.pdf')

# validate
slices = df['slices'].unique()
for (x, y) in list(itertools.combinations(slices, 2)):
    mape_x = (df.query('slices == {}'.format(x))['difference'].mean() / math.pi) * 100
    mape_y = (df.query('slices == {}'.format(y))['difference'].mean() / math.pi) * 100

    print("MAPE slices={}: {}".format(x, mape_x))
    print("MAPE slices={}: {}".format(y, mape_y))

    if x > y:
        assert mape_x < mape_y
    else:
        assert mape_x > mape_y
