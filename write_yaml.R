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
    lst <- list(
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
                 "class" = "File"))
    lst <- purrr::discard(lst, function(item) 
        is.null(item$path))  
    print(lst)

    

}

create_cnvkit_batch_yaml("yml", "bam")




# lst2 <- list(
#     "no_normal_bam_file" = NULL,
#     "output_reference" = output_reference,
#     "output_dir" = output_dir) 
# if(is.null(lst$normal_bam_file)) lst["no_normal_bam_file"] <- TRUE
# lst <- purrr::discard(lst, is.null)   
# yml <- yaml::as.yaml(lst)
# yaml::write_yaml(yml, yaml_file)
