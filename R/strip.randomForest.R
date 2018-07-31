
#' @author 
#' The method for \code{randomForest} objects is adapted 
#' from \href{http://stats.stackexchange.com/a/171096/55854}{ReKa's answer} 
#' on StackExchange. 
#' 
#' @export
#' @rdname strip
#' 
strip.randomForest <-
function(object,
         keep, 
         ...)
{
  
  keep <- match.arg(tolower(keep), 
                    c("everything", "predict", "print"), 
                    several.ok = TRUE)
  cl <- class(object)
  ca <- object$call
  
  if ("everything" %in% keep) {
    return(object)
  }
  
  if ("predict" %in% keep) {
    op <- object
    op$finalModel$predicted <- NULL
    op$finalModel$oob.times <- NULL
    op$finalModel$y <- NULL
    op$finalModel$votes <- NULL
    op$control$indexOut <- NULL
    op$control$index <- NULL
    op$trainingData <- NULL
    attr(op$terms,".Environment") <- NULL
    attr(op$formula,".Environment") <- NULL
    
  } else {
    op <- list(call = ca)
  }
  
  if ("print" %in% keep) { 
    t <- object$type
    oq <- list(call = ca, 
               type = t, 
               ntree = object$ntree, 
               mtry = object$mtry, 
               coefficients = object$coefficients, 
               confusion = object$confusion, 
               err.rate = object$err.rate, 
               mse = object$mse, 
               rsq = object$rsq, 
               test = list(err.rate = object$test$err.rate, 
                           confusion = object$test$confusion, 
                           mse = object$test$mse, 
                           rsq = object$test$rsq))

  } else {
    oq <- list(call = ca)
  }
  
  object <- rlist::list.merge(op, oq)
  class(object) <- cl
  return(object)
}
