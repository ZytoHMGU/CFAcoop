test_that("input format", {
  S <- 10^seq(1,4,0.25)
  a <- 0.4
  b <- 1.1
  D <- data.frame("S" = rep(S,each = 3),
                  "C" = a * rep(S,each = 3)^b * rnorm(length(S)*3,1,0.05))
  expect_error(analyse_survival())
  expect_error(analyse_survival(RD = c()))
  expect_error(analyse_survival(RD = D,xtreat = 1:5))
  expect_is(analyse_survival(RD = D,xtreat = 0),"list")
})

test_that("output format", {
  S <- 10^seq(1,4,0.25)
  a <- 0.4
  b <- 1.1
  D <- data.frame("S" = rep(S,each = 3),
                  "C" = a * rep(S,each = 3)^b * rnorm(length(S)*3,1,0.05))
  D$C2 <- (a * 0.8) * rep(S,each = 3)^(b * 1.1) * rnorm(length(S)*3,1,0.05)
  expect_type(analyse_survival(RD = D),"list")
  expect_length(analyse_survival(RD = D),6)

  expect_equal(class(analyse_survival(RD = D)$name),"character")
  expect_true(is.numeric(analyse_survival(RD = D)$xtreat))
  expect_equal(class(analyse_survival(RD = D)$raw),"data.frame")
  expect_equal(class(analyse_survival(RD = D)$mean),"data.frame")
  expect_equal(analyse_survival(RD = D),analyse_survival(RD = as.matrix(D)))
  expect_equal(class(analyse_survival(RD = D)$fit),"list")
  expect_equal(class(analyse_survival(RD = D)$fit[[1]]),"summary.lm")
  expect_equal(class(analyse_survival(RD = D)$SF),"list")
  expect_equal(class(analyse_survival(RD = D)$SF[[1]]),"numeric")
})

test_that("find c_range", {
  S <- 10^seq(2,4,0.25)
  a <- 0.8
  b <- 1.1
  D <- data.frame("S" = rep(S,each = 3),
                  "C" = a * rep(S,each = 3)^b * rnorm(length(S)*3,1,0.05))
  D$C2 <- (a * 0.001) * rep(S,each = 3)^(b * 1.1) * rnorm(length(S)*3,1,0.05)
  expect_warning(analyse_survival(RD = D))
})
