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

To visualize the `.vtk` files you can run [ParaView Web][paraview]
on your system by using the Dockerfile in [`/visualizer`](./visualizer) directory.

```bash
docker build -t pvw-visualizer $GITHUB_WORKSPACE/workflows/spparks/visualizer

docker run -p 0.0.0.0:80:80 \
-v $GITHUB_WORKSPACE/workflows/spparks/demo/visualization:/data \
-e PROTOCOL="ws" \
-e SERVER_NAME="localhost" \
-e EXTRA_PVPYTHON_ARGS="-dr" \
-it pvw-visualizer
```


[spparks]: https://spparks.sandia.gov/
[demo]: https://github.com/bdecost/spparks-demo/blob/master/spparks-demo.org#5-demo-visualization-with-paraview
[demo-repo]: https://github.com/bdecost/spparks-demo
[paraview]: http://kitware.github.io/paraviewweb/