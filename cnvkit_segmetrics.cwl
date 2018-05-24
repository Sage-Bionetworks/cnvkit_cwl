#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: etal/cnvkit

baseCommand: [cnvkit.py, segmetrics]

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

  std:
    type: ["null", boolean]
    inputBinding:
      prefix: "--std"
      position: 1  
      
  mad:
    type: ["null", boolean]
    inputBinding:
      prefix: "--mad"
      position: 1  
      
  sem:
    type: ["null", boolean]
    inputBinding:
      prefix: "--sem"
      position: 1  
      
  confint:
    type: ["null", boolean]
    inputBinding:
      prefix: "--ci"
      position: 1  

outputs:

  output:
    type: File
    outputBinding:
      glob: ./*