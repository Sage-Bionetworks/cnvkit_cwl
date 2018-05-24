#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

inputs:

  tumor_bam_file: File
  normal_bam_file: File
  targets_file: File
  reference_file: File
  fasta_file: File
  tumor_purity: float
  call_method: string
  segmetrics_std: ["null", boolean]
  segmetrics_mad: ["null", boolean]
  segmetrics_sem: ["null", boolean]
  segmetrics_ci: ["null", boolean]
 
outputs:

  cnr:
    type: File
    outputSource: batch/cnr

  cns:
    type: File
    outputSource: call/output
    
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
    out: [cnr, cns]

  call:
    run: cnvkit_call.cwl
    in: 
      cns_file: batch/cns
      purity: tumor_purity
      method: call_method
    out: [output]

  metrics:
    run: cnvkit_metrics.cwl
    in: 
      cns_file: call/output
      cnr_file: batch/cnr
    out: [output]

  segmetrics:
    run: cnvkit_segmetrics.cwl
    in: 
      cns_file: call/output
      cnr_file: batch/cnr
      std: segmetrics_std
      mad: segmetrics_mad
      sem: segmetrics_sem
      confint: segmetrics_ci
    out: [output]