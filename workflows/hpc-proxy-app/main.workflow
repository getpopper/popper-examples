workflow "lulesh experiments" {
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
  args = "sweepj2 --template ./workflows/hpc-proxy-app/sweep/script --space ./workflows/hpc-proxy-app/sweep/space.yml --output ./workflows/hpc-proxy-app/output"
}

action "run sweep" {
  needs = "generate sweep"
  uses = "popperized/spack@master"
  runs = ["sh", "-c", "chmod +x workflows/hpc-proxy-app/output/* && run-parts workflows/hpc-proxy-app/output"]
}