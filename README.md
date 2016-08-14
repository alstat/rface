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
As an example, consider the JAFFE database. To reproduce the results in this section we recommend to download the JAFFE data set in the folder above.

### Data Description
The database contains 213 images of 7 facial expressions (6 basic facial expressions + 1 neutral) posed by 10 Japanese female models. Each image has been rated on 6 emotion adjectives by 60 Japanese subjects. The database was planned and assembled by Michael Lyons, Miyuki Kamachi, and Jiro Gyoba. We thank Reiko Kubota for her help as a research assistant. The photos were taken at the Psychology Department in Kyushu University.

### Data Partitioning (Training and Testing)


## Author
* [Al-Ahmadgaid B. Asaad](https://github.com/alstat) (Maintainer)
 * email: alstated@gmail.com
 * blog: http://alstatr.blogspot.com/
 
## Contributor
* Joselito C. Magadia, Ph.D.
 * email: j_magadia@yahoo.com
 
[1]: http://www.kasrl.org/jaffe.html
[2]: http://cswww.essex.ac.uk/mv/allfaces/
[3]: http://bioconductor.org/packages/release/bioc/html/EBImage.html
[4]: http://bioconductor.org
[5]: https://cran.r-project.org
[6]: https://github.com