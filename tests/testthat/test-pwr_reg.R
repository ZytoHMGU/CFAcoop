test_that("reject wrong input format", {
  expect_equal(object = pwr_reg(x = list("vector",4)), expected = NULL)
})

test_that("empty vector", {
  expect_equal(pwr_reg(x = c()),c())
})

test_that("scale...", {
  #S <- 10^seq(1,4,1/3)
  #C <- 1 * S^1.2 * rnorm(n = length(S),mean = 1,sd = 0.1)
  #D1 <- data.frame("S" = S,"C" = C)
  #D2 <- data.frame("S" = exp(2)*S,"C" = exp(2)*C)
  #expect_equal(pwr_reg(x = D1),pwr_reg(x = D2))
})
