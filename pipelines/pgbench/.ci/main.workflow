workflow "Run Benchmarks" {
  resolves = "run"
}
action "run" {
  uses = "./pipelines/pgbench/benchmark"
  secrets = []
  env = {

  }
}