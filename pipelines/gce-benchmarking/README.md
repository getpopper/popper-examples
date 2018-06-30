# Google Compute Engine ready pipeline example

[![Google Cloud Engine ready pipeline](https://img.shields.io/badge/GCE-ready-blue.svg)](https://popper.readthedocs.io/en/docs-reorg/sections/examples.html#on-ec2-gce-using-terraform)


[Google Compute Engine (GCE)](https://cloud.google.com/compute/) is a service
offered by Google to facilitate the deployment of cloud infrastructure. It
provides a well tested and easy way to allocate resources on Google's global
infrastructure, and gives anyone the ability to painlessly create, run, and
destroy virtual machines at will.

This directory contains a pipeline that makes use of GCE to run a simple
experiment. We use [Terraform](https://www.terraform.io/) to programatically
create and destroy the compute instances needed for the experiment.

The pipeline consists of three stages:

- `setup.sh` initializes Terraform and applies the changes needed to create the
  infrastructure we need. To avoid requiring terraform to be installed, we
  instead use a the official Terraform docker image provided by Hashicorp. Once
  the machines are ready, a list of them is written to `baseliner/hosts`.
- `run.sh` runs [Baseliner](https://github.com/ivotron/baseliner) on the
  provisioned machines and saves results to a `results` directory.
- `teardown.sh` once again uses Terraform, this time to free the resources we
  created in out setup stage.

## Local execution

To run this pipeline locally:
1. Add the pipeline to your current repository with this command:
   ```
    popper add github/popper-readthedocs-examples/gce-benchmarking
   ```
1. Place your Google Cloud service account credentials json file inside the
   `credentials` directory of the pipeline as `account.json`. If you don't have
   a service account, you can find more information on obtaining one
   [here](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).
2. If required, you may set the `GCE_MACHINE_TYPE` environment variable to
   change the size of the instance running the experiment. The default value is
   `g1-small`.
3. Execute the pipeline: `popper run gce-benchmarking`.

## Automatic execution in continious integration evnironments

Setting this pipeline to run on top of a continious integration service is similar to the standard procedure for most popper pipelines, described [here](http://popper.readthedocs.io/en/latest/ci/popperci.html). The only added complication is the need to have the `credentials/account.json` file present during runtime. You should _not_ ever commit bare account credentials to a public repository of any kind. Instead you should take advantage of features offered by various popular CI services to commit an encrypted version of your credentials file in the repository instead. A few examples:

- The Travis CI documentation has a section on [encrypting
files](https://docs.travis-ci.com/user/encrypting-files/<Paste>)
- Circle CI has a recommended way of [keeping sensitive files encrypted in your
repository](https://github.com/circleci/encrypted-files)



