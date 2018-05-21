#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

inputs:

  tumor_bam_file: File
  normal_bam_file: File
  targets_file: File
  reference_file: File
  fasta_file: File
 
outputs:

  cnr:
    type: File
    outputSource: batch/cnr

  cns:
    type: File
    outputSource: batch/cns

  cnn:
    type: File
    outputSource: batch/cnn

steps:

  access:
    run: cnvkit_access.cwl
    in: 
      fasta_file: fasta_file
    out: [output_bed]

  batch:
    run: cnvkit_batch.cwl
    in:
      tumor_bam_file: tumor_bam_file
      normal_bam_file: normal_bam_file
      targets_file: targets_file
      reference_file: reference_file
      fasta_file: fasta_file
      access_file: access/output_bed
    out: [cnr, cns, cnn]