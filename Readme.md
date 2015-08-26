# Seeded Laplacian (SL): An Interactive Image Segmentation Approach using Eigenfunctions 
This matlab code provides procedure for Seeded Laplacian (SL). SL is a scribble-based interactive image segmentation approach. SL approach is accept in [ICIP 2015](http://www.icip2015.org/). This code generates the exact results submitted in *[Seeded Laplacian: An Interactive Image Segmentation Approach using Eigenfunctions](http://www.researchgate.net/publication/277598401_SEEDED_LAPLACIAN_AN_INTERACTIVE_IMAGE_SEGMENTATION_APPROACH_USING_EIGENFUNCTIONS)* paper. We quantitatively compare our proposed
method with multiple algorithms, including BJ, PP, SP-IG, SP-LIG,
, SP-SIG, GSC and ESC as shown in the figure.


!["Alt txt"](http://ahmed-taha.com/wp-content/uploads/2015/08/SL-icip-evaluation.png)

We use the user scribble annotations provided by [V Gulshan](https://scholar.google.com/citations?user=QwdY5EIAAAAJ&hl=en&oi=sra) in *[Geodesic star convexity for interactive image segmentation](http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=5540073)*. We extended the data-set in order to simulate a user input of one or two background scribbles only, to measure performance degradation in terms of accuracy with various background scribble inputs



##Motivation

Image segmentation is an important problem in computer vision, and
it is usually an intermediate step in image processing. Due to the difficulty of fully automatic image segmentation, user-interactive segmentation is usually introduced to relax the segmentation problem for certain applications. Our goal is to develop a novel, stable and efficient scribble based-interactive image segmentation approach. 


##Setup
1. Download
2. Run the **scribble_image**.m file. 
3. The output of the script is a figure containing our segmentation result. Also you can find the Jaccard Index metric printed in the output log

The script typically run on a sample image "teddy.jpg". If you would like to run the script on another image, make sure to provide the new image path (RGB image), user annotation image (Indexed Image 1 for foreground annotation, 2 for background annotation) and the segmentation ground-truth image. The segmentation ground-truth image is just used to calculate the Jaccard Index metric. 

For help, please contact ahmdtaha [@] cs dot umd dot edu

##Contributor list

1. [Ahmed Taha](http://www.ahmed-taha.com/) 
2. [Marwan Torki](http://www.eng.alexu.edu.eg/~mtorki/)

##Contribution guidelines
This code is not the final version of SL approach. It is although the version that generates the results submitted to ICIP 2015 in *Seeded Laplacian: An Interactive Image Segmentation Approach using Eigenfunctions* paper. Another version of SL is already developed. This new version uses more sophisticated features than the ones used in this version. It produces higher and more stable results. The main issue in this code is its performance. Usually an image processing time is around 5-10 seconds. Any contribution that can make this code faster is welcomed.



## Citation
@article{tahaseeded,
   author = "Taha, A. and Torki, M.",
   title = "Seeded Laplacian: An Interactive Image Segmentation Approach using Eigenfunctions",
   year = "2015"
  } 

##License
Copyright (c) 2015, Ahmed Taha (ahmdtaha@cs.umd.edu)
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

- Re distributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Re distributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.