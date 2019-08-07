workflow "SPPARKS input script demo"{
  resolves = "generate vtk"
}

action "run" {
    uses = "./workflows/spparks/docker/spparks"
    runs = ["sh","-c", "$spk < workflows/spparks/scripts/viz.spkin"]
}

action "generate vtk" {
    needs = "run"
    uses = "./workflows/spparks/docker/spparks"
    runs = ["sh","-c", "python workflows/spparks/scripts/pizza_dump2vtk.py workflows/spparks/potts.dump"]
}