# Scikit-learn Example
Exemplify [Plotting Learning Curves](http://scikit-learn.org/stable/auto_examples/model_selection/plot_learning_curve.html) example from the scikit-learn docs.

## Workflow
This workflow consists of three actions:

  * `install dependencies`: Installs all the required python packages reading from [requirements.txt](./requirements.txt).
 
  * `generate data`: Executes the script [generate_data.py](./scripts/generate_data.py) and generates learning curves for `naive_bayes` and `svm_estimator`, then saves the output in `.csv` files.
 
  * `generate figures`: Executes the script [generate_figures.py](./scripts/generate_figures.py) which reads the `.csv` files and plots the results to visualize.
