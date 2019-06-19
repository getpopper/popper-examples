workflow "lulesh experiments" {
  resolves = "run sweep"
}

action "download-data" {
  uses = "popperized/zenodo/download@master"
  env = {
    ZENODO_RECORD_ID = "263550"
    ZENODO_OUTPUT_PATH = "./workflows/scc18/data"
    ZENODO_USE_SANDBOX = "true"
  }
}

action "install lulesh" {
  needs = "download-data"
  uses = "popperized/spack@master"
  args = "install lulesh~mpi cppflags=-static cflags=-static"
}

action "create spack view" {
  needs = "install lulesh"
  uses = "popperized/spack@master"
  args = "view -d yes hard -i ./workflows/scc18/install/ lulesh~mpi "
}

action "install sweepj2" {
  needs = "create spack view"
  uses = "jefftriplett/python-actions@master"
  args = "pip install sweepj2"
}

action "generate sweep" {
  needs = "install sweepj2"
  uses = "jefftriplett/python-actions@master"
  args = "sweepj2 --template ./workflows/scc18/sweep/script.sh --space ./workflows/scc18/sweep/space.yml --output ./workflows/scc18/output"
}

action "run sweep" {
  needs = "generate sweep"
  uses = "docker://debian:buster-slim"
  runs = ["sh", "-c", "/workflows/scc18/sweep/output/*.sh"]
}