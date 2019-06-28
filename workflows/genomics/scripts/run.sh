#!/usr/bin/env bash

BASE_PATH="./workflows/genomics"

mkdir -p ${BASE_PATH}/results/{sai,sam,bam,bcf,vcf}
pushd /bwa*
bwa="`pwd`/bwa"
popd




# Index the reference genome

# Our first step is to index the reference genome for use by BWA.
# NOTE: This only has to be run once. The only reason you would
# want to create a new index is if you are working with a different
# reference genome or you are using a different tool for alignment.
${bwa} index ${BASE_PATH}/data/ref_genome/ecoli_rel606.fasta

# Eventually we will loop over all of our files to run this workflow
# on all of our samples, but for now we're going to work on just one
# sample in our dataset SRR098283.fastq:
ls -alh ${BASE_PATH}/data/trimmed_fastq/SRR097977.fastq_trim.fastq

# Align reads to reference genome

# The alignment process consists of choosing an appropriate reference
# genome to map our reads against and then deciding on an aligner.
# BWA consists of three algorithms: BWA-backtrack, BWA-SW and BWA-MEM.
# The first algorithm is designed for Illumina sequence reads up to 100bp,
# while the rest two for longer sequences ranged from 70bp to 1Mbp.
# BWA-MEM and BWA-SW share similar features such as long-read support
# and split alignment, but BWA-MEM, which is the latest, is generally
# recommended for high-quality queries as it is faster and more accurate.

# Since we are working with short reads we will be using BWA-backtrack.
# The usage for BWA-backtrack is

# $ bwa aln path/to/ref_genome.fasta path/to/fastq > SAIfile

# This will create a .sai file which is an intermediate file containing
# the suffix array indexes.

# Have a look at the bwa options page. While we are running bwa with the
# default parameters here, your use case might require a change of
# parameters. NOTE: Always read the manual page for any tool before
# using and try to understand the options.

${bwa} aln ${BASE_PATH}/data/ref_genome/ecoli_rel606.fasta \
       ${BASE_PATH}/data/trimmed_fastq/SRR097977.fastq_trim.fastq > ${BASE_PATH}/results/sai/SRR097977.aligned.sai

# Convert the format of the alignment to SAM/BAM
# The SAI file is not a standard alignment output file and will need to
# be converted into a SAM file before we can do any downstream processing.
#
# SAM/BAM format
# The SAM file, is a tab-delimited text file that contains information
# for each individual read and its alignment to the genome. While we do
# not have time to go in detail of the features of the SAM format, the
# paper by Heng Li et al. provides a lot more detail on the specification.
# The binary version of SAM is called a BAM file.
#
# The file begins with a header, which is optional.
# The header is used to describe source of data, reference sequence,
# method of alignment, etc., this will change depending on the aligner
# being used. Following the header is the alignment section.
# Each line that follows corresponds to alignment information
# for a single read. Each alignment line has 11 mandatory fields for
# essential mapping information and a variable number of other fields
# for aligner specific information. An example entry from a SAM file is
# displayed below with the different fields highlighted.

# First we will use the bwa samse command to
# convert the .sai file to SAM format:
${bwa} samse ${BASE_PATH}/data/ref_genome/ecoli_rel606.fasta \
       ${BASE_PATH}/results/sai/SRR097977.aligned.sai \
       ${BASE_PATH}/data/trimmed_fastq/SRR097977.fastq_trim.fastq > \
       ${BASE_PATH}/results/sam/SRR097977.aligned.sam

# Explore the information within your SAM file:
head ${BASE_PATH}/results/sam/SRR097977.aligned.sam

echo $PWD
# Now convert the SAM file to BAM format for use by downstream tools:
samtools view -S -b ${BASE_PATH}/results/sam/SRR097977.aligned.sam > ${BASE_PATH}/results/bam/SRR097977.aligned.bam

# Sort BAM file by coordinates
# Sort the BAM file:
samtools sort ${BASE_PATH}/results/bam/SRR097977.aligned.bam > ${BASE_PATH}/results/bam/SRR097977.aligned.sorted.bam

# Variant calling
# A variant call is a conclusion that there is a nucleotide difference
# vs. some reference at a given position in an individual genome or
# transcriptome, often referred to as a Single Nucleotide Polymorphism
# (SNP). The call is usually accompanied by an estimate of variant
# frequency and some measure of confidence. Similar to other steps
# in this workflow, there are number of tools available for variant
# calling. In this workshop we will be using bcftools, but there are
# a few things we need to do before actually calling the variants.

# Step 1: Calculate the read coverage of positions in the genome
# Do the first pass on variant calling by counting read coverage
# with samtools mpileup:
samtools mpileup -g -f ${BASE_PATH}/data/ref_genome/ecoli_rel606.fasta \
         ${BASE_PATH}/results/bam/SRR097977.aligned.sorted.bam > ${BASE_PATH}/results/bcf/SRR097977_raw.bcf


# Step 2: Detect the single nucleotide polymorphisms (SNPs)
# Identify SNPs using bcftools:
bcftools call --skip-variants indels --multiallelic-caller \
        --variants-only -O v ${BASE_PATH}/results/bcf/SRR097977_raw.bcf \
         -o ${BASE_PATH}/results/vcf/SRR097977_final_variants.vcf


# Assess the alignment (visualization) - optional step
# In order for us to look at the alignment files in a
# genome browser, we will need to index the BAM file using samtools:
samtools index ${BASE_PATH}/results/bam/SRR097977.aligned.sorted.bam


## POST RUN STAGE

# [wf] Make visualize folder
mkdir ${BASE_PATH}/results/visualize

# We copy all the required files that we need to visualize
cp ${BASE_PATH}/results/bam/SRR097977.aligned.sorted.bam     ${BASE_PATH}/results/visualize/
cp ${BASE_PATH}/results/bam/SRR097977.aligned.sorted.bam.bai ${BASE_PATH}/results/visualize/
cp ${BASE_PATH}/data/ref_genome/ecoli_rel606.fasta           ${BASE_PATH}/results/visualize/
cp ${BASE_PATH}/results/vcf/SRR097977_final_variants.vcf     ${BASE_PATH}/results/visualize/

unzip ${BASE_PATH}/data/snpEff_latest_core.zip -d ${BASE_PATH}/data