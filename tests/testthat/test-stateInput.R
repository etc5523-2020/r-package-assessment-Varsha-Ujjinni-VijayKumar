library(testthat)

test_that("stateselect()", {
  expect_equal(
    stateInput("state", usa$state_name),
    (shiny::selectInput("state", label = "Choose a state name:",
                        choices = usa$state_name,
                        selected = ""))
  )
})
