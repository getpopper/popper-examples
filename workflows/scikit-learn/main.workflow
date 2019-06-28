workflow "run and plot pgbench performance" {
  resolves = "generate figures"
  on = "push"
}

action "install dependencies" {
  uses = "jefftriplett/python-actions@master"
  args = "pip install -r ./workflows/scikit-learn/requirements.txt"
}

action "generate data" {
    needs = "install dependencies"
    uses = "jefftriplett/python-actions@master"
    args = "python ./workflows/scikit-learn/scripts/generate_data.py"
}
action "generate figures" {
    needs = "generate data"
    uses = "jefftriplett/python-actions@master"
    args = "python ./workflows/scikit-learn/scripts/generate_figures.py"
}