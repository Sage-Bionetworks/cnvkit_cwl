#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

inputs:

  synapse_config_file: File
  tumor_bam_synapse_id: string
  normal_bam_synapse_id: string
  targets_synapse_id: string
  reference_synapse_id: string
  fasta_url: string
  
outputs:
  

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
    run: ../misc_cwl/wget.cwl
    in: 
      url: fasta_url
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


