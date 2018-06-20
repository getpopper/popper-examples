#!/usr/bin/env bash

# [wf] executes validate stage

# Checks whether or not the SnpSift output contains
# the string that indicates if a difference was found.
if grep -q "ALT field does not match" \
 docker/output/results/concordance_SRR097977_final_variant_output_mac_SRR097977_final_variants.summary.txt; then
  # Some Actions # SomeString was found
  echo "[false] SnpSift Concordance output. The vcf files don't match"
else echo "[true] SnpSift Concordance output. The vcf files match."
fi