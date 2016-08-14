rface
=====
An R package for face recognition using Principal Component Analysis.
This package serves as a basic tool for the exploration of pattern recognition using face vectors as observations. The current statistical tool for doing inferrence is the Principal Componen Analysis and is applied to datasets such as [The Japanese Female Facial Expression (JAFFE) Database][1] and the face database from the [Computer Vision Science Research Projects by Dr Libor Spacek][2]

Currently, there is only one statistical tool only the Principal Component Analysis is available for inferring the input in R using techniques like PCA. The package also includes other function that is meant to supplement the EBImage package, one of the function is the `impotImages` which tries to import all the image files in the folder, this function is a wrapper to the `readImage` function.

## Requirements
The package requires the following packages for the **rface** to work:
1. EBImage
2. reshape2
3. lattice

The last two packages enumerated above will be automatically installed by R, however, the **EBImage** package must be installed separately. And this can be done as follows:
```{r}
source("http://bioconductor.org/biocLite.R")
biocLite()
biocLite("EBImage")
```

## Authors
* [Al-Ahmadgaid B. Asaad](https://github.com/alstat) (Maintainer)
  * email: alstated@gmail.com
  * blog: http://alstatr.blogspot.com/
## Contributors
* Joselito C. Magadia
  * email: j_magadia@yahoo.com
 
[1]: http://www.kasrl.org/jaffe.html
[2]: http://cswww.essex.ac.uk/mv/allfaces/