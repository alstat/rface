#' Displays Image
#' @export
#' 
#' @description
#' This function uses PCA to compute the eigenfaces and recognizes the data.
#' 
#' @param x a data frame consisting the suitability scores of a given characteristics
#'          (terrain, soil, water and temperature) for a 
#'          given crop (e.g. coconut, cassava, etc.);
#' @param method the method for computing the overall suitability, which includes the
#'        \code{"minimum"}, \code{"maximum"}, \code{"sum"}, \code{"product"},
#'        \code{"average"}, \code{"exponential"} and \code{"gamma"}. If \code{NULL},
#'        \code{"minimum"} is used.
#' @param interval if \code{NULL}, the interval used are the following: 0-25% (Not
#'        suitable, N), 25%-50% (Marginally Suitable, S3), 50%-75% (Moderately Suitable, S2), and
#'        75%-100% (Highly Suitable, S1). But users can assign a custom intervals by specificying
#'        the values of the end points of the intervals.
#' @param output the output to be returned, either the scores or class. If \code{NULL},
#'        both are returned.
#' 
#' @examples
#' To reproduce this example, please refer to \code{https://github.com/alstat/rface}
#' 
#' # Call the Face Recognition package
#' library(rface)
#' # Import all images in the directory "data/jaffe/"
#' imgData <- importImages("~/Downloads/jaffe_training/", display = FALSE)
#' 
#' # Show imported images
#' showFace(imgData)
showFace <- function(x, all = TRUE, method = "raster", ...) {
  if (class(x) == "images") {
    img <- x[[1]]; d <- x[[2]]; a <- dim(x[[1]])[2]
    rawImges <- mat_to_image(img, d)
    display(rawImges, all = all, method = method, ...)
  } else if (class(x) == "learn") {
    y <- x[[2L]][[1L]]
    pc <- princomp(y)
    scores <- pc$scores
    imgDim <- x[[2L]][[2L]]
    
    cont <- function(x) {
      out <- (x - min(x) + 1) / (max(x) - min(x) + 1)
      out
    }
    
    imges <- mat_to_image(scores, imgDim)
    imgesAdj <- array(0, c(imgDim[1:2], ncol(scores)))
    
    for (i in 1:ncol(scores)) imgesAdj[,, i] <- cont(imges[,, i])
    display(imgesAdj, all = TRUE, method = method, ...)
  } else {
    x <- x$"Image"
    display(x, all = all, method = method, ...)
  }
}