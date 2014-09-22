//
//  TTPhotoEditViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-19.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTPhotoEditViewController.h"

@interface TTPhotoEditViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TTPhotoEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.imageView.image = self.originImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIImage *image = self.imageView.image;
    NSLog(@"image size: 宽：%f, 高:%f，scale: %f\n", image.size.width, image.size.height, self.imageView.contentScaleFactor);
}

@end
