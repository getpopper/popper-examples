# Genomics Example

Popper example workflow for [this tutorial](https://jasonjwilliamsny.github.io/wrangling-genomics/01-automating_a_workflow.html)

To execute it:

```bash
git clone https://github.com/popperized/popper-examples

cd popper-examples/workflows/genomics

popper run -f wf.yml
```

## Workflow

The workflow consists of four steps:

   * `generate data`: Downloads the `ref_genome/ecoli_rel606.fasta` & `trimmed_fastq/SRR097977.fastq_trim.fastq` data files and `snpEff_latest_core.jar` which would be used in the workflow later.

   * `run`: Follows the steps in the [tutorial](https://jasonjwilliamsny.github.io/wrangling-genomics/01-automating_a_workflow.html) and saves the files required to visualize in the [`results/visualize`](./results/visualize) directory.

   * `concordance`: Uses `SnpSift` to calculate the concordance between `results/vcf/SRR097977_final_variants.vcf` and the file `files/SRR097977_final_variant_output_mac.vcf`. Then it writes the results of this concordance to `concordance_SRR097977_final_variant_output_mac_SRR097977_final_variants.summary.txt`.

   * `validate`: Determines if the VCF files matches or not, using the file created in the `concordance` stage `concordance_SRR097977_final_variant_output_mac_SRR097977_final_variants.summary.txt`. returning `[true] SnpSift Concordance output. The vcf files match.` or `[false] SnpSift Concordance output. The vcf files don't match.`
