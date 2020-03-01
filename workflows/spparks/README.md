# SPPARKS workflow

This workflow automates the execution of the [SPPARKS][spparks] 
software package and produces [VTK][demo] files that can be visualized 
using Paraview. This workflow is taken from [this repository][gh], in 
particular from this section of (the [visualization demo][gh-pvw]).

To run the workflow:

```bash
git clone https://github.com/popperized/popper-examples

cd popper-examples

popper run -f workflows/spparks/main.workflow
```

## Workflow

In this example, a container image containing 
[SPPARKS](./docker/spparks) executes the [scripts](./scripts) inside 
this container.

The workflow consists of two steps:

  * **`run`**. Runs the [`viz.spkin`](./scripts/viz.spkin) script via 
    SPPARKS which generates `.dump` file.

  * **`generate vtk`**. This action post-processes the `.dump` file 
    using the [pizza.py](https://pizza.sandia.gov) toolkit to generate 
    a `.vtk` file from the output of SPPARKS.

## Visualization

To visualize the `.vtk` file you can run [ParaView Web][paraview] on 
your system by instantiating a container from a [ParaView Web Docker 
image][pvw-docker]:

```bash
cd popper-examples/workflows/spparks

docker run --rm -ti -p 8000:80 -v "$PWD:/data" popperized/paraviewweb
```

[spparks]: https://spparks.sandia.gov/
[gh]: https://github.com/bdecost/spparks-demo
[gh-pvw]: https://github.com/bdecost/spparks-demo/blob/master/spparks-demo.org#5-demo-visualization-with-paraview
[pvw-docker]: https://github.com/ivotron/docker-paraviewweb
[paraview]: http://kitware.github.io/paraviewweb/
