library(testthat)


test_that("dimensions/output", {

  testthat::expect_true(is.data.frame(qualitycontrol::qc_data(als_data, als_data_qc_mapping)))
  testthat::expect_true(is.data.frame(qualitycontrol::qc_data(als_data, als_data_qc_mapping,
                                                              output_file =  testthat::test_path("write_test.xlsx"))))
  testthat::expect_true(is.data.frame(qualitycontrol::qc_data(als_data %>% 
                                                                dplyr::slice(1:nrow(als_data)), als_data_qc_mapping)))
  
  
  als_data_qc_mapping_error1 <- als_data_qc_mapping
  als_data_qc_mapping_error1$missing$variable[1] <- "eminem"
  testthat::expect_error(qualitycontrol::qc_data(als_data, als_data_qc_mapping_error1))
  
  als_data_qc_mapping_error1 <- als_data_qc_mapping
  als_data_qc_mapping_error1$missing$variable[2] <- "eminem"
  testthat::expect_error(qualitycontrol::qc_data(als_data, als_data_qc_mapping_error1))
  
  als_data_qc_mapping_error2 <- als_data_qc_mapping
  als_data_qc_mapping_error2$range$variable[1] <- "eminem"
  testthat::expect_error(qualitycontrol::qc_data(als_data, als_data_qc_mapping_error2))
  
  als_data_qc_mapping_error3 <- als_data_qc_mapping
  als_data_qc_mapping_error3$inconsistencies$variable1[1] <- "eminem"
  testthat::expect_error(qualitycontrol::qc_data(als_data, als_data_qc_mapping_error3))
  
  als_data_qc_mapping_error4 <- als_data_qc_mapping
  als_data_qc_mapping_error4$inconsistencies$variable2[1] <- "eminem"
  testthat::expect_error(qualitycontrol::qc_data(als_data, als_data_qc_mapping_error4))
  
  als_data_qc_mapping_error5 <- als_data_qc_mapping
  als_data_qc_mapping_error5$missing <- als_data_qc_mapping_error5$missing %>% dplyr::slice(0)
  als_data_qc_mapping_error5$range <- als_data_qc_mapping_error5$range %>% dplyr::slice(0)
  als_data_qc_mapping_error5$inconsistencies <- als_data_qc_mapping_error5$inconsistencies %>% dplyr::slice(0)
  testthat::expect_true(is.list(qualitycontrol::qc_data(als_data, als_data_qc_mapping_error5)))
  
  #test range
  testthat::expect_error(qualitycontrol::test_range(als_data, "onset", 
                                                   type = "categorical"))
  testthat::expect_error(qualitycontrol::test_range(data = als_data, variable = "p2", 
                                                    type = "numeric", lower_value = 0))
  testthat::expect_error(qualitycontrol::test_range(als_data, "p1", 
                                                    type = "numeric", upper_value = 4))
  
  testthat::expect_error(qualitycontrol::test_range(data = als_data, variable = "death_date", 
                                                    type = "date", lower_value = 0))
  testthat::expect_error(qualitycontrol::test_range(als_data, "death_date", 
                                                    type = "date", upper_value = 4))
  
  #test inconsistencies
  testthat::expect_true(is.data.frame(qualitycontrol::test_inconsistencies(als_data,
                                                              variable1 = "age_at_baseline", 
                                                              variable2 = "age_at_onset",
                                                              relation = 'greater_than_or_equal')))
  
  testthat::expect_true(is.data.frame(qualitycontrol::test_inconsistencies(als_data, 
                                                              variable1 = "age_at_baseline", 
                                                              variable2 = "age_at_onset",
                                                              relation = 'lower_than_or_equal')))
  
  
  


})


