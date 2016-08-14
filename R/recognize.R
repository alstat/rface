#' Recognize Image (Human Face)
#' @export
#' 
#' @description
#' Function for recognizing the image using the model trained from the data. 
#' 
#' @param x string input; image file input to be recognize.
#' @param y model supervised on learning from the training dataset.
#' @param rule string input; stopping rule for choosing number of principal components.
#'        Options are: \code{'simple f-share'} for simple fair-share; \code{'broken stick'}; and,
#'        \code{'rel-broken stick'} for relative broken stick stopping rule.
#' @param display displays the input image, and the corresponding output image --
#'        as recognized by the model.
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
#' 
#' # Take the average of the faces
#' img_mean <- aveFace(imgData, display = FALSE)
#' 
#' # Show the average of the faces
#' showFace(img_mean)
#' 
#' # Train the algorithm for the images
#' model <- learn(imgData)
#' 
#' # Show the eigen faces
#' showFace(model)
#' 
#' # Input an image and recognize it
#' recognize("~/Downloads/jaffe_testing/KA.AN1.39.tiff", model, display = TRUE, rule = "simple f-share")
recognize <- function(x, y, rule = "simple f-share", display = TRUE) {
  if (class(y) != 'learn') stop ("y is of class 'learn'.")
  if (class(x) != 'character') stop ("x should be string.")
  
  # Read the input image
  in_img <- readImage(as.character(x))
  ydat <- y[[2L]] # Extract the input data of all images
  
  # Conditions for the dimensions of the image
  if (length(dim(in_img)) == 3L) {
    if (length(ydat[[2L]]) == length(dim(in_img))) {
      if (dim(in_img)[1L] != ydat[[2L]][1L] ||
          dim(in_img)[2L] != ydat[[2L]][2L] ||
          dim(in_img)[3L] != ydat[[2L]][3L]) {
        stop("The dimensions of x and y are not compatible. x and y must have the same dimensions.")
      } 
    }
  } else if (length(dim(in_img)) == 2L) {
    if (dim(in_img)[1L] != ydat[[2L]][1L] ||
        dim(in_img)[2L] != ydat[[2L]][2L]) {
      stop("The dimensions of x and y are not compatible. x and y must have the same dimensions.")
    }
  }
  
  # Extract the column pixel values of the input image
  if (length(dim(in_img)) == 3L) {
    in_img1 <- melt(t(in_img[,, 1L]))[-c(1L, 2L)] 
  } else if (length(dim(in_img)) == 2L) {
    in_img1 <- melt(t(in_img))[-c(1L, 2L)]
  }
  
  # Generate the image using the first k images
  imgH <- face_mu <- y[[3L]]; pc <- y[[1L]]
  
  # Project the input to the eigenspace
  if (is.null(rule)) {
    in_img2 <- t(pc$rotation) %*% as.matrix(in_img1 - face_mu)
    err <- t(pc$x) - matrix(rep(in_img2, 2), (pc$x %>% dim)[1], (pc$x %>% dim)[1])
  } else if (!is.null(rule)) {
    # Extract the maximum number of PCs for the image
    if (rule == "rel-broken stick") {
      k <- max(rbrStick(pc$sdev ^ 2L)[["Use PC(s):"]]) 
    } else if (rule == "simple f-share") {
      k <- max(which((pc$sdev ^ 2L) > (sum(pc$sdev ^ 2L)) / length(pc$sdev)))
    } else if (rule == "broken stick") {
      k <- max(brStick(pc$sdev ^ 2L)[["Use PC(s):"]])
    }
    in_img2 <- t(pc$rotation[, 1:k]) %*% as.matrix(in_img1 - face_mu)
    err <- t(pc$x[, 1:k]) - matrix(rep(in_img2, (t(pc$x[, 1:k]) %>% dim)[2]), (t(pc$x[, 1:k]) %>% dim)[1], (t(pc$x[, 1:k]) %>% dim)[2])
  }
  
  # Get the norm of the error
  out <- getNorm(err)
  
  min_err <- which(out == min(out))
  img_mat <- array(0L, c(dim(in_img)[1L:2L], 2L))
  img_mat[,,] <- c(matrix(in_img1[,1L], ncol = dim(in_img)[2L], byrow = TRUE),
                   matrix(ydat[[1L]][, min_err], ncol = dim(in_img)[2L], byrow = TRUE))
  
  if (display == TRUE) {
    display(img_mat[,,1L:2L], all = T, method = "r", title = c("Input", "Recognized as"))
  } 
  
  out <- list("Average Face" = face_mu[,1L], "Image Dimension" = dim(in_img), "Image" = img_mat[,,1L:2L], "Stopping Rule" = rule, "Max PCs" = k)
  class(out) <- "recognize"
  return(out)
}