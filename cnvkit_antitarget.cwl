#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: etal/cnvkit

baseCommand: [cnvkit.py, antitarget]

requirements:
  - class: InlineJavascriptRequirement

inputs:

  bed_file:
    type: File
    inputBinding:
      position: 0
      
  access_file:
    type: ["null", File]
    inputBinding:
      prefix: "--access"
      position: 1
      
  output:
    type: string
    default: "antitarget.bed"
    inputBinding:
      prefix: "--output"
      position: 1

outputs:

  output_bed:
    type: File
    outputBinding:
      glob: $(inputs.output)