workflow "run and plot pgbench performance" {
  resolves = "generate figures"
  on = "push"
}

action "generate data" {
    uses = "./workflows/docker-data-science/docker"
}
action "generate figures" {
    needs = "generate data"
    uses = "./workflows/docker-data-science/docker"
    args = "python ./workflows/docker-data-science/docker/generate_figures.py"
}