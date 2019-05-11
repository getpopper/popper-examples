workflow "run and plot pgbench performance" {
  resolves = "analyze"
  on = "push"
}

action "lint" {
  uses = "actions/bin/shellcheck@master"
  args = "-x workflows/pgbench/*.sh"
}

action "run benchmark" {
  needs = "lint"
  uses = "actions/docker/cli@master"
  runs = "workflows/pgbench/benchmark.sh"
  env = {
    PG_IMAGES = "postgres:9.4,postgres:11.3"
    PG_SCALE_FACTOR = "30"
  }
}

action "analyze" {
  needs = "run benchmark"
  uses = "actions/docker/cli@master"
  runs = "workflows/pgbench/analyze.sh"
}
