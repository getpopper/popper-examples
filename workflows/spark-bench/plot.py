import pandas as pd
import seaborn as sns

sns.set(style="whitegrid")
df = pd.read_csv('./workflows/spark-bench/results/outA.csv')
df = df.append(pd.read_csv('./workflows/spark-bench/results/outB.csv'))
ax = sns.barplot(x="name", y="total_runtime", hue="description", data=df).get_figure().savefig('./workflows/spark'
                                                                                               '-bench/results'
                                                                                               '/income_f_age.png')
