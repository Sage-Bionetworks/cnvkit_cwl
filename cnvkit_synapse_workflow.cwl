#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

requirements:
- class: SubworkflowFeatureRequirement
- class: InlineJavascriptRequirement

inputs:
 
  # config files
  synapse_config_file: File
  yaml_config_file: File
  
  # synapse ids
  upload_id: string
  tumor_bam_synapse_id: string
  normal_bam_synapse_id: string
  targets_synapse_id: string
  reference_synapse_id: string
  fasta_synapse_id: string
  
  # cnvkit parameters
  tumor_purity: float
  call_method: string
  segmetrics_std: ["null", boolean]
  segmetrics_mad: ["null", boolean]
  segmetrics_sem: ["null", boolean]
  segmetrics_ci: ["null", boolean]
  
  # output names
  output_cns_name: string
  output_cnr_name: string
  output_metrics_name: string
  output_segmetrics_name: string
  
outputs:

  manifest:
    type: File
    outputSource: sync_to_synapse/output

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
      tumor_purity: tumor_purity
      call_method: call_method
      segmetrics_std: segmetrics_std
      segmetrics_mad: segmetrics_mad
      segmetrics_sem: segmetrics_sem
      segmetrics_ci: segmetrics_ci
    out: [cnr_file, cns_file, metrics_file, segmetrics_file]

  rename_cnr:
    run: ../misc_cwl/rename.cwl
    in: 
      input_file: batch_workflow/cnr_file
      output_string: output_cnr_name
    out: [output_file]
    
  rename_cns:
    run: ../misc_cwl/rename.cwl
    in: 
      input_file: batch_workflow/cns_file
      output_string: output_cns_name
    out: [output_file]

  rename_metrics:
    run: ../misc_cwl/rename.cwl
    in: 
      input_file: batch_workflow/metrics_file
      output_string: output_metrics_name
    out: [output_file]

  rename_segmetrics:
    run: ../misc_cwl/rename.cwl
    in: 
      input_file: batch_workflow/segmetrics_file
      output_string: output_segmetrics_name
    out: [output_file]
    
  sync_to_synapse:
    run: sync_to_synapse.cwl
    in: 
      synapse_config_file: synapse_config_file
      yaml_config_file: yaml_config_file
      
      upload_id: upload_id
      
      cnr_file: rename_cnr/output_file
      cns_file: rename_cns/output_file
      metrics_file: rename_metrics/output_file
      segmetrics_file: rename_segmetrics/output_file
      
      tumor_bam_synapse_id: tumor_bam_synapse_id
      normal_bam_synapse_id: normal_bam_synapse_id
      targets_synapse_id: targets_synapse_id
      reference_synapse_id: reference_synapse_id
      fasta_synapse_id: fasta_synapse_id
      
    out: [output]
