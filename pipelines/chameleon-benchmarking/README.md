# Chameleon ready pipeline

[![ Chameleon ready pipeline](https://img.shields.io/badge/Chameleon-ready-blue.svg)](https://github.com/popperized/popper-readthedocs-examples/tree/master/pipelines/chameleon-benchmarking)

[Chameleon](https://www.chameleoncloud.org/) is an NSF funded cloud service
that aims to give researchers access to large scale infrastructure for cloud
research. Provisioning and running cloud experiments of any size with Chameleon
is fast and simple. We can introduce popper into our Chameleon expermients in
order to make their reproducibility much more effortless. This pipeline
provides an example and template for an experiment that automatically runs on
Chameleon.

You can get started on your own Chameleon ready pipeline by adding this
pipeline to your own repository by running:

```
popper add github/popper-readthedocs-examples/chameleon-benchmarking
```

This pipeline consists of three stages:

1. A setup stage creates a reservation and allocates the requested resources on
   chameleon. You may modify this stage and the `scripts/request.py` script to
   change the amount and type of resources allocated. Once this is done, an
   ansible inventory is output to the `inventory` directory
2. The run stage carries out the actual experiment. By default this runs a
   couple of benchmarks using [Baseliner](https://github.com/ivotron/baseliner)
3. The teardown stage deletes the lease used to allocate resources, destroying them.

Before running this pipeline, make sure you have [loaded your Chameleon
configuration](https://chameleoncloud.readthedocs.io/en/latest/technical/cli.html#the-openstack-rc-script)

In order to get this pipeline running on continious integration, you simply
need to add the necessary openstack configuration environment variables to your
continous integration service.

