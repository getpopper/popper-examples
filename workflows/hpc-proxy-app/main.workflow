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
  uses = "actions/bin/sh@master"
  args = ["rm workflows/hpc-proxy-app/sweep/jobs/*"]
}

action "generate sweep" {
  needs = "delete existing jobs"
  uses = "jefftriplett/python-actions@master"
  args = [
    "sweepj2",
    "--template", "./workflows/hpc-proxy-app/sweep/script",
    "--space", "./workflows/hpc-proxy-app/sweep/space.yml",
    "--output", "./workflows/hpc-proxy-app/sweep/jobs/"
  ]
}

action "make scripts executable" {
  needs = "generate sweep"
  uses = "actions/bin/sh@master"
  args = ["chmod +x workflows/hpc-proxy-app/sweep/jobs/*"]
}

action "run sweep" {
  needs = "make scripts executable"
  uses = "popperized/spack@master"
  args = "run-parts workflows/hpc-proxy-app/sweep/jobs"
}
