#' Colony Formation Assay data on cell cooperativity
#'
#' Clonogenic survival data from seven cell lines T47D, MDA-MB231, A549,
#' HCC1806, SKBR3, SKLU1 and BT20 as presented in Brix et al. (2020).
#'
#' @docType data
#'
#' @usage data(CFAdata)
#'
#' @format \code{data.frame}
#'
#' @keywords dataset
#'
#' @references Brix et al. (2020) Radiation Oncology, "The clonogenic assay:
#' robustness of plating efficiency-based analysis is strongly compromised by
#' cellular cooperation"
#'
#' @examples
#' data(CFAdata)
#' head(CFAdata)
#' cll <- levels(CFAdata$cell.line)
"CFAdata"
