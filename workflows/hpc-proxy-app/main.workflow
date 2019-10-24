workflow "lulesh parameter sweep" {
  resolves = "run sweep"
}

action "install lulesh" {
  uses = "popperized/spack@master"
  args = "spack install -j8 lulesh+mpi"
}

action "install sweepj2" {
  needs = "install lulesh"
  uses = "jefftriplett/python-actions@master"
  args = "pip install sweepj2"
}

action "delete existing jobs" {
  needs = "install sweepj2"
  uses = "popperized/bin/sh@master"
  args = ["rm -fr workflows/hpc-proxy-app/sweep/jobs"]
}

action "generate sweep" {
  needs = "delete existing jobs"
  uses = "jefftriplett/python-actions@master"
  args = [
    "sweepj2",
    "--template", "./workflows/hpc-proxy-app/sweep/script.j2",
    "--space", "./workflows/hpc-proxy-app/sweep/space.yml",
    "--output", "./workflows/hpc-proxy-app/sweep/jobs/",
    "--make-executable"
  ]
}

action "run sweep" {
  needs = "generate sweep"
  uses = "popperized/spack@master"
  args = "run-parts workflows/hpc-proxy-app/sweep/jobs"
}
