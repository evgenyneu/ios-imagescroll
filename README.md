# Image in a scroll view with auto layout in iOS

This is a demo iOS app that shows how to use image inside a scroll view with auto layout.

Image can be panned and zoomed. It is centered and zoomed out initially.

<img src='https://raw.github.com/evgenyneu/ios-imagescroll/master/image_scroll.png' width='556' alt='Using image inside a scroll view with autolayout in iOS 7'>

## Things to note

* The job is done with auto layout constraints only.
* On each zoom we update the `constant` values for the constraints to center the image if needed.
* Feel free to contact me if you are stuck (like I was).

## How to copy this control to your project

* Check 'Use Autolayout' for your storyboard.
* Copy Image Scroll View Controller into your storyboard, like this:
* Copy files `ImageScrollViewController.m` and `ImageScrollViewController.h` into your project.

<img src='https://raw.github.com/evgenyneu/ios-imagescroll/master/copy_image_scroll_view_controller.png' width='357' alt='Copy Image View Controller'>


## Troubleshooting

Please make sure:

* Your view controller's class has ImageScrollViewController (Identity Inspector).
* VC storybord has all the controlls: View, ScrollView and ImageView along with all their constraints.
* To anable zooming ScrollView's 'max zoom' should be greater than 1 (Attributes Inspector). I used 3 in this demo.
* ImageView, ScrollView, four layout constraints and 'change image' button shuold be linked to their to their outlets in `ImageScrollViewController.m`.

## Thanks

The wallaby photo is made by http://www.flickr.com/photos/wwarby

