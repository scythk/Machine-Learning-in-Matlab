# Dataset
Datasets used in the programs.
More datasets could be found at [Trevor Hastie' Website](http://web.stanford.edu/~hastie/ElemStatLearn/).

## Tr1, Tr2
These files consist of three columns of numbers separated by comma. The first two columns give the point coordinates in a 2-D space. The third column indicates the class label which here can either be +1, or -1.

## MPG_train, MPG_test
The dataset has 8 columns separated by commas. The first seven columns correspond to input attributes including:
1. cylinders:     multi-valued discrete
2. displacement:  continuous
3. horsepower:    continuous
4. weight:        continuous
5. acceleration:  continuous
6. model year:    multi-valued discrete
7. origin:        multi-valued discrete
The 8th column is the output variable stating the miles per gallon (MPG) of the vehicle.

## USPS_train, USPS_test
USPS handwritten digits: Each row of the training file contains 17 numbers. The first 16 correspond to features extracted from a digital image of a handwritten digit. The last column is the label which indicates what digit the first 16 numbers represent. There are 10 different classes.

## Hyper_train, Hyper_test
Hyperspectral pixels: Each row of the training file contains 37 numbers. The first 36  correspond to spectral responses across different spectral bands of  a pixel in a hyperspectral image. The last number represents the class where that pixel belongs to (classes here correspond to different materials that are despited by the pixels, e.g., soil, vegetation, water and so on).  There are 6 different classes.

## NLS_train
The training set consists of two columns separated by comma. The first column is the X training input data (182 total), and the second column is the output Y generated according to the model described at the beginning.

## EM_train, EM_test
The dataset consists of nine columns separated by space. The first 8 columns correspond to the input training features, while the last column corresponds to the label (output) of each training datum.  The training set contains 1000 rows that correspond to 1000 different training data (input+label). There are 10 different labels numbered 1,…,10.
