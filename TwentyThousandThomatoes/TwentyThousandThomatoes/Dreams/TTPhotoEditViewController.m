//
//  TTPhotoEditViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-19.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTPhotoEditViewController.h"

#import "TTPhotoMaskView.h"
#import <QuartzCore/QuartzCore.h>

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CALayer *maskLayer = self.maskView.layer;
    maskLayer.contents = (__bridge id)([UIImage imageNamed:@"ttt_dream_default_user"].CGImage);
    maskLayer.contentsGravity = kCAGravityCenter;
    maskLayer.contentsScale = 3;
    maskLayer.shadowOpacity = 0.5;
    maskLayer.shadowOffset = CGSizeMake(0.5, 0.5);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.toValue = @(0);
    animation.duration = 3;
//    [maskLayer addAnimation:animation forKey:@"opacity"];
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 100, 100);
    CGPathAddCurveToPoint(path, NULL, 150, 150, 180, 180, 200, 200);
    CGPathAddCurveToPoint(path, NULL, 180, 180, 250, 250, 300, 300);
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    keyFrameAnimation.path = path;
    keyFrameAnimation.values = @[
                                 [NSValue valueWithCGPoint:CGPointMake(100, 80)],
                                 [NSValue valueWithCGPoint:CGPointMake(20, 190)],
                                 [NSValue valueWithCGPoint:CGPointMake(100, 300)]
                                 ];
    keyFrameAnimation.duration = 2.0;
    [maskLayer addAnimation:keyFrameAnimation forKey:@"position"];
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
//    [self.maskView setNeedsDisplay];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
