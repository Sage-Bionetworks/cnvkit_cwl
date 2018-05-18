#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: etal/cnvkit

baseCommand: [cnvkit.py, autobin]

requirements:
  - class: InlineJavascriptRequirement

inputs:

  normal_bam_files:
    type:
      type: array
      items: File
    inputBinding:
      position: 0
  
  access_file:
    type: ["null", File]
    inputBinding:
      prefix: "--access"
      position: 1
      
  targets_file:
    type: ["null", File]
    inputBinding:
      prefix: "--targets"
      position: 1
      
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

outputs:

  targets: 
    type: File
    outputBinding:
      glob: *.target.bed
      
  antitargets: 
    type: File
    outputBinding:
      glob: *.antitarget.bed