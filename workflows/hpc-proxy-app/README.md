# HPC proxy app

## Workflow
The workflow defined in [main.workflow](./main.workflow) consist of five actions

* **`install lulesh`**. Installs [lulesh](https://spack.readthedocs.io/en/latest/package_list.html#lulesh)with `mpi` support, using [spack](https://spack.io/), via the [spack action](https://github.com/popperized/spack).

* **`install sweepj2`**. Installs [sweepj2](https://github.com/ivotron/sweepj2) via `pip` using [python-actions](https://github.com/jefftriplett/python-actions), to run parameter sweep over a jinja2 template.

* **`generate sweep`**. Given a [template](./sweep/script) and a [parameter space](./sweep/space.yml), it runs a parameter sweep and generates the output files with given parameters.

* **`make scripts executable`**. Makes the generated scripts executable.

* **`run sweep`**. Executes all the files generated in previous step.

## Execution

This workflow runs in a container runtime ([Docker][docker], 
[Singularity][singularity], etc.) and can be executed with the [Popper 
CLI tool][popper]. The following executes this workflow:

```bash
git clone https://github.com/popperized/popper-examples

cd popper-examples/workflow/hpc-proxy-app

popper run
```

Sample output (trimmed to only show end of execution):

```
Running problem size 30^3 per domain until completion
Num processors: 1
Num threads: 2
Total number of elements: 27000

To run other sizes, use -s <integer>.
To run a fixed number of iterations, use -i <integer>.
To run a more or less balanced region set, use -b <integer>.
To change the relative costs of regions, use -c <integer>.
To print out progress, use -p
To write an output file for VisIt, use -v
See help (-h) for more options

Run completed:  
   Problem size        =  30 
   MPI tasks           =  1 
   Iteration count     =  200 
   Final Origin Energy = 8.105927e+05 
   Testing Plane 0 of Energy Array on rank 0:
        MaxAbsDiff   = 1.673470e-10
        TotalAbsDiff = 7.003248e-10
        MaxRelDiff   = 1.276331e-12


Elapsed time         =       5.74 (s)
Grind time (us/z/c)  =   1.062805 (per dom)  (  1.062805 overall)
FOM                  =  940.90638 (z/s)

Running problem size 30^3 per domain until completion
Num processors: 1
Num threads: 2
Total number of elements: 27000

To run other sizes, use -s <integer>.
To run a fixed number of iterations, use -i <integer>.
To run a more or less balanced region set, use -b <integer>.
To change the relative costs of regions, use -c <integer>.
To print out progress, use -p
To write an output file for VisIt, use -v
See help (-h) for more options

Run completed:  
   Problem size        =  30 
   MPI tasks           =  1 
   Iteration count     =  100 
   Final Origin Energy = 1.322672e+06 
   Testing Plane 0 of Energy Array on rank 0:
        MaxAbsDiff   = 1.236913e-10
        TotalAbsDiff = 3.814214e-10
        MaxRelDiff   = 4.888416e-12


Elapsed time         =       3.15 (s)
Grind time (us/z/c)  =   1.167336 (per dom)  (  1.167336 overall)
FOM                  =  856.65136 (z/s)

Running problem size 30^3 per domain until completion
Num processors: 1
Num threads: 2
Total number of elements: 27000

To run other sizes, use -s <integer>.
To run a fixed number of iterations, use -i <integer>.
To run a more or less balanced region set, use -b <integer>.
To change the relative costs of regions, use -c <integer>.
To print out progress, use -p
To write an output file for VisIt, use -v
See help (-h) for more options

Run completed:  
   Problem size        =  30 
   MPI tasks           =  1 
   Iteration count     =  200 
   Final Origin Energy = 8.105927e+05 
   Testing Plane 0 of Energy Array on rank 0:
        MaxAbsDiff   = 1.673470e-10
        TotalAbsDiff = 7.003248e-10
        MaxRelDiff   = 1.276331e-12


Elapsed time         =       6.28 (s)
Grind time (us/z/c)  =  1.1628727 (per dom)  ( 1.1628727 overall)
FOM                  =  859.93935 (z/s)

Workflow finished successfully.

```

[docker]: https://get.docker.com
[popper]: https://github.com/systemslab/popper
[singularity]: https://github.com/sylabs/singularity