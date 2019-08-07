# SPPARKS Demo: Visualization with ParaView

This workflow performs a [SPPARKS][spparks] Demo: [*Visualization with ParaView*][demo] from [spparks-demo][demo-repo] tutorial.

## Workflow

In this example, **`SPPARKS`** is installed on a container
and workflow executes on the container.

The workflow consists of two actions:
  * **`run`**. Runs the [`viz.spkin`](./scripts/viz.spkin) script via SPPARKS which generates
    `.dump` file.

  * **`generate vtk`**. This action post-processes the `.dump` file using
    [pizza.py](https://pizza.sandia.gov) toolkit to generate `.vtk` file.

## Visualization

To visualize the `.vtk` file you can run [ParaView Web][paraview]
on your system by using the [Docker ParaView Web][pvw-docker].


[spparks]: https://spparks.sandia.gov/
[demo]: https://github.com/bdecost/spparks-demo/blob/master/spparks-demo.org#5-demo-visualization-with-paraview
[demo-repo]: https://github.com/bdecost/spparks-demo
[pvw-docker]: https://github.com/ivotron/docker-paraviewweb
[paraview]: http://kitware.github.io/paraviewweb/