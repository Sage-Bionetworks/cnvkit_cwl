#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

inputs:

  tumor_bam_synapse_id: string
  normal_bam_synapse_id: string
  targets_synapse_id: string
  reference_synapse_id: string
  fasta_url: string
  
outputs:
  
  one: 
    type: File
    outputSource: [dl_tumor_bam_file/output]

  two: 
    type: File
    outputSource: [dl_normal_bam_file/output]

  three: 
    type: File
    outputSource: [dl_targets_file/output]

  four: 
    type: File
    outputSource: [dl_reference_file/output]
  

steps:
  
  dl_tumor_bam_file:
    run: ../synapse_python_client_cwl/syn_get.cwl
    in: 
      synapse_id: tumor_bam_synapse_id
    out: [output]
    
  dl_normal_bam_file:
    run: ../synapse_python_client_cwl/syn_get.cwl
    in: 
      synapse_id: normal_bam_synapse_id
    out: [output]
    
  dl_targets_file:
    run: ../synapse_python_client_cwl/syn_get.cwl
    in: 
      synapse_id: targets_synapse_id
    out: [output]
    
  dl_reference_file:
    run: ../synapse_python_client_cwl/syn_get.cwl
    in: 
      synapse_id: reference_synapse_id 
    out: [output]