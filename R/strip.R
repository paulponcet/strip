#' @title 
#' Lighten R model outputs
#'
#' @description 
#' The \code{strip} function deletes components of R model outputs that are 
#' useless for specific purposes, 
#' such as \code{predict}[ing], \code{print}[ing], \code{summary}[izing], etc.
#' 
#' The idea is to prevent the size of the model output to grow 
#' with the size of the training dataset. 
#' This is useful if one has to save the output for later use 
#' while limiting its size on disk. 
#'
#' The birth of this package originates with Nina Zumel's post 
#' \href{http://www.win-vector.com/blog/2014/05/trimming-the-fat-from-glm-models-in-r/}{`Trimming the Fat from glm() Models in R'} 
#' on Win-Vector Blog. 
#'
#' @details 
#' If \code{keep="predict"}, components inside the list \code{object} are kept 
#' if they are needed by the \code{predict} method, otherwise they are set to \code{NULL}. 
#' If \code{keep=c("predict", "print")}, components are kept as soon as 
#' they are needed by one of the 
#' \code{predict} or \code{print} methods. 
#' If \code{keep="everything"}, \code{object} is returned with no modifications. 
#'
#' Currently the models supported are limited to the following list: 
#' 
#' \itemize{
#'  \item \code{lm} and \code{glm}, the linear and generalized linear regression function from package \pkg{stat}; 
#'  \item \code{loess}, the local polynomial regression function from package \pkg{stat};
#'  \item \code{randomForest}, from package \pkg{randomForest}. 
#' }
#' 
#' There is also a \code{strip} function for 'train' objects built with the \pkg{caret} package. 
#' 
#' Further developments of the package should include additional models, 
#' and should enable additional \code{keep} values 
#' (e.g. \code{keep="summary"}, \code{keep="anova"}, etc.)
#' 
#' @param object
#' result of an R model, see 'Details'. 
#' 
#' @param keep
#' character. A vector of values among \code{"everything"}, 
#' \code{"predict"}, \code{"print"}, and \code{"summary"}. 
#' Except for \code{strip.lm}, currently only the values 
#' \code{"everything"}, \code{"predict"}, and \code{"print"},  
#' are implemented. 
#' 
#' @param ...
#' Additional arguments to be passed to other methods. 
#' 
#' @param use_trim
#' boolean. For the \code{strip.train} method, if \code{use_trim=TRUE} 
#' and if \code{keep="predict"}, then 
#' the function applied is (if it exists) the \code{trim} function 
#' embedded as \code{object$modelInfo$trim}.  
#' 
#' @return A list of the same class as \code{object} is returned. 
#' 
#' @importFrom rlist list.merge
#' @export
#' 
#' @seealso See \href{http://www.win-vector.com/blog/2014/05/trimming-the-fat-from-glm-models-in-r/}{Nina Zumel's post} 
#' on Win-Vector Blog for further insight, examples, and motivations; 
#' \href{http://stats.stackexchange.com/a/171096/55854}{ReKa's answer} on StackExchange for reducing the size of a 
#' \code{randomForest} object; \href{https://github.com/topepo/caret/issues/90}{this discussion} for limiting 
#' the `footprint' of regression and classification objects within the \pkg{caret} package. 
#' 
#' @examples
#' data("mtcars")
#' set.seed(110)
#' i = sample(2, nrow(mtcars), replace = TRUE, prob=c(0.8, 0.2))
#' r1 = lm(mpg ~ ., data = mtcars[i==1,])
#' r2 = strip(r1, keep = "predict")
#' 
#' # Estimate the objects' size as the size of their serialization
#' length(serialize(r1, NULL))
#' length(serialize(r2, NULL))
#' 
#' # Check that predictions are the same
#' p1 = predict(r1, newdata = mtcars[i==2,])
#' p2 = predict(r2, newdata = mtcars[i==2,])
#' identical(p1, p2) # TRUE
#' 
strip <-
function(object,
         keep, 
         ...)
{
  strip_(object, keep, ...)
}


#' @export
#' @rdname strip
#' 
strip_ <- 
function(object, 
         keep, 
         ...)
{
  UseMethod("strip_")
}
