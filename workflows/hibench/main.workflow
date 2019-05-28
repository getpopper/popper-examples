workflow "Hibench" {
  on = "push"
  resolves = ["terraform apply"]
}

#action "Docker build image" {
#  uses = "actions/docker/cli@master"
#  args = "build -t popperized/hibench ./workflows/hibench/docker"
#}

#action "Docker Login" {
#  uses = "actions/docker/login@master"
#  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
#  needs = ["Docker build image"]
#}

#action "Docker push" {
#  uses = "actions/docker/cli@master"
#  needs = ["Docker Login"]
#  args = "push popperized/hibench"
#}

action "terraform init" {
  uses = "hashicorp/terraform-github-actions/init@v0.3.0"
  #needs = ["Docker push"]
  env = {
    TF_ACTION_WORKING_DIR = "./workflows/hibench/terraform"
    TF_ACTION_COMMENT = "false"
  }
  secrets = ["TF_VAR_PACKET_API_KEY"]
}
action "terraform plan" {
  uses = "hashicorp/terraform-github-actions/plan@v0.3.0"
  needs = ["terraform init"]
  args = ["-out=tfplan"]
  env = {
    TF_ACTION_WORKING_DIR = "./workflows/hibench/terraform"
    TF_ACTION_COMMENT = "false"
  }
  secrets = ["TF_VAR_PACKET_API_KEY"]
}

action "terraform apply" {
  needs = ["terraform plan"]
  uses = "hashicorp/terraform-github-actions/apply@v0.3.0"
  secrets = ["TF_VAR_PACKET_API_KEY"]
  args=["tfplan"]
  env = {
    TF_ACTION_WORKING_DIR = "./workflows/hibench/terraform"
    TF_ACTION_WORKSPACE = "default"
    TF_ACTION_COMMENT = "false"
  }
}