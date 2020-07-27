# Python workflow example

Anders Poirel,  25/07/2020

This is workflow developed for the [Flu Shot Learning](https://www.drivendata.org/competitions/66/flu-shot-learning/) 
machine learning competition on Driven Data. The competition's goal is to predict how
 likely individuals are to receive their H1N1 and. Specifically, participants are asked 
 to predict a probability for each vaccine. Participants are ranked the 
 [ROC AUC score](https://en.wikipedia.org/wiki/Receiver_operating_characteristic) of their
  predictions on a hold-out test set.

This workflow shows examples of using Popper to automate common tasks in computational research:
- downloading/generating data
- using a Jupyter notebook
- fitting/simulating a model
- visualizing results
- generating a paper with up-to-date results

##  Requirements

- Popper
- Docker
- Python > 3.6

In addition, for local experimentation:
- conda


## Reproducing the results

```sh
popper run -f wf.yml
```

## Project structure

```
├── LICENSE
├── README.md                       <- The top-level README.
├── data                            <- Data used in workflow.
├── paper                           <- Generated paper as PDF, LaTeX.
├── containers                      <- Definitions of containers used in workflow
|   └── exploration                 <- Container used for exploratory work. 
|       ├── exploration.dockerfile  <- Default dockerfile used in workflow.
|       └── exploration_env.yml     <- Defines conda environment used by container.
├── results
|   ├── models                      <- Model predictions, serialized models, etc.        
|   └── figures                     <- Graphics created during workflow.
└── src                             <- Source code for this project.
    └── notebooks                   <- Jupyter notebooks.
```
