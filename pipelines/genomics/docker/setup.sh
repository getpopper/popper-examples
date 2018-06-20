#!/usr/bin/env bash
# [wf] execute setup stage

# [wf] dc_worshop folder
mkdir dc_workshop

# [wf] Moving into the new folder
cd dc_workshop

# [wf] Make directory structure
mkdir data
mkdir data/ref_genome
mkdir data/untrimmed_fastq
mkdir data/trimmed_fastq
mkdir results
mkdir results/sai
mkdir results/sam
mkdir results/bam
mkdir results/bcf
mkdir results/vcf
mkdir docs

# Gathering all required files.
curl -o data/ref_genome/ecoli_rel606.fasta -0L https://osf.io/vua9t/download
curl -o data/trimmed_fastq/SRR097977.fastq_trim.fastq -0L https://osf.io/w7gp2/download

# Gathering all the required tools.
curl -o tbwa.tar.gz2 -0L https://sourceforge.net/projects/bio-bwa/files/latest/download
tar -xvjf tbwa.tar.gz2
cd bwa*
./configure
make
make install
cd ..

curl -o tsamtools.tar.bz2 -0L https://github.com/samtools/samtools/releases/download/1.8/samtools-1.8.tar.bz2
tar -xvjf tsamtools.tar.bz2
cd samtools*
./configure
make
sudo make install
cd ..

curl -o tbcftools.tar.bz2 -0L https://github.com/samtools/bcftools/releases/download/1.8/bcftools-1.8.tar.bz2
tar -xvjf tbcftools.tar.bz2
cd bcftools*
./configure
make
sudo make install
cd ..

mkdir snp
cd snp
wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip
unzip snpEff_latest_core.zip
cd ..
