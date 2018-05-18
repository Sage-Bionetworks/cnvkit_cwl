#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: etal/cnvkit

baseCommand: [cnvkit.py, target]

requirements:
  - class: InlineJavascriptRequirement

inputs:

  bed_file:
    type: File
    inputBinding:
      position: 0
      
  reference_file:
    type: ["null", File]
    inputBinding:
      prefix: "--annotate"
      position: 1
      
  short_names:
    type: ["null", boolean]
    inputBinding:
      prefix: "--short-names"
      position: 1

  splits:
    type: ["null", boolean]
    inputBinding:
      prefix: "--split"
      position: 1
    
  avg-size:
    type: ["null", float]
    inputBinding:
      prefix: "--avg-size"
      position: 1
      
  output:
    type: string
    default: "target.bed"
    inputBinding:
      prefix: "--output"
      position: 1

outputs:

  output_bed:
    type: File
    outputBinding:
      glob: $(inputs.output)