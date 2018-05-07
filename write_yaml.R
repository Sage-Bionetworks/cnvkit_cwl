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
    access_file = NULL,
    access_file_string = NULL
){
    file_list <- list(
        "tumor_bam_file" = 
            list("path" = tumor_bam_file,
                 "class" = "File"),
        "normal_bam_file" = 
            list("path" = normal_bam_file,
                 "class" = "File"),
        "targets_file" = 
            list("path" = targets_file,
                 "class" = "File"),
        "anti_targets_file" = 
            list("path" = anti_targets_file,
                 "class" = "File"),
        "reference_file" = 
            list("path" = reference_file,
                 "class" = "File"),
        "fasta_file" =
            list("path" =  fasta_file,
                 "class" = "File"),
        "access_file" =
            list("path" =  access_file,
                 "class" = "File"))
    file_list <- purrr::discard(file_list, function(item) 
        is.null(item$path))  
    other_list <- list(
        "no_normal_bam_file" = NULL,
        "output_reference" = output_reference,
        "access_file_string" = access_file_string)
    if(is.null(normal_bam_file)) other_list["no_normal_bam_file"] <- TRUE
    other_list <- purrr::discard(other_list, is.null)
    lst <- (c(file_list, other_list))
    yaml::write_yaml(lst, yaml_file)
}

