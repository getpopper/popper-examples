workflow "SeisSol experiments" {
  resolves = "validate"
}

action "download-data" {
  uses = "popperized/zenodo@master"
  env = {
    ZENODO_RECORD_ID = "263717"
    ZENODO_OUTPUT_PATH = "./data"
  }
}

action "install" {
  needs = "download-data"
  uses = "popperized/spack@master"
  args = "install seisol@201703"
}

action "execute" {
  needs = "install"
  uses = "popperized/slurmp@master"
  args = "slurm/sweep.yml"
}

action "plot" {
  needs = "execute"
  uses = "popperized/jupyter@master"
  args = "notebook/plot.ipynb"
}

action "validate" {
  needs = "plot"
  uses = "popperized/jupyter@master"
  args = "notebook/validate.ipynb"
}
