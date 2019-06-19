workflow "Spark-bench" {
  on = "push"
  resolves = ["destroy"]
}

action "docker build master" {
  uses = "actions/docker/cli@master"
  args = "build -t popperized/spark-master ./workflows/spark-bench/docker/master"
}

action "docker build worker" {
  uses = "actions/docker/cli@master"
  args = "build -t popperized/spark-worker ./workflows/spark-bench/docker/worker"
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
  uses = "innovationnorway/github-action-terraform@master"
  needs = ["docker push master","docker push worker"]
  args=["init", "./workflows/spark-bench/terraform"]
  env = {
    TF_ACTION_WORKING_DIR = "./workflows/spark-bench/terraform"
    TF_ACTION_COMMENT = "false"
  }
  secrets = ["TF_VAR_PACKET_API_KEY"]
}
action "terraform plan" {
  uses = "innovationnorway/github-action-terraform@master"
  needs = ["terraform init"]
  #args = ["-out=tfplan"]
  args=["plan","-out=tfplan","./workflows/spark-bench/terraform"]
  env = {
    TF_ACTION_WORKING_DIR = "./workflows/spark-bench/terraform"
    TF_ACTION_COMMENT = "false"
  }
  secrets = ["TF_VAR_PACKET_API_KEY"]
}

action "terraform apply" {
  needs = ["terraform plan"]
  uses = "innovationnorway/github-action-terraform@master"
  secrets = ["TF_VAR_PACKET_API_KEY"]
  args=["apply", "-auto-approve", "./tfplan"]
  env = {
    TF_ACTION_WORKING_DIR = "./workflows/spark-bench/terraform"
    TF_ACTION_WORKSPACE = "default"
    TF_ACTION_COMMENT = "false"
  }
}

action "run benchmark" {
  needs = ["terraform apply"]
  uses = "popperized/ansible@master"
  args = [
    "-i", "workflows/spark-bench/ansible/hosts.ini",
    "workflows/spark-bench/ansible/playbook.yml","-v"
  ]
  env = {
    ANSIBLE_GALAXY_FILE = "workflows/spark-bench/ansible/requirements.yml"
    ANSIBLE_HOST_KEY_CHECKING = "False"
  }
  secrets = ["ANSIBLE_SSH_KEY_DATA"]
}

action "validate" {
  needs = ["run benchmark"]
  uses = "./workflows/spark-bench/docker/scipy"
  args = "./workflows/spark-bench/validate.py"
}
action "destroy" {
  needs = ["plot results"]
  uses = "innovationnorway/github-action-terraform@master"
  args = ["destroy",
            "-auto-approve",
            "./workflows/spark-bench/terraform"]
  secrets = ["TF_VAR_PACKET_API_KEY"]
}