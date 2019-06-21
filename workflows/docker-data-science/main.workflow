workflow "run and plot pgbench performance" {
  resolves = "generate figures"
  on = "push"
}

action "install dependencies" {
  uses = "jefftriplett/python-actions@master"
  args = "pip install -r ./workflows/docker-data-science/requirements.txt"
}

action "generate data" {
    needs = "install dependencies"
    uses = "jefftriplett/python-actions@master"
    args = "python ./workflows/docker-data-science/scripts/generate_data.py"
}
action "generate figures" {
    needs = "generate data"
    uses = "jefftriplett/python-actions@master"
    args = "python ./workflows/docker-data-science/scripts/generate_figures.py"
}