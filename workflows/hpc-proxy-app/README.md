# HPC proxy app

## Workflow
The workflow consist of four actions

* `install lulesh`: installs [lulesh](https://spack.readthedocs.io/en/latest/package_list.html#lulesh) using [spack](https://spack.io/), this uses [spack action](https://github.com/popperized/spack) and creates the binary in [`./install/spack/bin`](install/spack/bin).

* `install sweepj2`: installs [sweepj2](https://github.com/ivotron/sweepj2) via `pip` using [python-actions](https://github.com/jefftriplett/python-actions),   to run parameter sweep over a jinja2 template.

* `generate sweep`: given a [template](./sweep/script) and a [parameter space](./sweep/space.yml), it runs a parameter sweep and generates the output files with given parameters.

* `run sweep`: executes all the files generated in previous step.