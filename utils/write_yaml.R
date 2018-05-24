require(yaml)
require(purrr)

create_cnvkit_synapse_workflow_yaml <- function(
    yaml_file,
    synapse_config_file,
    upload_id,
    tumor_bam_synapse_id,
    normal_bam_synapse_id,
    targets_synapse_id,
    reference_synapse_id,
    fasta_synapse_id,
    
    output_cns_name,
    output_cnr_name,
    output_metrics_name,
    output_segmetrics_name,
    
    tumor_purity,
    call_method = "clonal", 
    segmetrics_std = "True",
    segmetrics_mad = "True",
    segmetrics_sem = "True",
    segmetrics_ci = "True",
    annotations = NULL
){
    file_list <- list(
        "synapse_config_file" = file_to_yaml_file(synapse_config_file),
        "yaml_config_file" = file_to_yaml_file(yaml_file))
    other_list <- list(
        "upload_id" = upload_id,
        "tumor_bam_synapse_id" = tumor_bam_synapse_id,
        "normal_bam_synapse_id" = normal_bam_synapse_id,
        "targets_synapse_id" = targets_synapse_id,
        "reference_synapse_id" = reference_synapse_id,
        "fasta_synapse_id" = fasta_synapse_id,
        
        "output_cns_name" = output_cns_name,
        "output_cnr_name" = output_cnr_name,
        "output_metrics_name" = output_metrics_name,
        "output_segmetrics_name" = output_segmetrics_name,
        
        "tumor_purity" = tumor_purity,
        "call_method" = call_method, 
        "segmetrics_std" = segmetrics_std,
        "segmetrics_mad" = segmetrics_mad,
        "segmetrics_sem" = segmetrics_sem,
        "segmetrics_ci" = segmetrics_ci,
        "annotations" = annotations)
    
    
    file_list <- purrr::discard(file_list, function(item) 
        is.null(item$path))  
    other_list <- purrr::discard(other_list, is.null)
    lst <- (c(file_list, other_list))
    yaml::write_yaml(lst, yaml_file)
    yaml_file %>% 
        readLines %>% 
        str_replace_all('yes', 'True') %>% 
        writeLines(yaml_file)
}


file_to_yaml_file <- function(file){
    list("path" = file, "class" = "File")
}

