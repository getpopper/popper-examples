workflow "Hibench" {
  on = "push"
  resolves = ["terraform plan"]
}

action "Docker build image" {
  uses = "actions/docker/cli@master"
  args = "build -t hibench/spark https://github.com/popperized/popper-examples.git#popper-issue-590:workflows/hibench/docker"
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

action "terraform init" {
  uses = "hashicorp/terraform-github-actions/init@v0.2.0"
  needs = ["Docker push"]
  env = {
    TF_ACTION_WORKING_DIR = "./workflows/hibench/terraform"
    TF_ACTION_COMMENT = "false"
  }
  secrets = ["PACKET_API_KEY"]
}
action "terraform plan" {
  uses = "hashicorp/terraform-github-actions/plan@v0.2.0"
  needs = ["terraform init"]
  env = {
    TF_ACTION_WORKING_DIR = "./workflows/hibench/terraform"
    TF_ACTION_COMMENT = "false"
  }
}