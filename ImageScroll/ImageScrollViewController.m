//
//  ImageScrollViewController.m
//  ImageScroll
//
//  Created by Evgenii Neumerzhitckii on 19/05/13.
//  Copyright (c) 2013 Evgenii Neumerzhitckii. All rights reserved.
//

#import "ImageScrollViewController.h"

@interface ImageScrollViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ImageScrollViewController

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.scrollView.delegate = self;
    [self createImageView];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view setNeedsUpdateConstraints];
}

- (void) createImageView {
    UIImage *image =  [UIImage imageNamed:@"wallabi.jpg"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = image.size;
}

- (void) updateViewConstraints {
    [super updateViewConstraints];
    NSLog(@"image view size: %@", NSStringFromCGSize(self.imageView.bounds.size));
    NSLog(@"scroll view size: %@", NSStringFromCGSize(self.scrollView.bounds.size));
    NSLog(@"Scroll View content size: %@", NSStringFromCGSize(self.scrollView.contentSize));

    NSLog(@"Number of view consraings: %i", self.view.constraints.count);
    NSLog(@"Number of scrollView consraints: %i", self.scrollView.constraints.count);
    NSLog(@"Number of imageView consraints: %i", self.imageView.constraints.count);
}

//- (void) viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    NSLog(@"----------- viewWillAppear START -----------");
//    NSLog(@"Number of view consraings: %i", self.view.constraints.count);
//    NSLog(@"Number of imageView consraings: %i", self.imageView.constraints.count);
//
//    [self.view removeConstraints:[self.view constraints]];
//    [self.imageView removeConstraints:[self.imageView constraints]];
//    
//    NSLog(@"Number of view consraings: %i", self.view.constraints.count);
//    NSLog(@"Number of imageView consraings: %i", self.imageView.constraints.count);
//    
//    
//    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
//    NSString *imageViewConstraintH = [NSString stringWithFormat:@"|-[_imageView(%.f)]-|", self.imageView.image.size.width ];
//    
//    NSString *imageViewConstraintV = [NSString stringWithFormat:@"V:|-[_imageView(%.f)]-|", self.imageView.image.size.height ];
//
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:imageViewConstraintH options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:imageViewConstraintV options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView)]];

//    [self.imageView setNeedsUpdateConstraints];
//    [self.view setNeedsUpdateConstraints];
//    
//    NSLog(@"----------- viewWillAppear END -----------");
//    NSLog(@"Number of view consraings: %i", self.view.constraints.count);
//    NSLog(@"Number of imageView consraings: %i", self.imageView.constraints.count);
//}

@end
