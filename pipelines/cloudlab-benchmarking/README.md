# `CloudLab ready` pipeline

[![`CloudLab 
ready`](https://img.shields.io/badge/CloudLab-ready-blue.svg)](https://github.com/popperized/popper-readthedocs-examples/tree/master/pipelines/cloudlab-benchmarking)

[CloudLab](https://www.cloudlab.us/) is a flexible, scientific 
infrastructure for research on the future of cloud computing. It gives 
students and researchers access to cloud resources so they can setup 
clusters of machines to execute experiments in many domains such as 
networking, computer systems, cloud systems, etc. You can check the 
CloudLab Manual [here](http://docs.cloudlab.us).

The following is an example of a **CloudLab ready** pipeline,
i.e. a pipeline that can be executed on CloudLab with minimal effort. 

To execute this pipeline:

 1) Get the pipeline by executing the following command:

    ```bash
    popper add github/popper-readthedocs-examples/cloudlab-benchmarking
    ```

 2) Obtain credentials ([see 
    here](http://docs.cloudlab.us/geni-lib/intro/creds/cloudlab.html)). 
    This will result in having a *cloudlab.pem* file on your machine.

 3) Define the following environment variables.

    * `CLOUDLAB_USER`. Your user at CloudLab.
    * `CLOUDLAB_PASSWORD`. Your password for CloudLab.
    * `CLOUDLAB_PROJECT`. The name of the project your account belongs to on CloudLab.
    * `CLOUDLAB_PUBKEY_PATH`. The path to your SSH key registered with CloudLab.
    * `SSHKEY`. The path to your private SSH key registered with CloudLab.
    * `CLOUDLAB_CERT_PATH`. The path to the cloudlab.pem file downloaded in step 2.

4) Execute the command: `popper run benchmarking-on-cloudlab`

## Automated execution (CI)

To execute this pipeline on a CI system:

 1) Define the following hidden (secrets) environment variables on 
    your CI system:

      * `CLOUDLAB_USER`. Your username at CloudLab.
      * `CLOUDLAB_PASSWORD`. Your password for CloudLab.
      * `CLOUDLAB_PROJECT`. The name of the project your account 
        belongs to on CloudLab.

 2) Encrypt the following files using your CI system utilities and 
    move them to the `geni/` folder:

    * `cloudlab.pem`. File downloaded in the previous stages.
    * `id_rsa.pub`. Your public ssh key registered with CloudLab.
    * `id_rsa`. Your private ssh key registered with CloudLab.

### TravisCI

We now explain how to configure TravisCI so it automatically validates 
the pipeline. Before starting, make sure you have done the following:

  * Installed the Travis CI [Command Line 
    Tool](https://github.com/travis-ci/travis.rb#readme) by running:

    ```bash
    gem install travis
    ```

  * [Logged in](https://github.com/travis-ci/travis.rb#login) to using 
    the TravisCI CLI tool:

    ```bash
    travis login
    ```

  * Define secrets from step 1 from above on 
    [Travis](https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-in-Repository-Settings).

Once the above is done, on your machine do the following. Compress the 
files from **Step 2** of the previous to a file called 
`cloudlab_credentials.zip` or similar. Then, execute the command:

```bash
travis encrypt-file cloudlab_credentials.zip --add
```

This will generate a `cloudlab_credentials.zip.enc` file and will add 
to your `.travis.yml` file something like:

```yaml
openssl aes-256-cbc -d -K $encrypted_0a6446eb3ae3_key -iv $encrypted_0a6446eb3ae3_iv -in cloudlab_credentials.zip.enc -out cloudlab_credentials.zip
```

Please make sure to correct the path of files, for example:

```yaml
openssl aes-256-cbc -d -K $encrypted_0a6446eb3ae3_key -iv $encrypted_0a6446eb3ae3_iv -in /route/to/cloudlab_credentials.zip.enc -out pipelines/cloudlab-benchmarking/geni/cloudlab_credentials.zip
```

It is important to verify that the file `cloudlab_credentials.zip` is 
in `pipelines/cloudlab-benchmarking/geni/` as in the previous example. 
This is where the pipeline [reads the decrypted files from](pipelines/cloudlab-benchmarking/setup.sh).

To unzip it as part of the pipeline, add the following to your travis file.

```yaml
  - unzip pipelines/cloudlab-benchmarking/geni/cloudlab_credentials.zip -d pipelines/cloudlab-benchmarking/geni/
```

To see the final result, you can check the [`.travis.yml` file for 
this repo](.travis.yml). Lastly, commit all changes to your git 
repository and push to github so that Travis executes your `CloudLab 
ready` pipeline.

> **NOTE**: Make sure to add `cloudlab_credentials.zip.enc` to the git 
> repository and **NOT** the `clouadlab_credentials.zip` file to your 
> git repository, otherwise all your credentials will be available on 
> github to anyone with access to your repo.
>
## `CloudLab ready` badge

The ![[`CloudLab 
ready`](https://github.com/popperized/popper-readthedocs-examples/tree/master/pipelines/cloudlab-benchmarking)](https://img.shields.io/badge/CloudLab-ready-blue.svg)
 badge denotes Popper pipelines or popperized repos that are ready to 
 be executed on CloudLab. If you implement a pipeline based on the one 
 presented here, we invite you to add the badge to your `README` file.
