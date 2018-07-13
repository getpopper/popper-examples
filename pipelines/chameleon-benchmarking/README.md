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

## Running manually

Follow these steps to run this pipeline using your computer as host

1. Make sure docker is installed and running. You can find instructions on
   installing docker [here](https://docs.docker.com/v17.12/install/).
2. Source your Chameleon Openstack config. The [Chameleon
   docs](https://chameleoncloud.readthedocs.io/en/latest/technical/cli.html#the-openstack-rc-script)
   has a section on this.
3. Run the pipeline with `popper run`.

# Automated execution

You can set this pipeline up to run on your prefered continous integration
service by using the [popper
cli](http://popper.readthedocs.io/en/latest/ci/popperci.html). In addition to
following the instructions in that link, make sure these environment variables
are set in your continious integration environment.

- OS_AUTH_URL
- OS_ENDPOINT_TYPE
- OS_IDENTITY_API_VERSION
- OS_REGION_NAME
- OS_TENANT_ID
- OS_TENANT_NAME
- OS_USERNAME
- OS_PASSWORD

You can find most of these inside the Chameleon configuration file downloaded
in the previous section.

