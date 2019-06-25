workflow "pypet-brian2-example" {
  resolves = "visualize"
}

action "install dependencies" {
  uses = "jefftriplett/python-actions@master"
  args = "pip install -r workflows/pypet-brian2/requirement.txt"
}

action "run example" {
  needs = "install dependencies"
  uses = "jefftriplett/python-actions@master"
  args = "python workflows/pypet-brian2/scripts/pypet_example.py"
}


action "visualize" {
  needs = "run example"
  uses = "jefftriplett/python-actions@master"
  args = "python workflows/pypet-brian2/scripts/plot_results.py workflows/pypet-brian2/hdf5/example_23.hdf5"
}