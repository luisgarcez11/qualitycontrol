
# objective ---------------------------------------------------------------

#read data and save into data folder


# 00_library --------------------------------------------------------------

library(xlsx)
library(testthat)
library(usethis)

# 01_read -----------------------------------------------------------------

als_data_qc_mapping <- list()

missing <- xlsx::read.xlsx("data-raw/qc_mapping.xlsx", sheetName = "missing")
range <- xlsx::read.xlsx("data-raw/qc_mapping.xlsx", sheetName = "range")
inconsistencies <- xlsx::read.xlsx("data-raw/qc_mapping.xlsx", sheetName = "inconsistencies")
als_data_qc_mapping$missing <- missing
als_data_qc_mapping$range <- range
als_data_qc_mapping$inconsistencies <- inconsistencies

als_data <- xlsx::read.xlsx("data-raw/qc_mapping.xlsx", sheetName = "dataset")


# 02_tests -------------------------------------------------------------------

testthat::expect_true(all(missing$type %in% c("text", "numeric", "categorical", "date")),
                      info = "variable type must be 'text', 'numeric', 'categorical' or 'date'")

testthat::expect_true(all(missing$variable %in% names(als_data)),
                      info = "variable type must be 'text', 'numeric', 'categorical' or 'date'")

testthat::expect_true(all(range$type %in% c("text", "numeric", "categorical", "date")),
                      info = "variable type must be 'text', 'numeric', 'categorical' or 'date'")

testthat::expect_true(all(range$variable %in% names(als_data)),
                      info = "variable type must be 'text', 'numeric', 'categorical' or 'date'")

testthat::expect_true(all(inconsistencies$type %in% c("text", "numeric", "categorical", "date")),
                      info = "variable type must be 'text', 'numeric', 'categorical' or 'date'")

testthat::expect_true(all(inconsistencies$variable %in% names(als_data)),
                      info = "variable type must be 'text', 'numeric', 'categorical' or 'date'")

testthat::expect_true(all(inconsistencies$relation %in% c("greater_than", "greater_than_equal","lower_than", "lower_than_equal","equal")),
                      info = "variable type must be 'text', 'numeric', 'categorical' or 'date'")


# 03_save -----------------------------------------------------------------

usethis::use_data(als_data, overwrite = TRUE)
usethis::use_data(als_data_qc_mapping, overwrite = TRUE)

