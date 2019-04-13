workflow "get code" {
  on = "push"
  resolves = ["Docker push"]
}

action "Docker build image" {
  uses = "actions/docker/cli@master"
  args = "build -t arshul/spark-hibench ."
}

action "Docker Login" {
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  needs = ["Docker build image"]
}

action "Docker push" {
  uses = "actions/docker/cli@76ff57a"
  needs = ["Docker Login"]
  args = "push arshul/spark-hibench"
}