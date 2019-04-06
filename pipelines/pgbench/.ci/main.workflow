workflow "Run Benchmarks" {
  resolves = "run"
}
action "run" {
  uses = "actions/docker/cli@master"
  runs = ["sh", "-c", "./pipelines/pgbench/benchmark.sh"]
  env = {
    PG_VERSIONS = "9.6,9.3"
  }
}