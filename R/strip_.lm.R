
#' @export
#' @rdname strip
#' 
strip_.lm <-
function(object,
         keep, 
         ...)
{

  keep <- match.arg(tolower(keep), 
                    c("everything", "predict", "predictci", "print", "summary"), 
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
    op$weights <- NULL
    op$prior.weights <- NULL
    op$linear.predictors <- NULL
    
    attr(op$terms,".Environment") <- NULL
    attr(op$formula,".Environment") <- NULL
    
  } else if ("predictci" %in% keep) {
    op <- object
    op$y <- NULL
    op$model <- NULL
    #op$residuals <- NULL
    op$fitted.values <- NULL
    op$effects <- NULL
    op$weights <- NULL
    op$prior.weights <- NULL
    op$linear.predictors <- NULL
    
    attr(op$terms,".Environment") <- NULL
    attr(op$formula,".Environment") <- NULL
    
  } else {
    op <- list(call = ca)
  }
  
  if ("print" %in% keep) {
    oq <- list(call = ca,
               coefficients = object$coefficients)

  } else {
    oq <- list(call = ca)
  }
    
  if ("summary" %in% keep) {
    terms <- object$terms
    attr(terms,".Environment") <- NULL
    os <- list(call = ca, 
               rank = object$rank, 
               df.residual = object$df.residual, 
               residuals = object$residuals, 
               weights = object$weights, 
               terms = terms, 
               qr = object$qr, 
               fitted.values = object$fitted.values, 
               coefficients = object$coefficients, 
               na.action = object$na.action)
    
  } else {
    os <- list(call = ca)
  }
  
  object <- rlist::list.merge(op, oq, os)
  class(object) <- cl
  object
}
