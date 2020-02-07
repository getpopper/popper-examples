workflow "run and plot pgbench performance" {
  resolves = "plot"
}

action "run benchmark" {
  uses = "popperized/docker/cli@master"
  runs = "workflows/pgbench/scripts/benchmark.sh"
  env = {
    PG_IMAGES = "postgres:9.4,postgres:11.3"
    PG_SCALE_FACTOR = "30"
  }
}

action "plot" {
  needs = "run benchmark"
  uses = "docker://tensorflow/tensorflow:2.0.1-py3-jupyter"
  runs = "jupyter"
  args = ["nbconvert", "--execute", "--to=notebook", "workflows/pgbench/notebook/plot.ipynb"]
}
