//
//  TTPhotoEditViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-19.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTPhotoEditViewController.h"

#import "TTPhotoMaskView.h"

@interface TTPhotoEditViewController () <UIScrollViewDelegate, UIContentContainer, TTPhotoMaskViewDelegate>

@property (weak, nonatomic) IBOutlet TTPhotoMaskView *maskView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) BOOL needAdjustScrollViewZoomScale;

@end

@implementation TTPhotoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.originImage;
    self.maskView.delegate = self;
    self.maskView.maskType = TTPhotoMaskViewMaskTypeCircle;
    self.needAdjustScrollViewZoomScale = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    self.scrollView.delegate = nil;
}

#pragma mark - TTPhotoMaskViewDelegate
- (void)pickingFieldRectChangedTo:(CGRect)rect
{
    CGFloat topGap = rect.origin.y;
    CGFloat leftGap = rect.origin.x;
    self.scrollView.contentInset = UIEdgeInsetsMake(topGap, leftGap, topGap, leftGap);

    CGFloat maskCircleWidth = rect.size.width;
    CGSize imageSize = self.originImage.size;
    self.scrollView.contentSize = imageSize;
    CGFloat minimunZoomScale = imageSize.width < imageSize.height ? maskCircleWidth / imageSize.width : maskCircleWidth / imageSize.height;
    CGFloat maximumZoomScale = 5;
    self.scrollView.minimumZoomScale = minimunZoomScale;
    self.scrollView.maximumZoomScale = maximumZoomScale;
    self.scrollView.zoomScale = self.scrollView.zoomScale < minimunZoomScale ? minimunZoomScale : self.scrollView.zoomScale;

    if (self.needAdjustScrollViewZoomScale) {
        CGFloat temp = self.view.bounds.size.width < self.view.bounds.size.height ? self.view.bounds.size.width : self.view.bounds.size.height;
        minimunZoomScale = imageSize.width < imageSize.height ? temp / imageSize.width : temp / imageSize.height;
        self.scrollView.zoomScale = minimunZoomScale;
        self.needAdjustScrollViewZoomScale = NO;
    }
}

#pragma mark - UIContentContainer protocol
- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    [self.maskView setNeedsDisplay];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
