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

@end

@implementation ImageScrollViewController

- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  self.imageView.image = [UIImage imageNamed: @"wallabi.jpg"];

  self.scrollView.delegate = self;
  [self updateZoom];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
  [super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
  [self updateZoom];
  if (self.scrollView.zoomScale == 1) self.scrollView.zoomScale = 1.0001;
}

- (void) scrollViewDidZoom:(UIScrollView *)scrollView {
  [self updateConstraints];
}

- (void) updateConstraints {
  float imageWidth = self.imageView.image.size.width;
  float imageHeight = self.imageView.image.size.height;

  float viewWidth = self.view.bounds.size.width;
  float viewHeight = self.view.bounds.size.height;

  float hPadding = (viewWidth - self.scrollView.zoomScale * imageWidth) / 2;
  if (hPadding < 0) hPadding = 0;

  float vPadding = (viewHeight - self.scrollView.zoomScale * imageHeight) / 2;
  if (vPadding < 0) vPadding = 0;

  self.constraintLeft.constant = hPadding;
  self.constraintRight.constant = hPadding;

  self.constraintTop.constant = vPadding;
  self.constraintBottom.constant = vPadding;
}

- (void) updateZoom {
  float minZoom = MIN(self.view.bounds.size.width / self.imageView.image.size.width,
                      self.view.bounds.size.height / self.imageView.image.size.height);

  if (minZoom > 1) minZoom = 1;

  // Prevent from zooming out too much
  self.scrollView.minimumZoomScale = minZoom;

  // Zoom to show as much image as possible
  self.scrollView.zoomScale = minZoom;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.imageView;
}

@end
