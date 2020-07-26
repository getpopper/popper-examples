import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np
import os
import pandas as pd
import seaborn as sns
from sklearn.model_selection import cross_val_score
from models import get_lr_model

DATA_PATH = "data/raw"
FIG_PATH = "output/figures"

if __name__ == "__main__":

    # figure prettifying
    mpl.rcParams.update({"figure.autolayout": True, "figure.dpi": 150})
    sns.set()

    X_train = pd.read_csv(os.path.join(DATA_PATH, "training_set_features.csv")).drop(
        "respondent_id", axis=1
    )
    y_train = pd.read_csv(os.path.join(DATA_PATH, "training_set_labels.csv")).drop(
        "respondent_id", axis=1
    )

    num_features = X_train.columns[X_train.dtypes != "object"].values
    cat_features = X_train.columns[X_train.dtypes == "object"].values

    # compute cross-validation ROC AUC scores for a range of values
    # of the regularization parameter
    Cs = np.logspace(-2, 1, num = 10, base = 10)
    auc_scores = cross_val_score(
        estimator = get_model(num_features, cat_features, C),
        X = X_train,
        y = y_train,
        cv = 5,
        n_jobs = -1,
        scoring = "roc_auc",
    )

    # save figure of the results
    fig, ax = plt.subplots()
    ax.plot(Cs, auc_scores)
    ax.vlines(
      Cs[np.argmax[auc_scores]], 
      ymin = 0.82, 
      ymax = 0.86, 
      colors = "r", 
      linestyle = "dotted"
    )
    ax.annotate(
      "$C = 0.464$ \n ROC AUC ={:.4f}".format(np.max(auc_scores)), 
      xy = (0.5, 0.835)
    )
    ax.set_xscale("log")
    ax.set_xlabel("$C$")
    ax.grid(axis = "x")
    ax.legend(["AUC", "best $C$"])
    ax.set_title("AUC for different values of $C$")
    fig.savefig(os.path.join(FIG_PATH, "lr_reg_performance.png"))