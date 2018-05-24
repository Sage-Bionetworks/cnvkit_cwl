#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: etal/cnvkit

baseCommand: [cnvkit.py, metrics]

inputs:

  cnr_file:
    type: File
    inputBinding:
      position: 0

  cns_file:
    type: File
    inputBinding:
      prefix: "--segments"
      position: 1
      
  output_file:
    type: string
    default: "metrics.tsv"
    inputBinding:
      prefix: "--output"
      position: 1

outputs:

  output:
    type: File
    outputBinding:
      glob: ./*