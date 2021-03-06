
context("waiting for a condition")

test_that("waiting for a condition", {

  s <- session$new(port = phantom$port)
  on.exit(s$delete(), add = TRUE)

  ## This will add class 'red' to '#me', but only after 500ms
  s$go(server$url("/wait-for-1.html"))

  ## It is not there yet
  expect_false(s$execute_script("return $('#me').hasClass('red')"))

  ## Wait until it is there
  expect_true(s$wait_for("$('#me').hasClass('red')"))

  ## It is there now
  expect_true(s$execute_script("return $('#me').hasClass('red')"))

  ## We wait for a 'blue' class, but that does not happen
  expect_false(s$wait_for("$('#me').hasClass('blue')", timeout = 1000))

  ## Syntax error in the wait expression returns NA
  expect_identical(
    s$wait_for("syntax error"),
    NA
  )

  ## Quotes in the expression
  expect_true(
    s$wait_for('"foo" == "foo"')
  )
})
