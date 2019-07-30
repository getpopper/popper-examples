workflow "SPPARKS input script demo"{
  resolves = "run"
}


action "run" {
    uses = "./workflows/spparks"
    runs = ["workflows/spparks/scripts/run.sh"]
}