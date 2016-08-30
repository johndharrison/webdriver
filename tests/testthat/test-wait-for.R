
context("waiting for a condition")

server <- start_web_server("web")
on.exit(stop_web_server(server), add = TRUE)

phantom <- start_phantomjs()
on.exit(stop_phantomjs(phantom), add = TRUE)

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
})