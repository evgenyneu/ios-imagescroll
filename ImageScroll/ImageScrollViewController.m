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

@end

@implementation ImageScrollViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.scrollView.delegate = self;
    [self initImageView];
    [self initZoom];
}

- (void) initImageView {
    [self.scrollView removeConstraints: self.scrollView.constraints];
    
    [self addConstraintsForImageEdges];
    
    [self addConstraintsToCenterImage];
}

/*
 Three things to note here:
 1) Constraints are added to self.view and not to self.scrollView. Otherwise the picture will jump when zooming.
 2) Notice that top and left edges have priority 750, and right and bottom have 250.
 3) Using 'greater than' instead of equality to allow centering in addConstraintsToCenterImage.*/
- (void) addConstraintsForImageEdges {
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(>=0@750)-[_imageView]-(>=0@250)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=0@750)-[_imageView]-(>=0@250)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
}

- (void) addConstraintsToCenterImage {
    NSLayoutConstraint *constraintMiddleY =
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0];
    constraintMiddleY.priority = 100;
    [self.view addConstraint:constraintMiddleY];
    
    NSLayoutConstraint *constraintMiddleX =
    [NSLayoutConstraint constraintWithItem:self.imageView
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.scrollView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0];
    constraintMiddleX.priority = 100;
    [self.view addConstraint:constraintMiddleX];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self initZoom];
}

// Zoom to show as much image as possible
- (void) initZoom {
    float minZoom = MIN(self.view.bounds.size.width / self.imageView.image.size.width,
                        self.view.bounds.size.height / self.imageView.image.size.height);
    if (minZoom > 1) return;
    
    self.scrollView.minimumZoomScale = minZoom;
    
    self.scrollView.zoomScale = minZoom;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
