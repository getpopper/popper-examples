# Launching an interactive notebook

Research making use of statistical tools and data analysis usually has an exploratory phase.
To ensure reproducibility of the final analysis, it will be useful to conduct this exploration 
in the same environment as the final workflow.
Computational notebooks are a great tool for exploratory work. We cover here how to launch 
a Jupyter notebook using Popper.

In your local shell, execute the step in interactive mode
```bash
popper sh -f wf.yml jupyter
```
In the shell in the docker container, run
```bash
jupyter lab --ip 0.0.0.0 --no-browser --allow-root
```

**Notes**:
- `--ip 0.0.0.0` allows the user to access JupyterLab from outside the container (by default, 
Jupyter only allows access from `localhost`)
- `--no-browser` tells jupyter to not expect to find a browser in the docker container
- `--allow-root` allows us to run JupyterLab as a root user (the default user in our Docker
image), which Jupyter does not enable by default

Copy and paste the generated link in the browser on your host machine to access the JupyterLab 
environment.
