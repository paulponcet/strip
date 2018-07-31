
#' @export strip.default
#' @rdname strip
#' 
strip.default <-
function(object,
         keep, 
         ...)
{
  warning("no method found for 'strip', the full 'object' is returned")
  object
}
