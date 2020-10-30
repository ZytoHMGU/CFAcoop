#' @title  analyse_survival
#'
#' @description clonogenic survival data from the colony formation assay is
#'   processed with respect to cell cooperativity and robust calculation of
#'   survival fractions
#'
#' @param RD data.frame or matrix containing a table of experiment data
#' @param name experiment name (e.g. name of cell line)
#' @param xtreat treatment dose of the colonies counted in the corresponding
#'   columns of RD
#'
#' @return list object containing several experiments and treatments organized
#'   for convenient plotting
#'
#' @examples
#' seeded <- rep(10^(seq(1,5,0.5)),each = 3)
#' counted1 <- 0.4 * seeded^1.1 * rnorm(n = length(seeded),1,0.05)
#' counted2 <- 0.2 * seeded^1.125 * rnorm(n = length(seeded),1,0.05)
#' counted3 <- 0.05 * seeded^1.25 * rnorm(n = length(seeded),1,0.05)
#' df.1 <- data.frame("seeded" = seeded,
#'               "counted1" = counted1,
#'               "counted2" = counted2,
#'               "counted3" = counted3)
#' seeded <- rep(10^(seq(1,5,0.5)),each = 3)
#' counted1 <- 0.5 * seeded^1.01 * rnorm(n = length(seeded),1,0.05)
#' counted2 <- 0.4 * seeded^1.0125 * rnorm(n = length(seeded),1,0.05)
#' counted3 <- 0.2 * seeded^1.025 * rnorm(n = length(seeded),1,0.05)
#' df.2 <- data.frame("seeded" = seeded,
#'               "counted1" = counted1,
#'               "counted2" = counted2,
#'               "counted3" = counted3)
#' SF <- vector("list",2)
#' SF[[1]] <- analyse_survival(RD = df.1,name = "cell line a",xtreat = c(0,1,4))
#' SF[[2]] <- analyse_survival(RD = df.2,name = "cell line b",xtreat = c(0,1,4))
#' @importFrom stats "aggregate"
#' @export
#'
analyse_survival <- function(RD, name = "no name", xtreat = NULL) {
  if (!(class(RD) %in% c("data.frame","matrix"))){
    stop("error: RD must be of class data.frame or matrix")
  }
  result <- list("name" = name)
  if (is.null(xtreat)) {
    result$"xtreat" <- 0:(ncol(RD) - 2)
  } else {
    if (length(xtreat) != (ncol(RD) - 1)) {
      stop("error: length of assigned treatments does not match data ")
    }
    result$"xtreat" <- xtreat
  }
  result$"raw" <- as.data.frame(RD)
  result$"mean" <-
    aggregate(
      x = result$raw,
      by = list(result$raw[, 1]),
      FUN = "mean",
      na.rm = TRUE
    )
  result$"fit" <- vector("list", dim(RD)[2] - 1)
  result$"SF" <- vector("list", dim(RD)[2] - 2)
  result$"fit"[[1]] <- pwr_reg(seeded = result$"mean"[, 2],
                               counted = result$"mean"[, 3])
  for (i in seq_along(result$"fit")[-1]) {
    result$"fit"[[i]] <- pwr_reg(seeded = result$"mean"[, 2],
                                 counted = result$"mean"[, i + 2])
    ran_ref <- range(result$"raw"[, 2],na.rm = TRUE)
    ran_tre <- range(result$"raw"[, i + 1],na.rm = TRUE)
    if ( (ran_ref[2] >= ran_tre[1] ) & (ran_ref[1]) <= ran_tre[2] ){
      result$"SF"[[i - 1]] <- calculate_sf(
        par_ref = result$"fit"[[1]],
        par_treat = result$"fit"[[i]],
        c_range = c(5, 100)
      )
    } else {
      warning("warning: SF calculation omitted, range of colonies counted
              in reference and treated cells do not overlap.")
      result$"SF"[[i - 1]] <- NaN
    }
    # Pref<- mvtnorm::rmvnorm(n = 10^4,mean = hhh$fit[[1]]$coefficients[,1],
    #                         sigma = vcov(hhh$fit[[1]]))
    # result$SF_uncertainty <- c(calculate_sf())
  }
  return(result)
}
