#!/usr/bin/env bash
# [wf] execute post-run stage

# [wf] Move to the dc_workshop folder
cd dc_workshop

# [wf] Make visualize folder
mkdir visualize

# We copy all the required files that we need to visualize
cp results/bam/SRR097977.aligned.sorted.bam     visualize/
cp results/bam/SRR097977.aligned.sorted.bam.bai visualize/
cp data/ref_genome/ecoli_rel606.fasta           visualize/
cp results/vcf/SRR097977_final_variants.vcf     visualize/

# If you want to visualize using the tool IGV follow the next steps:

# Visualize
# Start IGV
# Load the genome file into IGV using the "Load Genomes from
# File..." option under the "Genomes" pull-down menu.
# Load the .bam file using the "Load from File..." option under
# the "File" pull-down menu. IGV requires the .bai file to be
# in the same location as the .bam file that is loaded into IGV,
# but there is no direct use for that file.
# Load in the VCF file using the "Load from File..." option
# under the "File" pull-down menu

# There should be two tracks: one coresponding to your BAM file
# and the other for your VCF file.
#
# In the VCF track, each bar across the top of the plot shows the
# allele fraction for a single locus. The second bar will show
# the genotypes for each locus in each sample. We only have one
# sample called here so we only see a single line.
# Dark blue = heterozygous, Cyan = homozygous variant,
# Grey = reference. Filtered entries are transparent.
#
# Zoom in to inspect variants you see in your filtered VCF file
# to become more familiar with IGV. See how quality information
# corresponds to alignment information at those loci.
