#!/usr/bin/env bash

BASE_PATH="./workflows/genomics/data"
mkdir -p ${BASE_PATH}/{ref_genome,trimmed_fastq}
curl -o ${BASE_PATH}/ref_genome/ecoli_rel606.fasta -0L https://osf.io/vua9t/download
curl  -o ${BASE_PATH}/trimmed_fastq/SRR097977.fastq_trim.fastq -0L https://osf.io/w7gp2/download

# convert from wget to curl so that curl action can be used.
url1=$(curl https://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip/download | grep -oP ">http.?://\S+<")
url1=${url1:1:-1}
url2=$(curl $url1 | grep -oP ">http.?://\S+<")
final_url=${url2:1:-1}
curl -o ${BASE_PATH}/snpEff_latest_core.zip $final_url