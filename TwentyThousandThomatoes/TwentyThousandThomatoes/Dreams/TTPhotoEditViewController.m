//
//  TTPhotoEditViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-19.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTPhotoEditViewController.h"

#import "TTPhotoMaskView.h"
#import "TTDataSourceManager.h"
#import "TTI.h"

@interface TTPhotoEditViewController () <UIScrollViewDelegate, UIContentContainer, TTPhotoMaskViewDelegate>

@property (weak, nonatomic) IBOutlet TTPhotoMaskView *maskView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) BOOL needAdjustScrollViewZoomScale;
@property (nonatomic, assign) CGRect pickingFieldRect;

@end

@implementation TTPhotoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.originImage;
    self.maskView.delegate = self;
    self.maskView.maskType = TTPhotoMaskViewMaskTypeCircle;
    self.pickingFieldRect = CGRectZero;
    self.needAdjustScrollViewZoomScale = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (CGRect)convertClipRectToImage
{
    CGRect clipedRect = self.pickingFieldRect;
    CGFloat zoomScale = self.scrollView.zoomScale;
    clipedRect.size.width = clipedRect.size.width / zoomScale;
    clipedRect.size.height = clipedRect.size.height / zoomScale;
    clipedRect.origin.x = (self.scrollView.contentOffset.x + clipedRect.origin.x) / zoomScale;
    clipedRect.origin.y = (self.scrollView.contentOffset.y + clipedRect.origin.y) / zoomScale;
    return clipedRect;
}

- (IBAction)didTapOnDoneButton:(id)sender
{
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.originImage.CGImage, [self convertClipRectToImage]);
    UIImage *clipedImage = [UIImage imageWithCGImage:imageRef];
    NSArray *iInfos = [[TTDataSourceManager sharedInstance] searchManagedObjectWithEntityName:NSStringFromClass([TTI class])];
    if (iInfos.count > 0) {
        TTI *i = iInfos[0];
        i.headImage = clipedImage;
        [[TTDataSourceManager sharedInstance] saveManagedObjectContext];
    }

    NSInteger currentIndex = [self.navigationController.viewControllers indexOfObject:self];
    [self.navigationController popToViewController:self.navigationController.viewControllers[currentIndex - 2] animated:YES];
}

- (void)dealloc
{
    self.scrollView.delegate = nil;
}

#pragma mark - TTPhotoMaskViewDelegate
- (void)pickingFieldRectChangedTo:(CGRect)rect
{
    self.pickingFieldRect = rect;
    CGFloat topGap = rect.origin.y;
    CGFloat leftGap = rect.origin.x;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(topGap, leftGap, topGap, leftGap);
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

@end
