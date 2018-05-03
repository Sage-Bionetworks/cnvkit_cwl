#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: etal/cnvkit
    
baseCommand: [cnvkit.py, batch]

inputs:
 
  tumor_bam_file:
    type: File
    inputBinding:
      position: 0

  normal_bam_file:
    type: ["null", File]
    inputBinding:
      prefix: "--normal"
      position: 1

  no_normal_bam_file:
    type: ["null", boolean]
    inputBinding:
      prefix: "--normal"
      position: 1

  targets_file:
    type: ["null", File]
    inputBinding:
      prefix: "--targets"
      position: 1

  anti_targets_file:
    type: ["null", File]
    inputBinding:
      prefix: "--antitargets"
      position: 1
      
  reference_file:
    type: ["null", File]
    inputBinding:
      prefix: "--annotate"
      position: 1
      
  fasta_file:
    type: ["null", File]
    inputBinding:
      prefix: "--fasta"
      position: 1

  output_reference:
    type: ["null", string]
    inputBinding:
      prefix: "--output-reference"
      position: 1
      
  output_dir:
    type: string
    default: results
    inputBinding:
      prefix: "--output-dir"
      position: 1
      
outputs:

  cnr:
    type: File
    outputBinding:
      glob: ./*.cnr

  cns:
    type: File
    outputBinding:
      glob: ./*.cns
