
#' @export
#' @rdname strip
#' 
strip_.loess <-
function(object,
         keep, 
         ...)
{
  
  keep <- match.arg(tolower(keep), c("everything", "predict", "print"), several.ok = TRUE)
  cl <- class(object)
  ca <- object$call

  if ("everything" %in% keep) {
    return(object)
  }
  
  if ("predict" %in% keep) {
    op <- object
    op$y <- NULL
    op$model <- NULL
    op$fitted <- NULL
    op$residuals <- NULL
    op$weights <- NULL
    op$data <- NULL
    op$one.delta <- NULL
    op$two.delta <- NULL
    attr(op$terms,".Environment") <- NULL
    
  } else {
    op <- list(call = ca)
  }

  if ("print" %in% keep) {
    oq <- list(call = ca, 
               n = object$n, 
               enp = object$enp, 
               pars = list(family = object$pars$family), 
               s = object$s)

  } else {
    oq <- list(call = ca)
  } 
  
  object <- rlist::list.merge(op, oq)
  class(object) <- cl
  object
}
