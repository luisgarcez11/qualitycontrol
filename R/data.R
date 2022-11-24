#' Amyotrophic lateral sclerosis Example dataset
#'
#' An Amyotrophic lateral sclerosis related example dataset.
#'
#' @format A list
#' \itemize{
#'   \item{subjid}{Subject ID}
#'   \item{p1}{ALSFRS-R 1}
#'   \item{p2}{ALSFRS-R 2}
#'   \item{p3}{ALSFRS-R 3}
#'   \item{p4}{ALSFRS-R 4}
#'   \item{p5}{ALSFRS-R 5}
#'   \item{p6}{ALSFRS-R 6}
#'   \item{p7}{ALSFRS-R 7}
#'   \item{p8}{ALSFRS-R 8}
#'   \item{p9}{ALSFRS-R 9}
#'   \item{x1r}{ALSFRS-R R1}
#'   \item{x2r}{ALSFRS-R R2}
#'   \item{x3r}{ALSFRS-R R3}
#'   \item{age_at_baseline}{Age at baseline}
#'   \item{age_at_onset}{Age at onsite}
#'   \item{onset}{Region of onset}
#'   \item{baseline_date}{Baseline date3}
#'   \item{death_date}{Death date}
#' }
'als_data'

#' An example dataset containing a Quality Control mapping
#'
#' @format A list of 3 `tibbles`.
#' 
#' \itemize{
#'   \item{missing}{Table with all the 'missing' tests.  }
#'   \item{inconsistencies}{Table with all the 'inconsistencies' tests.}
#'   \item{range}{Table with all the 'out of range' tests.}
#'   }
'als_data_qc_mapping'
