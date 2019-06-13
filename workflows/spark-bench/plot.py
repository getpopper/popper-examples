import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

sns.set(style="whitegrid")
df = pd.read_csv('./workflows/spark-bench/results/outA.csv')
df = df.append(pd.read_csv('./workflows/spark-bench/results/outB.csv'))
# dataset1 = pd.read_csv('./workflows/spark-bench/ansible/results/outA.csv')
# dataset2 = pd.read_csv('./workflows/spark-bench/ansible/results/outB.csv')
# Y1 = dataset1.iloc[:, 7].values
# Y2 = dataset2.iloc[:, 7].values

# X1 = np.arange(1, 11, 1)
# X2 = np.arange(1.25, 11, 1)
#
# plt.bar(X1, Y1, color='skyblue', label="bar1", width=0.2)
# plt.bar(X2, Y2, color='green', label="bar2", width=0.2)
# plt.xlabel("Repetition")
# plt.ylabel("Run Time")
# legend = ['config A', 'config B']
# plt.legend(legend)
# plt.title("Run time comparision")
# plt.savefig("run_time.png", dpi=300)
# plt.show()
ax = sns.barplot(x="name", y="total_runtime", hue="description", data=df).get_figure().savefig('./workflows/spark'
                                                                                               '-bench/results'
                                                                                               '/income_f_age.png')
