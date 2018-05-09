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
      prefix: "--fasta"
      position: 1
      
 output_reference_string:
    type: ["null", string]
    inputBinding:
      prefix: "--output-reference"
      position: 1

outputs:

  output_bed:
    type: File
    outputBinding:
      glob: (inputs.output_reference_string)