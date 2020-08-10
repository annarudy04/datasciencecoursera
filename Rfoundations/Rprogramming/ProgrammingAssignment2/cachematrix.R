## The following functions can be used in combination to solve for 
## the inverse of matrix, cache the inverse, and obtain the cached inverse
## when its needed rather than recalculating. 

## Sets and getsattributes for a matrix, including its value and 
## cached inverse.
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinv <- function(solve) inv <<- solve
  getinv <- function() inv
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}

## Gets the cached inverse of a matrix from makeCacheMatrix
## if availabe, otherwise solves for the inverse and caches it
## via the makeCacheMatrix$setinv() function for future use.  
cacheSolve <- function(x, ...) {
  inv <- x$getinv()
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setinv(inv)
  inv
}a
