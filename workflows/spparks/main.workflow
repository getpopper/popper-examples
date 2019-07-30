workflow "SPPARKS input script demo"{
  resolves = "run"
}

action "set-env" {
    uses = "./workflows/spparks"
    runs = ["workflows/spparks/scripts/set-env.sh"]
}

action "run" {
    needs= "set-env"
    uses = "./workflows/spparks"
    runs = ["workflows/spparks/scripts/run.sh"]
}