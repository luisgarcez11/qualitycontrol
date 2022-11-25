
#' Test the range of a variable on a dataset
#'
#' @param data data to be tested.
#' @param variable The variable to be tested.
#' @param type String such as 'categorical', 'date' or 'numeric'
#' @param categories Only to be filled if `type` is 'categorical'. String of categories.
#' @param lower_value Only to be filled if `type` is 'numeric' or 'date'. Can be numeric or string.
#' @param upper_value Only to be filled if `type` is 'numeric' or 'date'. Can be numeric or string.
#' 
#' @return A data frame containing all the findings regarding the applied test.
#' @export
#'
#' @examples
#' test_range(als_data, 'onset', c('bulbar','respiratory', 'spinal'), type = 'categorical')
#' test_range(als_data, 'age_at_baseline', lower_value = 20, upper_value = 100, 
#' type = 'numeric')
#' test_range(als_data, 'age_at_onset', lower_value = 20, upper_value = 100,
#' type = 'numeric')
#' test_range(als_data, 'baseline_date', lower_value = '2000-01-01', upper_value = '2022-01-01', 
#' type = 'date')
#' test_range(als_data, 'death_date', lower_value = '2000-01-01', upper_value = '2022-01-01',
#'  type = 'date')
test_range <- function(data, variable, type, categories = NULL, 
                       lower_value = NULL, upper_value = NULL){
  
  if(type == 'categorical'){
    
    data[[variable]] <- as.character(data[[variable]])
    
    if(is.null(categories)){stop('categories must be specified')}
    
    findings<- data[which(!data[[variable]] %in% categories),] %>% 
      dplyr::mutate(finding = paste('variable', variable, 'is not a category'))
  
  return(findings %>% dplyr::mutate_all(~as.character(.)))
  
  }
  
  if(type == 'numeric'){
    
    if(is.null(lower_value)){stop('lower value must be specified')}
    if(is.null(upper_value)){stop('upper value must be specified')}
    
    data[[variable]] <- as.numeric(data[[variable]])
    lower_value <- as.numeric(lower_value)
    upper_value <- as.numeric(upper_value)
    
    
    findings<- data[which(data[[variable]] < lower_value | data[[variable]] > upper_value),] %>% 
      dplyr::mutate(finding = paste('variable', variable,  'is out of range'))
    
    return(findings %>% dplyr::mutate_all(~as.character(.)))
    
  }
  
  if(type == 'date'){
    
    data[[variable]] <- as.character(data[[variable]])
    
    if(is.null(lower_value)){stop('lower value must be specified')}
    if(is.null(upper_value)){stop('upper value must be specified')}
    
    findings_format <- data[!stringr::str_detect(string = data[[variable]], 
                                                pattern = '\\d{4}(-|/)\\d{2}(-|/)\\d{2}') &
                             !is.na(data[[variable]]),] %>% 
      dplyr::mutate(finding = paste('variable', variable,  'is not on the right format'))
  
    
    findings <- data[which(as.Date(data[[variable]]) < as.Date(lower_value) | 
                             as.Date(data[[variable]]) > as.Date(upper_value)),] %>% 
      dplyr::mutate(finding = paste('variable', variable,  'is out of range'))
    
    return(dplyr::bind_rows(findings_format, findings) %>% dplyr::mutate_all(~as.character(.)))
    
  }
}

#' Test the inconsistencies between variables on a dataset
#'
#' @param data data to be tested.
#' @param variable1 The variable to be tested.
#' @param variable2 The variable to be tested.
#' @param relation String such as 'greater_than', 'greater_than_or_equal'
#' 'lower_than_or_equal' and 'lower_than'.
#' 
#' @return A data frame containing all the findings regarding the applied test.
#' @export
#'
#' @examples
#' test_inconsistencies(als_data, 'baseline_date', 'death_date', relation = 'lower_than')
#' test_inconsistencies(als_data, 'age_at_baseline', 'age_at_onset', relation = 'greater_than')
test_inconsistencies <- function(data, variable1, variable2, 
                                 relation){
  
  if(relation == 'greater_than'){
     
    findings <- data[which(data[[variable1]] <= data[[variable2]]),] %>% 
      dplyr::mutate(finding = paste('variables', variable1, 
                                    'lower than or equal to', variable2))
    return(findings %>% dplyr::mutate_all(~as.character(.)))
    
  }
  
  if(relation == 'greater_than_or_equal'){
    
    findings <- data[which(data[[variable1]] < data[[variable2]]),] %>% 
      dplyr::mutate(finding = paste('variables', variable1, 
                                    'lower than', variable2))
    return(findings %>% dplyr::mutate_all(~as.character(.)))
    
  }
  
  if(relation == 'lower_than_or_equal'){
    
    findings <- data[which(data[[variable1]] > data[[variable2]]),] %>% 
      dplyr::mutate(finding = paste('variables', variable1, 
                                    'greater than', variable2))
    return(findings %>% dplyr::mutate_all(~as.character(.)))
    
  }
  
  if(relation == 'lower_than'){
    
    findings <- data[which(data[[variable1]] >= data[[variable2]]),] %>% 
      dplyr::mutate(finding = paste('variables', variable1, 
                                    'greater than or equal to', variable2))
    return(findings %>% dplyr::mutate_all(~as.character(.)))
    
  }
  }
  

#' Test the variable missingness on a dataset
#'
#' @param data data to be tested.
#' @param variable The variable to be tested.
#' 
#' @return A data frame containing all the findings regarding the applied test.
#' @export
#'
#' @examples
#' test_missing(als_data, 'p8')
#' test_missing(als_data, 'p1')
test_missing <- function(data, variable){
  
  findings <- data[which(is.na(data[[variable]])),] %>% 
    dplyr::mutate(finding = paste('variable', variable, 
                                  'is missing'))
  return(findings %>% dplyr::mutate_all(~as.character(.)))

}



#' Test if variable values are duplicated
#'
#' @param data data to be tested.
#' @param variable The variable to be tested.
#' 
#' @return A data frame containing all the findings regarding the applied test.
#' @export
#'
#' @examples
#' test_duplicated(als_data, 'subjid')
test_duplicated <- function(data, variable){
  
  suppressMessages({findings_complete <- data %>% janitor::get_dupes() %>% 
    dplyr::mutate(finding = paste('rows are duplicated'))} )
  
  findings <- data %>% janitor::get_dupes(variable ) %>%
    dplyr::mutate(finding = paste( variable, 'variable is duplicated')) 
  
  if("dupe_count" %in% names(findings)){
    findings <- findings %>% dplyr::select(-"dupe_count")}
  if("dupe_count" %in% names(findings_complete)){
    findings_complete <- findings_complete %>% dplyr::select(-"dupe_count")}
  
  return(dplyr::bind_rows(findings,findings_complete) %>% dplyr::mutate_all(~as.character(.)))
  
}



#' QC dataset using a specific variable mapping
#'
#' @param data A data frame, data frame extension (e.g. a `tibble`) to be quality controlled.
#' @param qc_mapping A list of data frame or data frame extension (e.g. a `tibble`) 
#' specifying the tests. Each data frame row represents a test to the `data`.
#' @param output_file (optional) File path ended in `.xlsx` or `.xls`. 
#' If is not null, findings table to be written to this path.
#'
#' @importFrom dplyr %>%
#' @importFrom dplyr tibble
#'
#' @return A data frame containing all the findings.
#' @export
#'
#' @examples
#' qc_data(als_data, als_data_qc_mapping)
qc_data <- function(data, qc_mapping, output_file = NULL){
  
  findings <- dplyr::tibble()
  
  for(qc_battery in qc_mapping){
    
    
    if(nrow(qc_battery) == 0){next}
    
    for( test in 1:nrow(qc_battery)){
      
      qc_type <- as.character(qc_battery[test, 'qc_type'])
      
      if(qc_type == 'duplicated'){
        
        variable <-  as.character(qc_battery[test, 'variable'])

        #check variable names
        if(!variable %in% names(data)){stop(paste(variable, "is not a variable name"))}
        
        findings <- findings %>% dplyr::bind_rows(test_duplicated(data, variable))
      }
      
      if(qc_type == 'missing'){
        
        variable <-  as.character(qc_battery[test, 'variable'])
        
        #check variable names
        if(!variable %in% names(data)){stop(paste(variable, "is not a variable name"))}
        
        findings <- findings %>% dplyr::bind_rows(test_missing(data, variable))
      }
      
      if(qc_type == 'inconsistent_values'){
        
        variable1 <-  as.character(qc_battery[test, 'variable1'] )
        relation <-  as.character(qc_battery[test, 'relation'])
        variable2 <-  as.character(qc_battery[test, 'variable2'])
        
        #chack variable names
        if(!variable1 %in% names(data)){stop(paste(variable, "is not a variable name"))}
        if(!variable2 %in% names(data)){stop(paste(variable, "is not a variable name"))}
      
        findings <- findings %>% dplyr::bind_rows(test_inconsistencies(data,
                                                                variable1 = variable1,
                                                                relation = relation,
                                                                variable2 = variable2))
      }
      
      if(qc_type == 'range'){
        
        variable <-  as.character(qc_battery[test, 'variable'])
        type <- as.character(qc_battery[test, 'type'])
        lower_value <-  as.character(qc_battery[test, 'lower_value'])
        upper_value <-  as.character(qc_battery[test, 'upper_value'])
        categories <- as.character(qc_battery[test, 'categories'])
        if(!is.na(categories)){categories <- unlist(strsplit(categories, split = ',')) %>% stringr::str_squish()}
        
        findings <- findings %>% dplyr::mutate_all(~as.character(.)) %>% 
          dplyr::bind_rows(test_range(data,
                               variable = variable, 
                               type = type,lower_value = lower_value, 
                               upper_value = upper_value, 
                               categories = categories) %>% dplyr::mutate_all(~as.character(.)))
      }
      
    }
    
  }
  
  if(!is.null(output_file)){
    
    message(paste("writing findings in", output_file))
    openxlsx::write.xlsx(findings, file = output_file)
    return(findings)
  }
  
  return(findings)
}
  
 










