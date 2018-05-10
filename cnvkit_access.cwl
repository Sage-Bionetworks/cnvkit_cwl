#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  DockerRequirement:
    dockerPull: etal/cnvkit

<<<<<<< HEAD
baseCommand: [cnvkit.py, access, -o, output.bed]
=======
baseCommand: [cnvkit.py, access]

requirements:
  - class: InlineJavascriptRequirement
>>>>>>> d07168b679f5db9207f362491b33e56a7740b043

inputs:

  fasta_file:
    type: File
    inputBinding:
<<<<<<< HEAD
      position: 1
      
=======
      prefix: "--fasta"
      position: 1
      
 output_reference_string:
    type: ["null", string]
    inputBinding:
      prefix: "--output-reference"
      position: 1

>>>>>>> d07168b679f5db9207f362491b33e56a7740b043
outputs:

  output_bed:
    type: File
    outputBinding:
<<<<<<< HEAD
      glob: output.bed
=======
      glob: (inputs.output_reference_string)
>>>>>>> d07168b679f5db9207f362491b33e56a7740b043
