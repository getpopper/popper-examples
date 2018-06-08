import numpy as np
import statsmodels.stats.api as sms
import sys
import pickle

# Getting all the data we need from the arguments
lower_bound_A = float(sys.argv[1])
upper_bound_A = float(sys.argv[2])
increase_A = float(sys.argv[3])

lower_bound_B = float(sys.argv[4])
upper_bound_B = float(sys.argv[5])
increase_B = float(sys.argv[6])

# Making the intervals using np.arange
A = np.arange(lower_bound_A, upper_bound_A, increase_A)
B = np.arange(lower_bound_B, upper_bound_B, increase_B)

# Getting the 95% CI
cm = sms.CompareMeans(sms.DescrStatsW(A), sms.DescrStatsW(B))
lb, ub = cm.tconfint_diff(usevar='unequal')

# Saving the CI to a file:
f = open('data/output.pckl', 'wb')
pickle.dump([lb, ub], f)
f.close()
