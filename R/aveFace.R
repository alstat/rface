#' Average Face of Training Data Set
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
#' 
#' # Import all images in the directory "data/jaffe/"
#' imgData <- importImages("~/Downloads/jaffe_training/", display = FALSE)
#' 
#' # Take the average of the faces
#' img_mean <- aveFace(imgData, display = FALSE)
#' showFace(img_mean)
aveFace <- function (x, display = TRUE) {
  if (class(x) == "recognize") {
    imgDim <- x[[3L]]
    img_mat <- matrix(x[[2L]], ncol = imgDim[2L], byrow = TRUE)
  } else if (class(x) == "images") {
    imgDim <- x[[2L]]; x <- x[[1L]]
    face_mu <- as.matrix(rowMeans(x))
    img_mat <- matrix(face_mu, ncol = imgDim[2L], byrow = TRUE)
  }
  if (display == TRUE) {
    display(img_mat, method = "r") 
  }
  
  return(list("Image" = img_mat, "mu_vec" = face_mu))
}