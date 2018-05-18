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

steps:

  access:
    run: cnvkit_access.cwl
    in: 
      fasta_file: fasta_file
    out: [output]

  