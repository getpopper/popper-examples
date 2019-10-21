# Workflow for Spark benchmarking using [spark-bench](https://codait.github.io/spark-bench/)

This example workflow performs one of the classic spark examples, Pi Estimation.

> Spark can also be used for compute-intensive tasks. This code estimates π
by "throwing darts" at a circle. We pick random points in the unit square
((0, 0) to (1,1)) and see how many fall in the unit circle. The fraction
should be π / 4, so we use this to get our estimate.

This workflow shows that, if the number of `slices` are higher, the calculation is more precised.

![result](./results/income_f_age.png)

Here `difference` is the difference between actual and calculated value of `pi`.

## The Workflow

This workflow comprises of several actions which can be broadly classified in the following stages:
* `setup`: The first step is to build and push the Docker images to setup a standalone Apache Spark cluster running Spark Master and Spark workers based on [Spark Docker](https://github.com/big-data-europe/docker-spark) using the [Docker actions](https://github.com/popperized/docker).

* `allocate resources`: Using [Terraform actions](https://github.com/popperized/terraform) resources are allocated for Spark Master and Spark Workers, reading the config from [config.tf](./terraform/config.tf).

* `run benchmarks`: Benchmarks are run on the allocated nodes and the result files are retrieved using the [Ansible action](https://github.com/popperized/ansible).

* `plot and validate`: Plot the results on a bar-graph and validate that higher the number of slice, higher will be the precision in calculation.

* `cleanup`: Destroy the resource allocated via terraform. 

### Environment variables

* `ANSIBLE_SSH_KEY_DATA`. A base64-encoded string containing the private key used to authenticate with hosts referenced in the ansible inventory. Example encoding from a terminal: `cat ~/.ssh/id_rsa | base64`
* `TF_VAR_PACKET_API_KEY`. Your Packet API Auth token.This depends on the Terraform provider you are using(here [Packet](https://www.packet.com/)).