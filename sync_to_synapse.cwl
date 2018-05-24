#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool


hints:
  DockerRequirement:
    #dockerPull: synapse_python_client_cwl
    dockerPull: quay.io/andrewelamb/synapse_python_client
    
baseCommand: [ python, /usr/local/bin/sync_to_synapse.py ]

arguments: [
  "--path",
  $(inputs.cnr_file.path),
  $(inputs.cns_file.path),
  $(inputs.metrics_file.path),
  $(inputs.segmetrics_file.path),
  "--used",
  $(inputs.tumor_bam_synapse_id),
  $(inputs.normal_bam_synapse_id),
  $(inputs.targets_synapse_id),
  $(inputs.reference_synapse_id),
  $(inputs.fasta_synapse_id),
  "--executed",
  "https://github.com/Sage-Bionetworks/cnvkit_cwl",
  "https://github.com/Sage-Bionetworks/synapse_python_client_cwl",
  "https://github.com/Sage-Bionetworks/misc_cwl"
  ]


inputs:

  synapse_config_file:
    type: File
    inputBinding:
      prefix: "--synapse_config_file"
      
  yaml_config_file:
    type: ["null", File]
    inputBinding:
      prefix: "--yaml_config_file"
      
  upload_id:
    type: string
    inputBinding:
      prefix: "--parent"

  cnr_file: File
  cns_file: File
  metrics_file: File
  segmetrics_file: File

  tumor_bam_synapse_id: string
  normal_bam_synapse_id: string
  targets_synapse_id: string
  reference_synapse_id: string
  fasta_synapse_id: string
  
  activity_name:
    type: string
    default: "create_and_upload"
    inputBinding:
      prefix: "--activity_name"

  activity_description:
    type: string
    default: "run cnvkit"
    inputBinding:
      prefix: "--activity_description"

  

outputs:

  output:
    type: File
    outputBinding:
      glob: manifest.tsv