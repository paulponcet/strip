
#' @export
#' @rdname strip
#' 
strip.train <-
function(object,
         keep, 
         use_trim = FALSE, 
         ...)
{

  keep <- match.arg(tolower(keep), c("everything", "predict", "print"), several.ok = TRUE)
  cl <- class(object)
  ca <- object$call
  
  if ("everything" %in% keep) {
    return(object)
  }

  if ("predict" %in% keep) {
    if (use_trim) {
      trim <- object$modelInfo$trim
    } else {
      trim <- NULL
    }
    if (!is.null(trim)) {
      op <- trim(object)
    } else {
      op <- object
      p <- op$control$predictionBounds
      op$results <- NULL
      op$pred <- NULL
      op$bestTune <- NULL
      op$dots <- NULL
      op$metric <- NULL
      op$control <- NULL
      op$trainingData <- NULL
      op$resample <- NULL
      op$resampledCM <- NULL
      op$perfNames <- NULL
      op$maximize <- NULL
      op$times <- NULL
      op$coefnames <- NULL
      op$control$predictionBounds <- p
      attr(op$terms, ".Environment") <- NULL
    }
    
  } else {
    op <- list(call = ca)
  }
  
  if ("print" %in% keep) {
    levels <- levels(object)
    oq <- list(call = ca, 
               modelInfo = list(label = object$modelInfo$label), 
               modelType = object$modelType, 
               trainingData = object$trainingData, 
               metric = object$metric, 
               preProc = object$preProc, 
               results = object$results, 
               bestTune = object$bestTune, 
               update = object$update, 
               maximize = object$maximize, 
               method = object$method, 
               finalModel = object$finalModel, 
               control = list(index = object$control$index, 
                              method = object$control$method, 
                              sampling = object$control$sampling, 
                              selectionFunction = object$control$selectionFunction, 
                              horizon = object$control$horizon, 
                              fixedWindow = object$control$fixedWindow, 
                              fixedWindow = object$control$number, 
                              repeats = object$control$repeats, 
                              p = object$control$p))
    attr(oq, "levels") <- levels
    
  } else {
    oq <- list(call = ca)
  }
  
  object <- rlist::list.merge(op, oq)
  class(object) <- cl
  return(object)
}
