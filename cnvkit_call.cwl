#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: etal/cnvkit

baseCommand: [cnvkit.py, call]

requirements:
  - class: InlineJavascriptRequirement

inputs:

  cns_file:
    type: File
    inputBinding:
      position: 0
      
  method:
    type: ["null", string]
    inputBinding:
      prefix: "--method"
      position: 1
    
  purity:
    type: ["null", float]
    inputBinding:
      prefix: "--purity"
      position: 1
      
  vcf:
    type: ["null", File]
    secondaryFiles: .tbi
    inputBinding:
      prefix: "--vcf"
      position: 1

  sample_id:
    type: ["null", string]
    inputBinding:
      prefix: "--sample-id"
      position: 1

outputs:

  output:
    type: File
    outputBinding:
      glob: ./*.cns