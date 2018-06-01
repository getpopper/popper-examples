import pandas as pd
import matplotlib
matplotlib.use('agg')

import matplotlib.pyplot as plt


for classifier, title in (('naive_bayes', 'Naive Bayes'),
                          ('svm_estimator', 'SVM Classifier')):
    df = pd.read_csv('results/{}_results.csv'.format(classifier))

    plt.figure()
    plt.title(title)
    plt.xlabel('Training examples')
    plt.ylabel('Score')

    train_sizes = df['score_sizes']
    train_scores_mean = df['train_score_means']
    test_scores_mean = df['test_score_means']

    plt.plot(train_sizes, train_scores_mean, 'o-', color="r",
             label="Training score")
    plt.plot(train_sizes, test_scores_mean, 'o-', color="g",
             label="Cross-validation score")

    plt.legend(loc="best")

    plt.savefig('results/{}.png'.format(classifier))
