//
//  TTPhotoEditViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-19.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTPhotoEditViewController.h"

#import "TTPhotoMaskView.h"

@interface TTPhotoEditViewController () <UIScrollViewDelegate, UIContentContainer>

@property (weak, nonatomic) IBOutlet TTPhotoMaskView *maskView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TTPhotoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imageView.image = self.originImage;
    [self customScrollView];
}

- (void)customScrollView
{
    static const CGFloat kBoxWidth = 200;
    CGSize imageSize = self.originImage.size;
    CGSize scrollViewSize = self.view.bounds.size;
    CGFloat minimunZoomScale = imageSize.width > imageSize.height ? kBoxWidth / imageSize.width : kBoxWidth / imageSize.height;
    CGFloat maximumZoomScale = 5;
    self.scrollView.minimumZoomScale = minimunZoomScale;
    self.scrollView.maximumZoomScale = maximumZoomScale;
    self.scrollView.zoomScale = minimunZoomScale;
    CGFloat edgeVerticalTemp = 0;
    CGFloat edgeHorizontalTemp = 0;
    edgeVerticalTemp = (scrollViewSize.height - kBoxWidth) / 2;
    edgeHorizontalTemp = (scrollViewSize.width - kBoxWidth) / 2;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(edgeVerticalTemp + 20, edgeHorizontalTemp, edgeVerticalTemp - 20, edgeHorizontalTemp);
    self.scrollView.contentSize = imageSize;
    self.scrollView.contentInset = edgeInsets;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    self.scrollView.delegate = nil;
}

#pragma mark - UIContentContainer protocol
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    NSLog(@"\n  AAAAA:%f, %f, \n   %@",size.width, size.height, coordinator);
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    NSLog(@"\n  BBBBB:UITraitCollection: %@ \n   coordinator:%@\n", newCollection, coordinator);
    [self.maskView setNeedsDisplay];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
