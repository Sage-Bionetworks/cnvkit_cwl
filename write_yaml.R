require(yaml)
require(purrr)


create_cnvkit_batch_yaml <- function(
    yaml_file,
    tumor_bam_file,
    normal_bam_file = NULL,
    targets_file = NULL,
    anti_targets_file = NULL,
    reference_file = NULL,
    fasta_file = NULL,
    output_reference = NULL,
    output_dir = NULL
){
    lst <- list("tumor_bam_file" = tumor_bam_file,
                "normal_bam_file" = normal_bam_file,
                "no_normal_bam_file" = NULL,
                "targets_file" = targets_file,
                "anti_targets_file" = anti_targets_file,
                "reference_file" = reference_file,
                "fasta_file" = fasta_file,
                "output_reference" = output_reference,
                "output_dir" = output_dir) 
    if(is.null(lst$normal_bam_file)) lst["no_normal_bam_file"] <- "TRUE"
    lst <- purrr::discard(lst, is.null)   
    yml <- yaml::as.yaml(lst)
    yaml::write_yaml(yml, yaml_file)
}