# BLIS vs. other BLAS implementations

[BLIS](https://github.com/flame/blis) is a portable software framework 
for instantiating high-performance BLAS-like dense linear algebra 
libraries. This experiment corresponds to the one presented in the 
[first BLIS paper](http://doi.acm.org/10.1145/2764454). A [subsequent 
report](http://dl.acm.org/citation.cfm?id=2738033) documents how to 
repeat this experiment. This pipeline corresponds to sections 
2.1-2.3 of the replicability report and consists of three stages:

  * `build-docker-image`. [A Docker 
    image](https://github.com/ivotron/docker-blis/tree/master/Dockerfile) 
    prepares all the binaries for BLIS, OpenBLAS and Atlas 
    precompiled.
  * `run`. Executes the experiment that compares BLIS against other 
    BLAS implementations, generating output to the `results/` folder.
  * `analyze`. Runs the analysis on the output of the experiment, 
    corresponding to figures 13-15 from the original paper. To 
    visualize results locally, one can execute the following:

    ```bash
    docker run -d \
      -v `pwd`:/code/experiment -p 8888:8888  jupter notebook 
      --NotebookApp.token=""
    ```

    After the above executes, open Browser and point it to 
    <http://localhost:8888>. To see an example of how the notebook looks 
    click 
    [here](https://github.com/popperized/popper-readthedocs-examples/blob/master/pipelines/blis/results/visualize.ipynb).
