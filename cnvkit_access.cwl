#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: etal/cnvkit

baseCommand: [cnvkit.py, access, -o, output.bed]

inputs:

  fasta_file:
    type: File
    inputBinding:
      position: 1
      
outputs:

  output_bed:
    type: File
    outputBinding:
      glob: output.bed
