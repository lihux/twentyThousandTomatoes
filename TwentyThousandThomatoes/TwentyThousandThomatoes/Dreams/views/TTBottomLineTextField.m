//
//  TTBottomLineTextField.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-10-8.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTBottomLineTextField.h"

@implementation TTBottomLineTextField

- (CGRect)borderRectForBounds:(CGRect)bounds
{
    CGRect borderRect = bounds;
    borderRect.origin.y = borderRect.size.height - 1;
    borderRect.size.height = 1;
    return borderRect;
}

@end
