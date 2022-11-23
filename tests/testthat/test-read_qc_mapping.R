
test_that("dimension/expected errors", {


  obj <- qualitycontrol::read_qc_mapping(path = "data-raw/qc_mapping.xlsx")

  testthat::expect_gte(length(obj), 1)
  testthat::expect_true(is.list(obj))
  
  
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error1.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error2.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error3.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error4.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error5.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error6.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error7.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error8.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error9.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error10.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error11.xlsx"))
  testthat::expect_error(qualitycontrol::read_qc_mapping(path = "data-raw/test_datasets/qc_mapping_error12.xlsx"))



})
