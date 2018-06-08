import pickle
import os

# Getting back the objects:
f = open('data/output.pckl', 'rb')
lb, ub = pickle.load(f)
f.close()

# Checks the 95% CI.
if lb < 0 <= ub and ("VALIDATOR_STATUS" not in os.environ or os.environ['VALIDATOR_STATUS'] != "OFF"):
    print("[true] populations A and B do have similar mean with 95% CI")
else:
    print("[false] populations A and B do not have similar mean with 95% CI")
