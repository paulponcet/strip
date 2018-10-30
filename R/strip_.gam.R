
#' @export
#' @rdname strip
#' 
strip_.gam <-
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
    op$residuals <- NULL
    op$fitted.values <- NULL
    op$family <- NULL
    op$linear.predictors <- NULL
    op$weights <- NULL
    op$prior.weights <- NULL
    op$y <- NULL
    op$hat <- NULL
    op$formula <- NULL
    op$model <- NULL
    op$pred.formula <- NULL
    op$offset <- NULL
    attr(op$terms,".Environment") <- NULL
    attr(op$pterms,".Environment") <- NULL
    
  } else {
    op <- list(call = ca)
  }
  
  if ("print" %in% keep) {
    warning("'print' case not implemented yet for strip.gam")
    oq <- list(call = ca)
    #TODO
    #oq <- list(call = ca, 
    #           n = object$n, 
    #           enp = object$enp, 
    #           pars = list(family = object$pars$family), 
    #           s = object$s)
    
  } else {
    oq <- list(call = ca)
  } 
  
  object <- rlist::list.merge(op, oq)
  class(object) <- cl
  return(object)
}
