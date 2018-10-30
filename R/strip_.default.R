
#' @export
#' @rdname strip
#' 
strip_.default <-
function(object,
         keep, 
         ...)
{
  warning("no method found for 'strip', the full 'object' is returned")
  object
}
