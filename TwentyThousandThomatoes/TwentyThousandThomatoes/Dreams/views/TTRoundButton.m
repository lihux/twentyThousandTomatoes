//
//  TTRoundButton.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-29.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTRoundButton.h"

@implementation TTRoundButton

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
    self.layer.cornerRadius = self.bounds.size.width / 2;
    self.clipsToBounds = YES;
}

@end
