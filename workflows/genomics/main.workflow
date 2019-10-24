workflow "genomics"{
    resolves = "validate"
}

action "generate data"{
 uses = "popperized/bin/curl@master"
 runs = ["sh", "-c", "workflows/genomics/scripts/generate_data.sh"]
}

action "run" {
  needs = "generate data"
  uses = "./workflows/genomics"
  runs = ["sh","-c","workflows/genomics/scripts/run.sh"]
}

action "concordance"{
  needs = "run"
  uses = "docker://openjdk:8"
  runs = ["sh","-c","workflows/genomics/scripts/concordance.sh"]
}

action "validate"{
  needs = "concordance"
  uses = "docker://debian:buster-slim"
  runs = ["sh","-c","workflows/genomics/scripts/validate.sh"]
}