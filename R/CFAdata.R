#' Colony Formation Assay data on cell cooperativity
#'
#' Clonogenic Survival Data from seven cell lines
#'
#' @docType data
#'
#' @usage data(CFAdata)
#'
#' @format \code{data.frame}
#'
#' @keywords dataset
#'
#' @references Brix et al. (2020) Radiation Oncology ...
#'
#' @examples
#' data(CFAdata)
#' head(CFAdata)
#' cll <- levels(CFAdata$cell.line)
#' SF <- vector("list",2)
#' SF[[1]] <- analyse_survival(RD = subset.data.frame(x = CFAdata,
#'   subset = (CFAdata$cell.line==cll[1]))[,-1],
#'   name = cll[1], xtreat = c(0,1,2,4,6,8))
#' SF[[2]] <- analyse_survival(RD = subset.data.frame(x = CFAdata,
#'   subset = (CFAdata$cell.line==cll[7]))[,-1],
#'   name = cll[7], xtreat = c(0,1,2,4,6,8))
#'plot_SF(SF)
"CFAdata"
