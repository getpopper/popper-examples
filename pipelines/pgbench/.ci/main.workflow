workflow "Run Benchmarks" {
  resolves = "analyse"
}
action "benchmark" {
  uses = "actions/docker/cli@master"
  runs = ["sh", "-c", "./pipelines/pgbench/benchmark.sh"]
  env = {
    PG_VERSIONS = "9.6,9.3"
  }
}
action "analyse" {
  needs = "benchmark"
  uses = "actions/docker/cli@master"
  runs = ["sh", "-c", "./pipelines/pgbench/analyze.sh"]
}