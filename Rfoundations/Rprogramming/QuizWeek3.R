library(datasets)
data(iris)
data(mtcars)

q1 <- function(){
  print("Average Sepal Length by Species using tapply():")
  tapply_ans <- tapply(iris$Sepal.Length, iris$Species, mean)
  print(tapply_ans)
  print("Average Sepal Length of Virginica using subset():")
  virginica <- subset(iris, iris["Species"] == 'virginica')
  subset_ans <- mean(virginica$Sepal.Length)
  print(subset_ans)
}

q2 <- function(){
  print("Mean Iris Metrics using apply()")
  apply(iris[, 1:4], 2, mean)
}

q3 <- function(){
  print("Goal: Get average mpg grouped by number of cylinders")
  print("Using sapply():")
  print(sapply(split(mtcars$mpg, mtcars$cyl), mean))
  print("Using with():" )
  print(with(mtcars, tapply(mpg, cyl, mean)))
  print("Using tapply()")
  print(tapply(mtcars$mpg, mtcars$cyl, mean))
}
use_tapply <- function(){
  hp_by_cyl <- tapply(mtcars$hp, mtcars$cyl, mean)
  print(hp_by_cyl)
  print("Using tapply():")
  diff1 <- hp_by_cyl['8'] - hp_by_cyl['4']
  names(diff1) <- c("abs_diff")
  print(diff1)
}
use_subset <- function(){
  print("Using subset():")
  cyl4hp <- mean(subset(mtcars, cyl==4)$hp)
  cyl8hp <- mean(subset(mtcars, cyl==8)$hp)
  diff2 <- cyl8hp - cyl4hp
  print(diff2)
}
q4 <- function(){
  print("Goal: Absoluted difference between 4-cylinder and 8-cyclindar cars' avg horsepower")
  use_subset()
  use_tapply()
  
}
