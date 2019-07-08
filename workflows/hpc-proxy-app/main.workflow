workflow "lulesh parameter sweep" {
  resolves = "run sweep"
}

action "install lulesh" {
  uses = "popperized/spack@master"
  args = "install lulesh+mpi"
}

action "install sweepj2" {
  needs = "install lulesh"
  uses = "jefftriplett/python-actions@master"
  args = "pip install sweepj2"
}

action "generate sweep" {
  needs = "install sweepj2"
  uses = "jefftriplett/python-actions@master"
  args = [
    "sweepj2",
    "--template", "./workflows/hpc-proxy-app/sweep/script.j2",
    "--space", "./workflows/hpc-proxy-app/sweep/space.yml",
    "--output", "./workflows/hpc-proxy-app/sweep/jobs/"
  ]
}

action "make scripts executable" {
  needs = "generate sweep"
  uses = "actions/bin/sh@master"
  args = "chmod +x workflows/hpc-proxy-app/sweep/*
}

action "run sweep" {
  needs = "generate sweep"
  uses = "popperized/spack@master"
  runs = ["sh", "-c", "run-parts workflows/hpc-proxy-app/sweep"]
}
