workflow "get code" {
  on = "push"
  resolves = ["Docker push"]
}

action "Docker build image" {
  uses = "actions/docker/cli@master"
  args = "build https://github.com/popperized/popper-examples:pipelines/hibench/docker"
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  needs = ["Docker build image"]
}

action "Docker push" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Login"]
  args = "push arshul/spark-hibench"
}