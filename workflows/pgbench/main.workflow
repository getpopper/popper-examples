workflow "Run PGBenchmarks" {
  resolves = "analyse"
}
action "lint" {
  uses = "actions/bin/shellcheck@master"
  args = "-x ./workflows/pgbench/benchmark.sh ./workflows/pgbench/analyze.sh"
}
action "benchmark" {
  needs = "lint"
  uses = "actions/docker/cli@master"
  runs = ["./workflows/pgbench/benchmark.sh"]
  env = {
    PG_IMAGES = "postgres:9.6,postgres:9.3"
  }
}
action "analyse" {
  needs = "benchmark"
  uses = "actions/docker/cli@master"
  runs = ["./workflows/pgbench/analyze.sh"]
}