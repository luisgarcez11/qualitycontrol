
#' Read QC mapping variable
#'
#' @description `read_qc_mapping` reads an `.xlsx` file that contains 
#' the QC mapping.
#' 
#' @param path excel file path to be read. Each tab should contain
#' 3 tabs with the names missing, inconsistencies and range. Each tab
#' will correspond to one QC mapping table.
#' 
#' 
#' QC mapping `excel` file shoud contain 3 tabs:
#' * missing: columns should be named as "qc_type", 
#' "variable" and `type".
#' * inconsistencies: columns should be named as "qc_type", 
#' "variable1", "type1", "relation", "variable2" and "type2".
#' * range: columns should be named as "qc_type", 
#' "variable", "type", "lower_value", "upper_value" and "categories".
#' 
#' The columns specified above should contain specific values:
#' * qc_type: "missing", "duplicated", "inconsistent_values" and "range"
#' * variable, variable1, variable2: variable name that is included in data.
#' * type, type1, type2: "numeric", text", "categorical", "date"
#' * relation: expected relation between variable1 and variable2 which can be
#' "greater_than", "greater_than_or_equal", "lower_than", "lower_than_or_equal" or "equal".
#' * lower_value, upper_value: expected numeric values representing ranges
#' * categories: expected variable categories
#' 
#' @return A list containing all the QC mapping tables
#' @export
read_qc_mapping <- function(path){
  
  excelsheets <- readxl::excel_sheets(path)
  
  qc_mapping <- list()
  
  
  if("missing" %in% excelsheets){
    
    qc_mapping$missing <- readxl::read_excel(path, sheet = "missing", col_types = "text")
    for( i in c("qc_type","variable", "type")){if(! i %in% names(qc_mapping$missing)){
      stop(paste( "no column named", i, "in missing tab"))
    }}
    
    stopifnot(qc_mapping$missing$qc_type %in% c("missing", "duplicated",
                                                "inconsistent_values","range"))
    stopifnot(qc_mapping$missing$type %in% c("numeric", "text", "categorical", "date"))
    
    }
  
  if("inconsistencies" %in% excelsheets){
    qc_mapping$inconsistencies <- readxl::read_excel(path, 
                                                     sheet = "inconsistencies", col_types = "text")
    
    for( i in c("qc_type", "variable1", "type1", "relation", "variable2", "type2")){
      if(! i %in% names(qc_mapping$inconsistencies)){
        stop(paste( "no column named", i, "in missing tab"))}}
    
    stopifnot(qc_mapping$inconsistencies$qc_type %in% c("missing", "duplicated",
                                                "inconsistent_values","range"))
    stopifnot(qc_mapping$inconsistencies$type1 %in% c("numeric", "text", "categorical", "date"))
    stopifnot(qc_mapping$inconsistencies$type2 %in% c("numeric", "text", "categorical", "date"))
    stopifnot(qc_mapping$inconsistencies$relation %in% c("greater_than", "greater_than_or_equal",
                                                 "lower_than", "lower_than_or_equal", 
                                                 "equal"))
    
    
  }
  
  
  
  if("range" %in% excelsheets){
    qc_mapping$range <- readxl::read_excel(path, sheet = "range", col_types = "text")
    
    for( i in c("qc_type", "variable", "type", "lower_value", "upper_value", "categories")){
      if(! i %in% names(qc_mapping$range)){
        stop(paste( "no column named", i, "in range tab"))}}
    
    stopifnot(qc_mapping$range$qc_type %in% c("missing", "duplicated",
                                                "inconsistent_values","range"))
    stopifnot(qc_mapping$range$type %in% c("numeric", "text", "categorical", "date"))
    
    }
  
  
  
  return(qc_mapping)
  
}
