#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
- class: SubworkflowFeatureRequirement

inputs:

  synapse_config_file: File
  yaml_config_file: File
  tumor_bam_synapse_id: string
  normal_bam_synapse_id: string
  targets_synapse_id: string
  reference_synapse_id: string
  fasta_synapse_id: string
  
  
outputs:
  
  fasta_file:
    type: File
    outputSource: gunzip_fasta_file/output

  targets_file:
    type: File
    outputSource: gunzip_targets_file/output

  tumor_bam_file:
    type: File
    outputSource: dl_tumor_bam_file/output
    
  normal_bam_file:
    type: File
    outputSource: dl_normal_bam_file/output

  reference_file:
    type: File
    outputSource: dl_reference_file/output

  cnn_file:
    type: File
    outputSource: batch_workflow/cnn
    
  cnr_file:
    type: File
    outputSource: batch_workflow/cnr

  cns_file:
    type: File
    outputSource: batch_workflow/cns

steps:
  
  dl_tumor_bam_file:
    run: ../synapse_python_client_cwl/syn_get.cwl
    in: 
      config_file: synapse_config_file
      synapse_id: tumor_bam_synapse_id
    out: [output]
    
  dl_normal_bam_file:
    run: ../synapse_python_client_cwl/syn_get.cwl
    in: 
      config_file: synapse_config_file
      synapse_id: normal_bam_synapse_id
    out: [output]
    
  dl_targets_file:
    run: ../synapse_python_client_cwl/syn_get.cwl
    in: 
      config_file: synapse_config_file
      synapse_id: targets_synapse_id
    out: [output]
    
  dl_reference_file:
    run: ../synapse_python_client_cwl/syn_get.cwl
    in: 
      config_file: synapse_config_file
      synapse_id: reference_synapse_id 
    out: [output]

  dl_fasta_file:
    run: ../synapse_python_client_cwl/syn_get.cwl
    in: 
      config_file: synapse_config_file
      synapse_id: fasta_synapse_id
    out: [output]

  gunzip_fasta_file:
    run: ../misc_cwl/gunzip.cwl
    in: 
      input: dl_fasta_file/output
    out: [output]

  gunzip_targets_file:
    run: ../misc_cwl/gunzip.cwl
    in: 
      input: dl_targets_file/output
    out: [output]

  batch_workflow:
    run: cnvkit_workflow.cwl
    in:
      fasta_file: gunzip_fasta_file/output
      targets_file: gunzip_targets_file/output
      tumor_bam_file: dl_tumor_bam_file/output
      normal_bam_file: dl_normal_bam_file/output
      reference_file: dl_reference_file/output
    out: [cnr, cnn, cns]


