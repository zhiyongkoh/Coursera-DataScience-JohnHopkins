#List containing se, get, setinv and getinv will be created
#With usage of "<<-" operator, it protects the variables from access from outside the environment

makeCacheMatrix <- function(x = matrix()) {
  #inversed result is stored in inv
  inv <- NULL
  #Function to set matrix to object created
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  #return input to matrix
  get <- function() x
  
  #set the inversed matrix
  setinv <- function(inverse) inv <<- inverse
  
  #return the inversed matrix
  getinv <- function() inv
  
  #return list containing the functions which are set
  list(set=set, get=get, setinv=setinv, getinv=getinv)

}



cacheSolve <- function(x, ...) {
  #get inversed obhect matrix from obj x
  inv <- x$getinv()
  
  #Set to null if not calculated
  if(!is.null(inv)) {
    message("getting cached data.")
    return(inv)
  }
  
  #get matrix obj
  data <- x$get()
  
  #solve the data into inv
  inv <- solve(data)
  
  #set it to the obj
  x$setinv(inv)
  
  #return results
  inv
  
}

