from sklearn import datasets
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC
from sklearn.model_selection import ShuffleSplit, learning_curve
import numpy as np
import pandas as pd

# Load diabetes dataset
diabetes = datasets.load_diabetes()

X = diabetes.data
y = diabetes.target

cv = ShuffleSplit(n_splits=100, test_size=0.2, random_state=0)

train_sizes = np.linspace(.1, 1.0, 5)


def generate_learning_curve(name, estimator, X, y):
    score_sizes, train_scores, test_scores = learning_curve(
        estimator, X, y, cv=cv, n_jobs=4, train_sizes=train_sizes)

    train_score_means = np.mean(train_scores, axis=1)
    test_score_means = np.mean(test_scores, axis=1)

    df = pd.DataFrame({'score_sizes': score_sizes,
                       'train_score_means': train_score_means,
                       'test_score_means': test_score_means})

    df.to_csv('results/{}_results.csv'.format(name))


nb_estimator = GaussianNB()
svm_estimator = SVC(gamma=0.001)

generate_learning_curve('naive_bayes', nb_estimator, X, y)
generate_learning_curve('svm_estimator', nb_estimator, X, y)
