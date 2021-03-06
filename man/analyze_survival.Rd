% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/analyze_survival.R
\name{analyze_survival}
\alias{analyze_survival}
\title{analyze_survival}
\usage{
analyze_survival(RD, name = "no name", xtreat = NULL, C = 20)
}
\arguments{
\item{RD}{data.frame or matrix containing a table of experiment data}

\item{name}{optional: experiment name (e.g. name of cell line)}

\item{xtreat}{optional: treatment dose of the colonies counted in the
corresponding columns of RD}

\item{C}{number of colonies counted for which the survival fraction is to be
calculated (default = 20))}
}
\value{
list object containing several experiments and treatments organized
  for convenient plotting with \code{plot_sf}
}
\description{
wrapper function for robust analysis of clonogenic survival data
  from the colony formation assay according to Brix et al. (2020),
  Radiation Oncology.
  Mean values are calculated and used for power regression.
  Resulting coefficients are used for
  calculation of survival fractions and corresponding uncertainty analysis.
}
\examples{
seeded <- rep(10^(seq(1,5,0.5)),each = 3)
df.1 <- data.frame(
  "seeded" = seeded,
  "counted1" = 0.4 * seeded^1.1 * rnorm(n = length(seeded),1,0.05),
  "counted2" = 0.2 * seeded^1.125 * rnorm(n = length(seeded),1,0.05),
  "counted3" = 0.05 * seeded^1.25 * rnorm(n = length(seeded),1,0.05))
df.2 <- data.frame("seeded" = seeded,
  "counted1" = 0.5 * seeded^1.01 * rnorm(n = length(seeded),1,0.05),
  "counted2" = 0.4 * seeded^1.0125 * rnorm(n = length(seeded),1,0.05),
  "counted3" = 0.2 * seeded^1.025 * rnorm(n = length(seeded),1,0.05))
SF <- vector("list",2)
SF[[1]] <- analyze_survival(RD = df.1,
                            name = "cell line a",
                            xtreat = c(0,1,4),
                            C = 20)
SF[[2]] <- analyze_survival(RD = df.2,
                            name = "cell line b",
                            xtreat = c(0,1,4))
}
