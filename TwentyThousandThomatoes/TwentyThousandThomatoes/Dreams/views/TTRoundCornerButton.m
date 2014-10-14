//
//  TTRoundCornerButton.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-10-14.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTRoundCornerButton.h"

@implementation TTRoundCornerButton

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self customUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customUI];
    }
    return self;
}

- (void)customUI
{
    self.layer.cornerRadius = 4;
    self.clipsToBounds = YES;
}

@end
