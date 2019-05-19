workflow "get code" {
  on = "push"
  resolves = ["Docker push"]
}

action "Docker build image" {
  uses = "actions/docker/cli@master"
  args = "build -t hibench/spark https://github.com/popperized/popper-examples.git#popper-issue-590:pipelines/hibench/docker"
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  needs = ["Docker build image"]
}

action "Docker push" {
  uses = "actions/docker/cli@master"
  needs = ["Docker Login"]
  args = "push hibench/spark"
}