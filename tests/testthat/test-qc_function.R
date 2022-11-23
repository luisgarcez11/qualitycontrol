library(testthat)


test_that("dimensions/output", {

  testthat::expect_true(is.data.frame(qualitycontrol::qc_data(als_data, als_data_qc_mapping)))
  testthat::expect_true(is.data.frame(qualitycontrol::qc_data(als_data %>% 
                                                                dplyr::slice(1:nrow(als_data)), als_data_qc_mapping)))
  
  
  als_data_qc_mapping_error1 <- als_data_qc_mapping
  als_data_qc_mapping_error1$missing$variable[1] <- "eminem"
  testthat::expect_error(qualitycontrol::qc_data(als_data, als_data_qc_mapping_error1))
  
  als_data_qc_mapping_error2 <- als_data_qc_mapping
  als_data_qc_mapping_error2$range$variable[1] <- "eminem"
  testthat::expect_error(qualitycontrol::qc_data(als_data, als_data_qc_mapping_error2))
  
  als_data_qc_mapping_error3 <- als_data_qc_mapping
  als_data_qc_mapping_error3$inconsistencies$variable1[1] <- "eminem"
  testthat::expect_error(qualitycontrol::qc_data(als_data, als_data_qc_mapping_error3))
  
  als_data_qc_mapping_error4 <- als_data_qc_mapping
  als_data_qc_mapping_error4$inconsistencies$variable1[1] <- "eminem"
  testthat::expect_error(qualitycontrol::qc_data(als_data, als_data_qc_mapping_error4))
  
  


})


