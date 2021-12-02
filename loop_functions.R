# Loop functions

'
lapply: Loop over a list and evaluate a function on each element 
sapply: Same as lapply but try to simplify the result 
apply: Apply a function over the margins of an array 
tapply: Apply a function over subsets of a vector 
mapply: Multivariate version of lapply
split: Divide the data in the vector x into the groups defined by f.
sapply: Wrapper of lapply by default returning a vector, matrix
'

# lapply
x<- list(a=1:4, b=rnorm(10), c=rnorm(20,1), d=dnorm(100,5))
lapply(x, mean) #return 4 results respectively
# sapply
sapply(x, mean) #return 4 results in a matrix (for simplicity)

#We can also apply anonymous function (user-defined)
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(col) col[ ,1]) #define the function directly

# apply
#This can be realized by for loop, but it is more convenient than for loop because of one-line code.
#return a vector
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean) #keep the second dimension (take mean of the rows)
apply(x, 1, mean)
apply(x, 1, quantile, probs=c(0.25, 0.75))

rowSums = apply(x, 1, sum) #useful in large matrices
rowMeans = apply(x, 1, mean)
colSums = apply(x, 2, sum)
colMeans = apply(x, 2, mean)

# mapply
#apply functions to lists one by one (corresponding variables with the target function)
mapply(rep, 1:4, 4:1)

# tapply
x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3, 10) #define the groups
tapply(x, f, mean)

# split
#split the objects into groups
x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3, 10)
split(x, f)
#can split a data frame
library(datasets)
head(airquality)
split(airquality, airquality$Month)

# Example
#How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?
library(datasets)
data(mtcars)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
with(mtcars, tapply(mpg, cyl, mean))
tapply(mtcars$mpg, mtcars$cyl, mean)

