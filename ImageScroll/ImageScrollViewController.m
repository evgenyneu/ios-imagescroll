//
//  ImageScrollViewController.m
//  ImageScroll
//
//  Created by Evgenii Neumerzhitckii on 19/05/13.
//  Copyright (c) 2013 Evgenii Neumerzhitckii. All rights reserved.
//

#import "ImageScrollViewController.h"

@interface ImageScrollViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottom;
@property (weak, nonatomic) IBOutlet UIButton *changeImageButton;
@property (nonatomic) CGFloat lastZoomScale;

@end

@implementation ImageScrollViewController

- (void) viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  self.imageView.image = [UIImage imageNamed: @"wallabi.jpg"];
  self.scrollView.delegate = self;
  [self updateZoom];
}

// Update zoom scale and constraints
// It will also animate because willAnimateRotationToInterfaceOrientation
// is called from within an animation block
//
// DEPRECATION NOTICE: This method is said to be deprecated in iOS 8.0. But it still works.
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];

  [self updateZoom];
}

- (void) scrollViewDidZoom:(UIScrollView *)scrollView {
  [self updateConstraints];
}

- (void) updateConstraints {
  float imageWidth = self.imageView.image.size.width;
  float imageHeight = self.imageView.image.size.height;

  float viewWidth = self.view.bounds.size.width;
  float viewHeight = self.view.bounds.size.height;

  // center image if it is smaller than screen
  float hPadding = (viewWidth - self.scrollView.zoomScale * imageWidth) / 2;
  if (hPadding < 0) hPadding = 0;

  float vPadding = (viewHeight - self.scrollView.zoomScale * imageHeight) / 2;
  if (vPadding < 0) vPadding = 0;

  self.constraintLeft.constant = hPadding;
  self.constraintRight.constant = hPadding;

  self.constraintTop.constant = vPadding;
  self.constraintBottom.constant = vPadding;
    
  // Makes zoom out animation smooth and starting from the right point not from (0, 0)
  [self.view layoutIfNeeded];
}

// Zoom to show as much image as possible
- (void) updateZoom {
  float minZoom = MIN(self.view.bounds.size.width / self.imageView.image.size.width,
                      self.view.bounds.size.height / self.imageView.image.size.height);

  self.scrollView.minimumZoomScale = minZoom;

  // Force scrollViewDidZoom fire if zoom did not change
  if (minZoom == self.lastZoomScale) minZoom += 0.000001;

  self.lastZoomScale = self.scrollView.zoomScale = minZoom;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.imageView;
}

- (IBAction)onImageChangeTouched:(id)sender {
  self.changeImageButton.selected = !self.changeImageButton.isSelected;
  [self.changeImageButton invalidateIntrinsicContentSize];

  NSString *fileName = @"wallabi.jpg";
  if (self.changeImageButton.selected ) fileName = @"wallabi_small.jpg";

  self.imageView.image = [UIImage imageNamed: fileName];
  [self updateZoom];
}

@end
