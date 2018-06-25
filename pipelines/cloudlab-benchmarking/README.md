# benchmarking-on-cloudlab


[CloudLab](https://www.cloudlab.us/) is a flexible, scientific infrastructure for research on the future of cloud computing.
It gives students and researchers access to cloud resources so they can setup clusters of machines to execute experiments
in many domains such as networking, computer systems, cloud systems, etc.
You can check the CloudLab Manual [here](http://docs.cloudlab.us).

The following is an example of a **CloudLab ready** pipeline,
i.e. a pipeline that can be executed on CloudLab with minimal effort. 

To execute this pipeline:

1) Get the pipeline by executing the following command:
    
    `popper add github/popper-readthedocs-examples/cloudlab-benchmarking`

2) Obtain credentials ([see here](http://docs.cloudlab.us/geni-lib/intro/creds/cloudlab.html)).
This will result in having a *cloudlab.pem* file on your machine.

3) Define the following environment variables.

    * `CLOUDLAB_USER`. Your user at CloudLab.
    * `CLOUDLAB_PASSWORD`. Your password for CloudLab.
    * `CLOUDLAB_PROJECT`. The name of the project your account belongs to on CloudLab.
    * `CLOUDLAB_PUBKEY_PATH`. The path to your SSH key registered with CloudLab.
    * `SSHKEY`. The path to your private SSH key registered with CloudLab.
    * `CLOUDLAB_CERT_PATH`. The path to the cloudlab.pem file downloaded in step 2.

4) Execute the command: `popper run benchmarking-on-cloudlab`

#### CI-setup:

To execute this pipeline on a CI system:

 1) Define the following hidden environment variables on your CI system.
 
    *   `CLOUDLAB_USER`. Your user at CloudLab.
    *   `CLOUDLAB_PASSWORD`. Your password for CloudLab.
    *   `CLOUDLAB_PROJECT`. The name of the project your account belongs to on CloudLab.
    
    You can find an example of how this is done using **Travis** [here](https://docs.travis-ci.com/user/environment-variables/#Defining-Variables-in-Repository-Settings)

2) Encrypt the following files using your CI system tools and move them to the `/geni` folder.

    *   `cloudlab.pem`. File downloaded in the previous stages.
    *   `id_rsa.pub`.   Your public ssh key registered with CloudLab.
    *   `id_rsa`.       Your private ssh key registered with CloudLab.
    
    An example of how this is done using Travis:
            
    Before starting make sure you have already:

    * installed the Travis CI [Command Line Client](https://github.com/travis-ci/travis.rb#readme)
    by running `$ gem install travis`
    * [logged in](https://github.com/travis-ci/travis.rb#login) to Travis CI using `$ travis login` or `$ travis login --pro`

    2.1. Compress the files from **step 2** to a file called `cloudlab_credentials.zip` or similar.

    2.2. Execute the command: `travis encrypt-file cloudlab_credentials.zip --add`

    This will generate a `cloudlab_credentials.zip.enc` file and will add to your .travis.yml file something like: 

        openssl aes-256-cbc -K $encrypted_0a6446eb3ae3_key -iv $encrypted_0a6446eb3ae3_iv -in cloudlab_credentials.zip.enc -out cloudlab_credentials.zip -d

    Please make sure to correct the path of the files.

        openssl aes-256-cbc -K $encrypted_0a6446eb3ae3_key -iv $encrypted_0a6446eb3ae3_iv -in /route/to/cloudlab_credentials.zip.enc -out pipelines/cloudlab-benchmarking/geni/cloudlab_credentials.zip -d

    Is important you make sure the file **cloudlab_credentials.zip** is in `pipelines/cloudlab-benchmarking/geni/` as in the previous example.
    This is where Travis will put the decrypt file. 
    
    To unzip it add the following to your travis file.
    
        - unzip pipelines/cloudlab-benchmarking/geni/cloudlab_credentials.zip -d pipelines/cloudlab-benchmarking/geni/


3) Commit all changes to your git repository.
    
    Make sure to add `cloudlab_credentials.zip.enc` to the git repository.
    Make sure not to add `clouadlab_credentials.zip` to the git repository. 
    