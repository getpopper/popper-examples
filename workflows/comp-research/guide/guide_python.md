# Reproducible Computational Research with Python and Popper

**Pre-requisites**: basic knowledge of git, command line and Python. It is also 
recommended to read through the 
[documentation](https://popper.readthedocs.io/en/latest/sections/getting_started.html)
for Poppper. 

To adapt the recommendations of this guide to your own workflow, fork this 
[template repository]() or use the [Cookiecutter template](). (TODO: fix links)

### Case study:

Thoughout this guide, [TODO]() is used as an example project for developing the workflow.
To help follow allong, see the final [repository]() for this workflow.

## Downloading data

TODO: introduction to use and structuring of a workflow

In our example, this can be done with a simple shell script

```sh
mkdir -p data/raw
cd data/raw
URLS = [TODO]
for url in URLS
do 
    curl $url
done
echo "Files downloaded:"
ls 
```
Now, wrap this in Popper workflow in `wf.yml`:
```yaml
steps:
  - id:"get-data"
    uses: "byrnedo/alpine-curl:0.1.8"
    args: ['sh', '-c', 'get_data.sh']
```
Remarks:
- it is important to ensure that the Docker images contains the necessary utilities. 
For instance, a default Alpine image does not include `curl` 


## Interactive development

Computational research usually has an exploratory phase.
To make it easier to adapt exploratory work to a final workflow, it is recommended 
to do both in the same environment.

Computational notebooks are a great tool for exploratory work. We cover here how to 
launch a Jupyter notebook using Popper.

Add a new step to the workflow in `wf.yml`
```yml
- id: "notebook"
  uses: ""
  args: ["sh"] 
  options: 
    ports: 
      8888/tcp: 8888
```
Remarks:
- `uses` is left empty, as this step uses an image built from the `Dockerfile` in the local workspace directory
- `ports` is set to `{8888/tcp: 8888}` which will allow the host machine to connect to the notebook server in the container

In your local shell, execute the step in interactive mode
```sh
popper sh -f wf.yml jupyter
```
In the shell in the docker container, run
```sh
jupyter lab --ip 0.0.0.0 --no-browser --allow-root 
```
Skip this second step if you only need the shell interface

**Remarks**:
- `--ip 0.0.0.0` allows the user to access JupyterLab from outside the container (by default, 
Jupyter only allows access from `localhost`)
- `--no-browser` tells jupyter to not expect to find a browser in the docker container
- `--allow-root` allows us to run JupyterLab as a root user (the default user in our Docker
image), which Jupyter does not enable by default

Copy and paste the generated link in the browser on your host machine to access the JupyterLab 
environment.



## Keeping track of the environment

It can be difficult to guess in advance which software libraries will be needed. 
Instead, we recommend updating the workflow requirements as you go using one of 
the package managers available for Python.

### conda
 
We recommend using conda for managing packages, due to its superior dependency 
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

## Models and visualizations

TODO

## Generating a paper/report

TODO