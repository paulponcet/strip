
#' @author 
#' The method for \code{glm} objects is adapted 
#' from \href{http://www.win-vector.com/blog/2014/05/trimming-the-fat-from-glm-models-in-r/}{Nina Zumel's post} 
#' on Win-Vector Blog. 
#' 
#' @export
#' @rdname strip
#' 
strip_.glm <- 
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
    op$y <- NULL
    op$model <- NULL
    op$residuals <- NULL
    op$fitted.values <- NULL
    op$effects <- NULL
    op$qr$qr <- NULL
    op$linear.predictors <- NULL
    op$weights <- NULL
    op$prior.weights <- NULL
    op$data <- NULL
    op$family$variance <- NULL
    op$family$dev.resids <- NULL
    op$family$aic <- NULL
    op$family$validmu <- NULL
    op$family$simulate <- NULL
    attr(op$terms,".Environment") <- NULL
    attr(op$formula,".Environment") <- NULL
    
  } else {
    op <- list(call = ca)
  }
  
  if ("print" %in% keep) {
    oq <- list(call = ca, 
               coefficients = object$coefficients, 
               contrasts = object$contrasts, 
               df.null = object$df.null, 
               df.residual = object$df.residual, 
               na.action = object$na.action, 
               null.deviance = object$null.deviance, 
               deviance = object$deviance, 
               aic = object$aic)
    
  } else {
    oq <- list(call = ca)
  }
  
  object <- rlist::list.merge(op, oq)
  class(object) <- cl
  object
}
