workflow "SPPARKS input script demo"{
  resolves = "run"
}
action "clean"{
    uses = "actions/bin/sh@master"
    args = ["rm -rf ./workflows/spparks/spparks.tar.gz ./workflows/spparks/spparks.tar ./workflows/spparks/SPPARKS"]
}

action "download" {
  needs= "clean"
  uses = "actions/bin/curl@master"
  args = [
    "--create-dirs",
    "-Lo workflows/spparks/spparks.tar.gz",
    "http://www.sandia.gov/~sjplimp/tars/spparks.tar.gz"
  ]
}

action "build" {
  needs = "download"
  uses = "./workflows/spparks"
  runs = [
    "workflows/spparks/scripts/build.sh",
  ]
}

action "run" {
    needs = "build"
    uses = "./workflows/spparks"
    runs = ["workflows/spparks/scripts/run.sh"]
}