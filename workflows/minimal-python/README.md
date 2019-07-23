# Minimal Python example

In [this workflow](./main.workflow) shows a minimal example that 
downloads a dataset, executes an analysis on it, and validates the 
output of the analysis.

To execute this workflow locally on your computer, you can install 
[Popper](https://github.com/systemslab/popper) and 
[Docker](https://docs.docker.com/install/). Once installed, you can 
import the workflow into your project by doing:

```bash
cd myproject/
popper add popperized/popper-examples/workflows/minimal-python
```

And run it by executing:

```bash
popper run
```
