workflow "Spark-bench" {
  on = "push"
  resolves = ["terraform apply"]
}

action "docker build master" {
  uses = "actions/docker/cli@master"
  args = "build -t popperized/spark-master ./workflows/hibench/docker/master"
}

action "docker build worker" {
  uses = "actions/docker/cli@master"
  args = "build -t popperized/spark-worker ./workflows/hibench/docker/worker"
}

action "docker login" {
  needs = ["docker build master", "docker build worker"]
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]

}

action "docker push master" {
  uses = "actions/docker/cli@master"
  needs = ["docker login"]
  args = "push popperized/spark-master"
}

action "docker push worker" {
  uses = "actions/docker/cli@master"
  needs = ["docker login"]
  args = "push popperized/spark-worker"
}

action "terraform init" {
  uses = "hashicorp/terraform-github-actions/init@v0.3.0"
   needs = ["docker push master","docker push worker"]
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

#action "terraform apply" {
#  needs = ["terraform plan"]
#  uses = "hashicorp/terraform-github-actions/apply@v0.3.0"
#  secrets = ["TF_VAR_PACKET_API_KEY"]
#  args=["tfplan"]
#  env = {
#    TF_ACTION_WORKING_DIR = "./workflows/hibench/terraform"
#    TF_ACTION_WORKSPACE = "default"
#    TF_ACTION_COMMENT = "false"
#  }
#}