pkgname <- "CFAcoop"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "CFAcoop-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('CFAcoop')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("CFAdata")
### * CFAdata

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: CFAdata
### Title: Colony Formation Assay data on cellular cooperation
### Aliases: CFAdata
### Keywords: dataset

### ** Examples

data(CFAdata)
head(CFAdata)
cll <- levels(CFAdata$cell.line)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("CFAdata", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("analyze_survival")
### * analyze_survival

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: analyze_survival
### Title: analyze_survival
### Aliases: analyze_survival

### ** Examples

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
                            c_range = c(5,20,100))
SF[[2]] <- analyze_survival(RD = df.2,
                            name = "cell line b",
                            xtreat = c(0,1,4))



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("analyze_survival", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("calculate_sf")
### * calculate_sf

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: calculate_sf
### Title: calculate_sf
### Aliases: calculate_sf

### ** Examples

seeded <- 10^(seq(1, 5, 0.5))
counted.ref <- 0.4 * 10^(seq(1, 5, 0.5) + rnorm(n = 9, 0, 0.1))^1.1
counted.treat <- 0.01 * 10^(seq(1, 5, 0.5) + rnorm(n = 9, 0, 0.1))^1.2
fit_ref <- pwr_reg(seeded = seeded, counted = counted.ref)
fit_treat <- pwr_reg(seeded = seeded, counted = counted.treat)
calculate_sf(par_ref = fit_ref, par_treat = fit_treat)
data("CFAdata")
D <- subset.data.frame(
  x = CFAdata,
  subset = cell.line == levels(CFAdata$cell.line)[1]
)
fit_ref <- pwr_reg(seeded = D$`Cells seeded`, counted = D$`0 Gy`)
fit_treat <- pwr_reg(seeded = D$`Cells seeded`, counted = D$`4 Gy`)
calculate_sf(par_ref = fit_ref, par_treat = fit_treat)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("calculate_sf", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("export_sf")
### * export_sf

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: export_sf
### Title: export_sf
### Aliases: export_sf

### ** Examples

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
export_sf(SF)

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
export_sf(SF)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("export_sf", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("plot_sf")
### * plot_sf

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: plot_sf
### Title: plot_sf
### Aliases: plot_sf

### ** Examples

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



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("plot_sf", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("pwr_reg")
### * pwr_reg

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: pwr_reg
### Title: pwr_reg
### Aliases: pwr_reg

### ** Examples

pwr_reg(
  seeded = 10^(seq(1, 5, 0.5)),
  counted = 0.4 * (10^seq(1, 5, 0.5))^1.25 * rnorm(n = 9, 1, 0.05)
)
data(CFAdata)
D <- subset.data.frame(
  x = CFAdata,
  subset = cell.line == levels(CFAdata$cell.line)[1]
)
pwr_reg(seeded = D$`Cells seeded`, counted = D$`0 Gy`)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("pwr_reg", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
