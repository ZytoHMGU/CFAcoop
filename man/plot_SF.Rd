% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_sf.R
\name{plot_sf}
\alias{plot_sf}
\title{plot_sf}
\usage{
plot_sf(SF, showUncertainty = TRUE)
}
\arguments{
\item{SF}{list build of objects returned by \code{analyze_survival}}

\item{showUncertainty}{logical, switches on/off uncertainty bands for
sf-values.}
}
\value{
none
}
\description{
plot cellular cooperativity and clonogenic survival for
colony formation assay data
}
\examples{
seeded <- rep(10^(seq(1, 5, 0.5)), each = 3)
df.1 <- data.frame(
  "seeded" = seeded,
  "counted1" = 0.4 * seeded^1.1 * rnorm(n = length(seeded), 1, 0.05),
  "counted2" = 0.2 * seeded^1.125 * rnorm(n = length(seeded), 1, 0.05),
  "counted3" = 0.05 * seeded^1.25 * rnorm(n = length(seeded), 1, 0.05)
)
df.2 <- data.frame(
  "seeded" = seeded,
  "counted1" = 0.5 * seeded^1.01 * rnorm(n = length(seeded), 1, 0.05),
  "counted2" = 0.4 * seeded^1.0125 * rnorm(n = length(seeded), 1, 0.05),
  "counted3" = 0.2 * seeded^1.025 * rnorm(n = length(seeded), 1, 0.05)
)
SF <- vector("list", 2)
SF[[1]] <- analyze_survival(
  RD = df.1, name = "cell line a",
  xtreat = c(0, 1, 4)
)
SF[[2]] <- analyze_survival(
  RD = df.2, name = "cell line b",
  xtreat = c(0, 1, 4)
)
plot_sf(SF)

data("CFAdata")
SF <- vector("list", 4)
ll <- levels(CFAdata$cell.line)[c(1, 3, 5, 7)]
for (i in seq_along(ll)) {
  cdat <- subset.data.frame(
    x = CFAdata,
    subset = CFAdata$cell.line == ll[i]
  )
  SF[[i]] <- analyze_survival(
    RD = cdat[, -1],
    name = ll[i],
    xtreat = c(0, 1, 2, 4, 6, 8)
  )
}
plot_sf(SF)
}
