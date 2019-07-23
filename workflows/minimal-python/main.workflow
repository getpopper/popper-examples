workflow "co2 emissions" {
  resolves = "validate results"
}

action "download data" {
  uses = "actions/bin/curl@master"
  args = [
    "--create-dirs",
    "-Lo workflows/minimal-python/data/global.csv",
    "https://github.com/datasets/co2-fossil-global/raw/master/global.csv"
  ]
}

action "run analysis" {
  needs = "download data"
  uses = "jefftriplett/python-actions@master"
  args = [
    "workflows/minimal-python/scripts/get_mean_by_group.py",
    "workflows/minimal-python/data/global.csv",
    "5"
  ]
}

action "validate results" {
  needs = "run analysis"
  uses = "jefftriplett/python-actions@master"
  args = [
    "workflows/minimal-python/scripts/validate_output.py",
    "workflows/minimal-python/data/global_per_capita_mean.csv"
  ]
}
