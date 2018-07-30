# Chameleon ready pipeline

The [![ Chameleon ready pipeline](https://img.shields.io/badge/Chameleon-ready-blue.svg)](https://github.com/popperized/popper-readthedocs-examples/tree/master/pipelines/chameleon-benchmarking)
 badge is included in a repository hosting a [Popper pipeline](https://github.com/systemslab/popper) that is ready to 
 be executed on [ChameleonCloud](https://www.chameleoncloud.org). If you see it in a repository, it means that the authors have made it easier for others to run on Chameleon by following the Popper convention.
 
 In this repository, we present an example of a pipeline that can be used 
 as the starting point to implement a [![ Chameleon ready pipeline](https://img.shields.io/badge/Chameleon-ready-blue.svg)](https://github.com/popperized/popper-readthedocs-examples/tree/master/pipelines/chameleon-benchmarking) pipeline. To add it to your repository using `popper`, you can do:

```bash
popper add popperized/popper-readthedocs-examples/chameleon-benchmarking
```

If you add this pipeline to your repo (or if you follow the Popper convention to implement experiments on Chameleon), we invite you to add the badge to your `README` file.

--------------

[Chameleon](https://www.chameleoncloud.org/) is an NSF funded cloud service
that aims to give researchers access to large scale infrastructure for cloud
research. Provisioning and running cloud experiments of any size with Chameleon
is fast and simple. We can follow the Popper convention when implementing experimentation pipelins on Chameleon in
order to make their reproducibility much more effortless. This pipeline
provides an example and template for an experiment that automatically runs on
Chameleon.

You can get started on your own Chameleon ready pipeline by adding this
pipeline to your own repository by running:

```
popper add popperized/popper-readthedocs-examples/chameleon-benchmarking
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
2. Save the ssh key you are using inside the credentials directory under the
   name popper-key.pem.
3. Source your Chameleon Openstack config. The [Chameleon
   docs](https://chameleoncloud.readthedocs.io/en/latest/technical/cli.html#the-openstack-rc-script)
   has a section on this.
4. Run the pipeline with `popper run`.

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

For running on CI, you also need to make sure your ssh key is present inside
the credential directory upon execution. Make sure **not** to check in your
private ssh keys on git, ever. You can instead use the services provided by
your CI service to encrypt sensitive files.

## Travis CI

Specifically, if you want to run this pipeline on travis, you have to first
follow these extra steps

1. Initialize the repository for CI by running `popper ci --service travis`.
2. Set up the aforementioned environment variables. [The travis
   docs](https://docs.travis-ci.com/user/environment-variables/) has a section
   on adding environment variables during runtime on Travis. Make sure you
   conceal sensitive data, such as passwords.
3. Add the secret private keyfile as `credentials/popper-key.pem`. [This
   section](https://docs.travis-ci.com/user/encrypting-files/) of the travis
   docs shows you how.

Once you've completed these steps, you can simply push a commit to github to
trigger a travis build job.

