# genomics

Popper pipeline that guides you through [this](https://jasonjwilliamsny.github.io/wrangling-genomics/01-automating_a_workflow.html) tutorial.

In this case Popper makes sure that the required files 
and the required tools are downloaded, then it executes 
all the indicated steps in the tutorial and copies the 
output files to a output folder in your local machine.

The pipeline consists of 5 stages: 

  * [`setup`](./setup.sh): 
    This stage builds a docker container 
    using the `docker` folder, which includes:
     
    * a `files` folder containing
    the file `SRR097977_final_variant_output_mac.vcf` of a previous run
    executed using Mac. This file is here to analyze and compare results between
    different operating systems. 
    * A bash script for each stage of the main execution.
    * A Dockerfile with the minimum requirements needed to execute
    this pipeline.
    
    After that this stage executes the bash script [`docker-setup.sh`](./docker/docker-setup.sh)
    using the previous docker container. This stage creates the following 
    folder structure :
    
        ─ Data
            ├── ref_genome
            ├── untrimmed_fastq
            └── trimmed_fastq
        ─ Results
            ├── sai
            ├── sam
            ├── bam
            ├── bcf
            └── vcf
        ─ docs
            
    Then it downloads the required files: 
    * data/ref_genome/[ecoli_rel606.fasta](https://osf.io/vua9t)
    * data/trimmed_fastq/[SRR097977.fastq_trim.fastq](https://osf.io/w7gp2)
    
    And it downloads and installs the following required tools: 
    * [samtools](https://github.com/samtools/samtools) release 1.8
    * [bcftools](https://github.com/samtools/bcftools) release 1.8
    * [snpEff](http://sourceforge.net/projects/snpeff) latest core
    * [bio-bwa](https://sourceforge.net/projects/bio-bwa) latest

    
  * [`run`](./run.sh). 
    Executes the bash script [`docker-run.sh`](./docker/docker-run.sh).
    
    This stage is responsible of executing the steps shown in [this](https://jasonjwilliamsny.github.io/wrangling-genomics/01-automating_a_workflow.html) tutorial  
  
  * [`post-run.sh`](./post-run.sh). 
    This stage executes the bash script [`docker-post-run.sh`](./docker/docker-post-run.sh)
    
    This stage creates the folder `results/visualize` and copies the files
     created in the previous step
    `results/bam/SRR097977.aligned.sorted.bam`, `results/bam/SRR097977.aligned.sorted.bam.bai`,
    `data/ref_genome/ecoli_rel606.fasta`, `results/vcf/SRR097977_final_variants.vcf`
    to this folder. So you can visualize them using
    [GVI](http://software.broadinstitute.org/software/igv/home)
    
  * [`concordance.sh`](./concordance.sh). 
  
    This stage also executes a bash script using docker [`docker-concordance.sh`](./docker/docker-concordance.sh)
    which uses `SnpSift` to calculate the concordance between `results/vcf/SRR097977_final_variants.vcf`
    and the file `files/SRR097977_final_variant_output_mac.vcf`
    Then it writes the results of this concordance to `concordance_SRR097977_final_variant_output_mac_SRR097977_final_variants.summary.txt`
  * [`validate.sh`](./validate.sh). 
    This stage executes the bash script [`docker-validate.sh`](./docker/docker-validate.sh) which
    which determines if the VCF files match or if they don't using the file created in the previous stage `concordance_SRR097977_final_variant_output_mac_SRR097977_final_variants.summary.txt`.
    returning `[true] SnpSift Concordance output. The vcf files match.` or `[false] SnpSift Concordance output. The vcf files don't match`.
       
  * [`teardown.sh`](./teardown.sh) 
    This stage copies all the content of the folder `results` to an output folder in your local machine.
    Here, you can find all the used files, the `visualize` folder and the concordance between the VCF files.
    Then it stops and deletes the docker container created in the first stage.
    