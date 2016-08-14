**rface**
=====
An R package for face recognition using Principal Component Analysis.
This package serves as a basic tool for the exploration of pattern recognition using face vectors as observations. The current statistical tool for doing inferrence is the Principal Componen Analysis and is applied to datasets such as [The Japanese Female Facial Expression (JAFFE) Database][1] and the face database from the [Computer Vision Science Research Projects by Dr Libor Spacek][2]. The package also includes other function that is meant to supplement the EBImage package, one of the function is the `impotImages` which tries to import all the image files in the folder, this function is a wrapper to the `readImage` function.

## Requirements
The **rface** depends on [**EBImage**][3] package of the [Bioconductor][4]. It also depends on the following R packages:

1. reshape2
3. Rcpp
4. RcppArmadillo
5. lattice

These packages are automatically installed during the installation. However, the **EBImage** package must be installed separately. And this can be done as follows:
```{r}
source("http://bioconductor.org/biocLite.R")
biocLite()
biocLite("EBImage")
```

## Installation
The **rface** package is not yet on [CRAN][5] and is currently hosted in [github][6]. Hence to install this, we will need the **devtools** R package. To do so, run the following
```{r}
install.packages("devtools")
```
Once everything is in place, run the following code
```{r}
library(devtools)
install_github("alstat/rface")
```
## Illustration 1 (JAFFE Database)
As an example, consider the JAFFE database. To reproduce the results in this section we recommend to download the JAFFE data set [here][7]. The link contains zip files both for the training and testing data set.

### Data Description
The database contains 213 images of 7 facial expressions (6 basic facial expressions + 1 neutral) posed by 10 Japanese female models. Each image has been rated on 6 emotion adjectives by 60 Japanese subjects. The database was planned and assembled by Michael Lyons, Miyuki Kamachi, and Jiro Gyoba. We thank Reiko Kubota for her help as a research assistant. The photos were taken at the Psychology Department in Kyushu University.
The six facial expressions captured per subject are the following:

* Angry
* Disagree
* Fear
* Happy
* Sad
* Surprise

### Data Partitioning (Training and Testing)
The original data from JAFFE website contains a list of facial images in one folder. For this illustration, we grouped the data into training and testing. In particular, each facial expressions of the subject mentioned above consists of at least two facial images. And to test the performance of the PCA, we extracted one facial image for each expression per subject and put it into a testing data set. Thus the remaining part of the data will serve as the training data set.

### Import the Data
After downloading the data, we can now import it to the workspace. And this is done as follows:

```{r}
# Call the Face Recognition package
library(rface)

# Import all images in the directory "data/jaffe/"
imgData <- importImages("~/Downloads/jaffe_training/", display = FALSE)
```
**Note:** When specifying the location of the directory make sure to put forward slash at the end. For example, the correct set up is: `"~/Downloads/jaffe_training/"`; but this one: `"~/Downloads/jaffe_training"` returns an error.

To display the imported images run the following codes:
```{r}
showFace(imgData)
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/Rplot.png)]("JAFFE Database")

### Mean Face
Now in order for PCA to learn, we remove the "common face" or the average of all input face vectors. This computation is automatically done in the `learn` function. But for us to see how this average face looks like see the following code:
```{r}
# Take the average of the faces
img_mean <- aveFace(imgData, display = FALSE)

# Show the average of the faces
showFace(img_mean)
```
[![alt text](https://github.com/alstat/SampleImages/blob/master/figure/Rplot1.png)]("Average Faces")
### PCA Training
Next is to train the PCA learn the data, and is done using the following codes:
```{r}
# Train the algorithm for the images
model <- learn(imgData)
```
### EigenFaces
After training, we now plot the eigenfaces or the principal component scores obtained by rotating the face vectors. The PC1 explains most of the variance of the model.
```{r}
# Show the eigen faces
showFace(model)
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/Rplot01.png)]("Eigenfaces")
### Face Recognition
And finally, to do face recognition we use the testing data set. This is done using the `recognize` function as shown below:
#### Input Subject: KA | Input Expression: Angry
```{r}
recognize("~/Downloads/jaffe_testing/KA.AN1.39.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/kaan1.png)]("Eigenfaces")
#### Input Subject: KA | Input Expression: Disagree
```{r}
recognize("~/Downloads/jaffe_testing/KA.DI1.42.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/kadi.png)]("Eigenfaces")
#### Input Subject: KA | Input Expression: Fear
```{r}
recognize("~/Downloads/jaffe_testing/KA.FE1.45.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/kafe.png)]("Eigenfaces")
#### Input Subject: KA | Input Expression: Happy
```{r}
recognize("~/Downloads/jaffe_testing/KA.HA1.29.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/kaha.png)]("Eigenfaces")
#### Input Subject: KA | Input Expression: Neutral
```{r}
recognize("~/Downloads/jaffe_testing/KA.NE1.26.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/kane.png)]("Eigenfaces")
#### Input Subject: KA | Input Expression: Sad
```{r}
recognize("~/Downloads/jaffe_testing/KA.SA1.33.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/kasa.png)]("Eigenfaces")
#### Input Subject: KA | Input Expression: Surprise
```{r}
recognize("~/Downloads/jaffe_testing/KA.SU1.36.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/kasu.png)]("Eigenfaces")

#### Input Subject: KL | Input Expression: Angry
```{r}
recognize("~/Downloads/jaffe_testing/KL.AN1.167.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/klan.png)]("Eigenfaces")
#### Input Subject: KL | Input Expression: Disagree
```{r}
recognize("~/Downloads/jaffe_testing/KL.DI1.170.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/kldi.png)]("Eigenfaces")
#### Input Subject: KL | Input Expression: Fear
```{r}
recognize("~/Downloads/jaffe_testing/KL.FE1.174.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/klfe.png)]("Eigenfaces")
#### Input Subject: KL | Input Expression: Happy
```{r}
recognize("~/Downloads/jaffe_testing/KL.HA1.158.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/klha.png)]("Eigenfaces")
#### Input Subject: KL | Input Expression: Neutral
```{r}
recognize("~/Downloads/jaffe_testing/KL.NE1.155.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/klne.png)]("Eigenfaces")
#### Input Subject: KL | Input Expression: Sad
```{r}
recognize("~/Downloads/jaffe_testing/KL.SA1.161.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/klsa.png)]("Eigenfaces")
#### Input Subject: KL | Input Expression: Surprise
```{r}
recognize("~/Downloads/jaffe_testing/KL.SU1.164.tiff", model, display = TRUE, rule = "simple f-share")
```
[![alt text](https://raw.githubusercontent.com/alstat/SampleImages/master/figure/klsu.png)]("Eigenfaces")

```{r}
```


## Author
* [Al-Ahmadgaid B. Asaad](https://github.com/alstat) (Maintainer)
 * email: alstated@gmail.com
 * blog: http://alstatr.blogspot.com/
 
[1]: http://www.kasrl.org/jaffe.html
[2]: http://cswww.essex.ac.uk/mv/allfaces/
[3]: http://bioconductor.org/packages/release/bioc/html/EBImage.html
[4]: http://bioconductor.org
[5]: https://cran.r-project.org
[6]: https://github.com
[7]: https://github.com/alstat/SampleImages/tree/master/imagedata