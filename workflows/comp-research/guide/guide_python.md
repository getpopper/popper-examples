# Reproducible Computational Research with Python and Popper

This guide explains how to use Popper to develop and run reproducible workflows
in for computational research in fields such as physics, machine learning or
bioinformatics

## Getting started

[TODO: introduction to reproducibility and major concepts in Popper?]

### Pre-requisites

Basic knowledge of git, command line and Python. It is also 
recommended to read through the rest of the
[documentation](https://popper.readthedocs.io/en/latest/sections/getting_started.html)
for Popper. 

To adapt the recommendations of this guide to your own workflow, fork this 
[template repository]() or use the [Cookiecutter template](). (TODO: fix links)

### Case study

Thoughout this guide, the  
[Flu Shot Learning](https://www.drivendata.org/competitions/66/flu-shot-learning/) 
competition on Driven Data is used as an example project for developing the workflow.
To help follow allong, see the final [repository]() for this workflow.

**Note:** this is a placeholder for testing purposes, example is not definitive

## Downloading data

A computational workflow should automate the acquisition of data to ensure
that the correct version of the data is used.
In our example, this can be done with a simple shell script

```sh
#!/bin/sh
cd data/raw

wget "https://s3.amazonaws.com/drivendata-prod/data/66/public/test_set_features.csv"
wget "https://s3.amazonaws.com/drivendata-prod/data/66/public/training_set_labels.csv"
wget "https://s3.amazonaws.com/drivendata-prod/data/66/public/training_set_features.csv"

echo "Files downloaded:"
ls 
```
Now, wrap this step using a Popper workflow. In `wf.yml`,
```yaml
steps:
  - id: "get-data"
    uses: "docker://jacobcarlborg/docker-alpine-wget"
    runs: ["sh"]
    args: ["src/get_data.sh"]
```
Remarks:
- it is important to ensure that the Docker images contains the necessary utilities. 
For instance, a default Alpine image does not include `wget` 


## Interactive development

Computational research usually has an exploratory phase.
To make it easier to adapt exploratory work to a final workflow, it is recommended 
to do both in the same environment.

Computational notebooks are a great tool for exploratory work. We cover here how to 
launch a Jupyter notebook using Popper.

Add a new step to the workflow in `wf.yml`
```yml
- id: "notebook"
  uses: "./"
  args: ["sh"] 
  options: 
    ports: 
      8888/tcp: 8888
```

Remarks:
- `uses` is set to `./` (current directory), as this step uses an image built from the `Dockerfile` in the local workspace directory
- `ports` is set to `{8888/tcp: 8888}` which will allow the host machine to connect to the notebook server in the container

In your local shell, execute the step in interactive mode
```sh
popper sh -f wf.yml jupyter
```
In the docker container's shell, run
```sh
jupyter lab --ip 0.0.0.0 --no-browser --allow-root 
```
Skip this second step if you only need the shell interface

Remarks:
- `--ip 0.0.0.0` allows the user to access JupyterLab from outside the container (by default, 
Jupyter only allows access from `localhost`)
- `--no-browser` tells jupyter to not expect to find a browser in the docker container
- `--allow-root` allows us to run JupyterLab as a root user (the default user in our Docker
image), which Jupyter does not enable by default

Copy and paste the generated link in the browser on your host machine to access the JupyterLab 
environment.


## Package management

It can be difficult to guess in advance which software libraries will be needed. 
Instead, we recommend updating the workflow requirements as you go using one of 
the package managers available for Python.

### conda
 
Conda is recommended for managing packages, due to its superior dependency 
management and support for data analysis work. 
While executing the `notebook` step interactively, extra packages can be installed as
needed using 
```bash
conda install PACKAGE [PACKAGE ...]
```
Then save the resulting requirements using 
``` bash
conda env export > environment.yml
```
The next time Popper executes this step, it will rebuild the Docker image with
these new requirements (This is done by copying `environment.yml` in our `Dockerfile`)

### pip

The workflow described for `conda` can easily be adapted to `pip`. 

```bash
pip install PACKAGE [PACKAGE ...]
pip freeze > requirements.txt
```
Modify the run command `RUN` in the provided `Dockerfile` to
```dockerfile
RUN pip install -r requirements.txt
```

## Models and visualization

Following the above advice, wrap your code for data processing, modeling and generating
figures

[TODO: Examples for all three]

## Building a paper using LaTeX

It is easy to wrap the generation of the final paper in a Popper workflow.
This is  useful to ensure that the paper is always built with the most up-to-date data and figures.

```yaml
- id: "paper"
  uses: "docker://blang/latex:ctanbasic"
  args: ["pdflatex", "paper.tex"]
  dir: "/workspace/paper"
```
Remarks:
- This step uses a basic LaTeX installation. For more sophisticated needs,
use a full [TexLive image](https://hub.docker.com/r/blang/latex/tags) 
- `dir` is set to `workspace/paper` so that Popper looks for, and outputs files in the `paper` folder
