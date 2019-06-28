#!/usr/bin/env bash

# SnpSift Concordance

# Calculate concordance between two VCF files.
#
# This is typically used when you want to calculate concordance
# between a genotyping experiment and a sequencing experiment.
# For instance, you sequenced several samples and, as part of a
# related experiment or just as quality control, you also genotype
# the same samples using a genotyping array. Now you want to
# compare the two experiments. Ideally there would be no
# difference between the variants from genotyping and sequencing,
# but this is hardly the case in real world.
# You can use SnpSift concordance to measure the differences
# between the two experiments.
#
# It is assumed that both VCF files are sorted by chromosome
# and position.
#
# Sample names are defined in '#CHROM' line of the header section.
# Concordance is calculated only if sample label matches in both files.

BASE_PATH="./workflows/genomics"
java -jar ${BASE_PATH}/data/snpEff/SnpSift.jar concordance -v \
    ${BASE_PATH}/files/SRR097977_final_variant_output_mac.vcf \
    ${BASE_PATH}/results/vcf/SRR097977_final_variants.vcf


