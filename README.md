# Image in a scroll view with auto layout in iOS

This is a demo iOS app that shows how to use image inside a scroll view with auto layout.

Image can be panned and zoomed. It is centered and zoomed out initially.

<img src='https://raw.github.com/evgenyneu/ios-imagescroll/master/image_scroll.png' width='556' alt='Using image inside a scroll view with autolayout in iOS 7'>

# Things to note

* The job is done with auto layout constraints only.
* On each zoom we update the `constant` values for the constraints to center the image if needed.
* Remember to add max zoom for scroll view in Interface Builder.
* Feel free to contact me if you are stuck (like I was).

# Thanks

The wallaby photo is made by http://www.flickr.com/photos/wwarby

