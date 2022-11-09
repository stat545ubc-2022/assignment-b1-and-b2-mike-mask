test_that("standardize_and_model_test_1", {
  expect_type(standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$gdpPercap),
            "summary.lm") #tests that the output of our function is a "summary.lm"; tests that what is on the left equals what is on the right
})

test_that("standardize_and_model_test_2", {
  expect_error(standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$country), "Easy there, your predictor is not numeric, it's a factor") #tests that when predictor is a factor the function reports an informative error message telling the user that the predictor is not numeric but is a factor
})

test_that("standardize_and_model_test_3", {
  a <- (gapminder$lifeExp - mean(gapminder$lifeExp))/sd(gapminder$lifeExp) #standardizes lifeExp by hand
  b <- (gapminder$gdpPercap - mean(gapminder$gdpPercap))/sd(gapminder$gdpPercap) #standardizes gdpPercap by hand
  expect_equal(standardize_and_model(criterion = gapminder$lifeExp, predictor = gapminder$gdpPercap),
               summary(lm(a ~ b))) #tests that our function output (left) is equal to the output of standardizing and modelling the variables by hand (right)
})
