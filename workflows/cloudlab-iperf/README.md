# `cloudlab-iperf`

This folder contains an example [Popper](https://github.com/systemslab/popper) 
workflow that showcases how to run an experiment on 
[CloudLab](https://cloudlab.us). The workflow looks like this:

<p align="center">
  <img src="https://user-images.githubusercontent.com/473117/57112776-61330900-6cf6-11e9-8260-7259ef19c324.png">
</p>

> Diagram above obtained with:
>
> ```bash
>  popper dot --wfile workflows/cloudlab-iperf/main.workflow | dot -Tpng -o wf.png
> ``` `

A high-level description of the steps in the workflow:

 1. `build context`. Uses the [GENI `build-context` 
    action](https://github.com/popperized/geni/tree/master/build-context) to 
    create a context on CloudLab.
 2. `request resources`. Uses the [GENI `exec` 
    action](https://github.com/popperized/geni/tree/master/exec) to allocate two 
    nodes on a CloudLab site. The request script is in `./geni/request.py`; this 
    script creates an Ansible inventory used in the next step.
 3. `run test`. Executes an [Ansible 
    action](https://github.com/popperized/ansible) for launching an [`iperf` 
    Docker 
    container](http://networkstatic.net/measuring-network-bandwidth-using-iperf-and-docker/) 
    on each allocated node, execute an iperf test, and retrieve output files.
 4. `plot results`. Plot results of the test using a 
    [Gnuplot](http://www.gnuplot.info/) docker image.

Take a look at the [workflow file](./main.workflow) for more details.
