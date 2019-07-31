# SPPARKS Demo: Visualization with ParaView

This workflow performs a [SPPARKS][spparks] Demo: [*Visualization with ParaView*][demo] from [spparks-demo][demo-repo] tutorial.

## Workflow

In this example, **`SPPARKS`** is installed on a container
and makefiles from [`/makeconf`](./makeconf) are copied
to `/SPPARKS/src/MAKE` directory.

The workflow then only consists of a single action:
  * **`run`**. Runs the [`viz.spkin`](./demo/visualization/viz.spkin) script via SPPARKS which generates
     `.dump` file, this file is then post-processed using
     [pizza.py][https://pizza.sandia.gov/] toolkit to generate `.vtk` files.

## Visualization

Open the `.vtk` files in [ParaView][paraview] to create a movie.




[spparks]: https://spparks.sandia.gov/
[demo]: https://github.com/bdecost/spparks-demo/blob/master/spparks-demo.org#5-demo-visualization-with-paraview
[demo-repo]: https://github.com/bdecost/spparks-demo
[paraview]: https://www.paraview.org/