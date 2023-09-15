## MetalImage ##

* A GPU-Processing Library for Images, Videos in iOS.

* Author: Ericking Xu
* Email : erickingxu@gmail.com


## Overview ##

MetalImage is a better way for using GPU to process images and videos in iOS, and later will support Mac OSX.
So I try my best to do some intresting algorithms with Metal,like intelligent beauty, 2d face-change, 3D-Animation rendering.
I had completed some simple works and demos for processing images and videos with MetalImage.I try to make this framework be similar to famous "GPUImage" in function, and on other hand, it supported custom filter for some trouble-speed neckbottle caused by huge filters chain.
So if you are familar to GPUImage, you will find it is very easy to use in MetalImage. And some thankfulness for Brad Larson,as he gave me some tips ever.
Today,I decided to share my works with a memorable date of birth of my daughter,and I will update this library in future.

## Workflow 
* 1).Some 3D interfaces will be added for easy using metal draw CG effects.
* 2).Some face detections interface will be provided with this library, maybe need some days(almost work)
     ![OriginImage](examples/JackMa.jpg)
     ![SharpenImage](examples/fSharpen.PNG)
* 3).Some optimizations will be updated.
* 4).MASS for metal display, 4xsample ,8xsample.[completed]

## To-do list in future

* add 3d model viewer and loader 
* update other beauty algorithm
* 3d physic engine is on the way 
## License ##

MIT-style, with the full license available with the framework in License.txt.
But if you use it, please give me a email for User List.

## User List ## 

## Reference ##
* 1). https://kieber-emmons.medium.com/optimizing-parallel-reduction-in-metal-for-apple-m1-8e8677b49b01
