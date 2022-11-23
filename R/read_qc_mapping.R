
#' Read QC mapping variable
#'
#' @description `data_qc_mapping` reads an `.xlsx` file that contains 
#' the QC mapping.
#' 
#' @param file excel file path to be read. Each tab should contain
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
#' * lower_value, upper_value: expected numeric values respresenting ranges
#' * categories: expected variable categories
#' 
#' @return A list containing all the QC mapping tables
#' @export
#' 
data_qc_mapping <- function(file){
  
  excelsheets <- readxl::excel_sheets(file)
  
  qc_mapping <- list()
  
  if("missing" %in% excelsheets){
    
    qc_mapping$missing <- readxl::read_excel("data-raw/qc_mapping.xlsx", sheet = "missing")
    for( i in c("qc_type","variable", "type")){if(! i %in% names(qc_mapping$missing)){
      stop(paste( "no column named", i, "in missing tab"))
    }}
    
    stopifnot(qc_mapping$missing$type %in% c("numeric", "text", "categorical", "date"))
    
    }
  
  if("inconsistencies" %in% excelsheets){
    qc_mapping$inconsistencies <- readxl::read_excel("data-raw/qc_mapping.xlsx", 
                                                     sheet = "inconsistencies")
    
    for( i in c("qc_type", "variable1", "type1", "relation", "variable2", "type2")){
      if(! i %in% names(qc_mapping$inconsistencies)){
        stop(paste( "no column named", i, "in missing tab"))}}
    
    stopifnot(qc_mapping$missing$qc_type %in% c("missing", "duplicated",
                                                "inconsistent_values","range"))
    stopifnot(qc_mapping$missing$type1 %in% c("numeric", "text", "categorical", "date"))
    stopifnot(qc_mapping$missing$type2 %in% c("numeric", "text", "categorical", "date"))
    stopifnot(qc_mapping$missing$relation %in% c("greater_than", "greater_than_or_equal",
                                                 "lower_than", "lower_than_or_equal", 
                                                 "equal"))
    
    
  }
  
  
  
  if("range" %in% excelsheets){
    qc_mapping$range <- readxl::read_excel("data-raw/qc_mapping.xlsx", sheet = "range")
    
    for( i in c("qc_type", "variable", "type", "lower_value", "upper_value", "categories")){
      if(! i %in% names(qc_mapping$range)){
        stop(paste( "no column named", i, "in range tab"))}}
    
    stopifnot(qc_mapping$missing$qc_type %in% c("missing", "duplicated",
                                                "inconsistent_values","range"))
    stopifnot(qc_mapping$missing$type %in% c("numeric", "text", "categorical", "date"))
    stopifnot(!stringr::str_detect(qc_mapping$missing$lower_value, "\\w") )
    stopifnot(!stringr::str_detect(qc_mapping$missing$lower_value, "[:symbol:]") )
    
    }
  
  
  
  return(qc_mapping)
  
}
