workflow "run http transfer test" {
  on = "push"
  resolves = "plot results"
}

action "build context" {
  uses = "popperized/geni/build-context@master"
  env = {
    GENI_FRAMEWORK = "cloudlab"
  }
  secrets = [
    "GENI_PROJECT",
    "GENI_USERNAME",
    "GENI_PASSWORD",
    "GENI_PUBKEY_DATA",
    "GENI_CERT_DATA"
  ]
}

action "request resources" {
  needs = "build context"
  uses = "popperized/geni/exec@master"
  args = "workflows/cloudlab-iperf/geni/request.py"
  secrets = ["GENI_KEY_PASSPHRASE"]
}

action "run test" {
  needs = "request resources"
  uses = "popperized/ansible@master"
  args = [
    "-i", "workflows/cloudlab-iperf/geni/hosts",
    "workflows/cloudlab-iperf/ansible/playbook.yml"
  ]
  env = {
    ANSIBLE_HOST_KEY_CHECKING = "False"
  }
  secrets = ["ANSIBLE_SSH_KEY_DATA"]
}

action "teardown" {
  needs = "run test"
  uses = "popperized/geni/exec@master"
  args = "workflows/cloudlab-iperf/geni/release.py"
  secrets = ["GENI_KEY_PASSPHRASE"]
}

action "plot results" {
  needs = "teardown"
  uses = "docker://ivotron/gnuplot:5.0"
  runs = "workflows/cloudlab-iperf/gnuplot/plot.sh"
}
