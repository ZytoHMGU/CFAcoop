#' @title  pwr_reg
#'
#' @description \code{pwr_reg} calculates a power regression for cell
#'   cooperativity experiments from Colony Formation Assay (CFA) data
#'
#' @param x data.frame or matrix of dimension n x 2:
#'   first column contains number of cells seeded,
#'   second to n-th column contains number of colonies counted
#'
#' @return \code{summary.lm} object as returned by \code{\link{summary}}
#'
#' @examples
#' df.xmpl <- data.frame("seeded" = 10^(seq(1,5,0.5)),
#'               "counted" = 0.4*10^(seq(1,5,0.5)+rnorm(n = 9,0,0.1))^1.25)
#' pwr_reg(x = df.xmpl)
#' @export
#' @importFrom stats "lm"
pwr_reg <- function(x) {
  if (!(class(x) %in% c("data.frame", "matrix"))) {
    warning(paste0(
      " x is of class ",
      class(x),
      ", but must be of class data.frame or matrix "
    ))
    return()
  }
  if (ncol(x) > 2) {
    warning(" x has too many columns; first and second are selected. ")
    x <- x[, 1:2]
  }
  colnames(x) <- c("S", "C")
  if (sum(x$C == 0, na.rm = TRUE) > 0) {
    warning(
      "log(0) = -Inf; power regression not applicable to null-valued variables;
      data points removed from analysis,
      consider averaging before power regression."
    )
    x <- x[x$C > 0,]
  }
  x$lnS <- log(x$S)
  x$lnC <- log(x$C)
  fit <- lm(formula = "lnC ~ 1 + lnS", data = x)
  sfit <- summary(fit)
  return(sfit)
}
