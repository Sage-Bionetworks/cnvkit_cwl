#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: etal/cnvkit

baseCommand: [cnvkit.py, access]

requirements:
  - class: InlineJavascriptRequirement

inputs:

  fasta_file:
    type: File
    inputBinding:
      position: 0
      
  min_gap_size:
    type: ["null", int]
    inputBinding:
      prefix: "--min-gap-size"
      position: 1
    
  exclude:
    type: ["null", File]
    inputBinding:
      prefix: "--exclude"
      position: 1
      
  output:
    type: string
    default: "access.bed"
    inputBinding:
      prefix: "--output"
      position: 1

outputs:

  output_bed:
    type: File
    outputBinding:
      glob: $(inputs.output)