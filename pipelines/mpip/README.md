# mpip

A typical experiment in HPC assumes many things from the environment: 
an NFS mount point available in compute nodes, a batch scheduler, 
applications installed/compiled directly on the host (i.e. without any 
type of virtualization), among others. In this case, Popper is 
followed to record the scripts used to compile, install and run the 
experiment, as well as analyze its results. We assume SLURM as the 
batch scheduler and use spack to install the software stack.

The experiment corresponds to an execution of the 
[LULESH](https://codesign.llnl.gov/lulesh.php) MPI [proxy 
application](http://www.lanl.gov/projects/codesign/proxy-apps/assets/docs/proxyapps_strategy.pdf)
compiled against [mpiP](http://mpip.sourceforge.net/). The experiment 
consists of three stages:

  * `install` installs the dependencies via [`spack`](https://github.com/llnl/spack). 
    Since `spack` installs 
    dependencies from source, the `install` stage should be executed 
    in a node with the same architecture as the one of the compute 
    nodes where LULESH will run (e.g. in a "head" node of the 
    machine).

  * `run`. Executes LULESH by sending the job to the SLURM batch 
    scheduler.

  * `analyze`. Post-process the results that are gathered by `mpiP`. 
    Once the experiment finishes, `mpiP` places a text file in the 
    `results/` folder (a text file file ending in `.mpiP`) that 
    contains MPI runtime metrics. The `analyze.sh` script launches a 
    [Jupyter](http://jupyter.org/) notebook server (using Docker) that 
    analyzes the output of `mpiP` and generates a graph summarizing 
    MPI statistics. To see an example of how the notebook looks see 
    [here](https://github.com/popperized/popper-readthedocs-examples/blob/master/pipelines/mpip/results/notebook.ipynb).
