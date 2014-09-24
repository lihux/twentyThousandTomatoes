//
//  TTPhotoImageView.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-24.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTPhotoImageView.h"

@implementation TTPhotoImageView

- (void)setImage:(UIImage *)image
{
    [super setImage:image];
    CGRect bounds = self.bounds;
    bounds.size = image.size;
    self.bounds = bounds;
}

@end
