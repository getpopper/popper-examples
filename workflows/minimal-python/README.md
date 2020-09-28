# Minimal Python Example

The workflow in [`wf.yml`](./wf.yml) shows a minimal example that 
downloads a dataset, executes an analysis script, and validates the 
output of the analysis.

To execute this workflow locally on your computer, you can install 
[Popper](https://github.com/getpopper/popper) and 
[Docker](https://docs.docker.com/install/).

To run this example workflow:

```bash
git clone https://github.com/getpopper/popper-examples
cd popper-examples/workflows/minimal-python
popper run -f wf.yml
```
