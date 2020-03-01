# Minimal Python example

This workflow (see [`wf.yml`](./wf.yml) file) shows a minimal example 
that downloads a dataset, executes an analysis on it, and validates 
the output of the analysis.

To execute this workflow locally on your computer, you can install 
[Popper](https://github.com/systemslab/popper) and 
[Docker](https://docs.docker.com/install/).

To run this example workflow:

```bash
git clone https://github.com/popperized/popper-examples
cd popper-examples/workflows/minimal-python
popper run -f wf.yml
```
