//
//  TTPhotoMaskView.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-24.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTPhotoMaskView.h"


static const CGFloat kWidthGap = 80;
static const CGFloat kHeightGap = 40;
@implementation TTPhotoMaskView

-(void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat circleDiameter = width < height ? (width - kWidthGap) : (height - kHeightGap);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);
    CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.35);
    CGContextSetLineWidth(contextRef, 3);
    CGRect maskCircleRect = CGRectMake((width - circleDiameter) / 2, (height - circleDiameter) / 2, circleDiameter, circleDiameter);
    UIBezierPath *bezierPathOval = [UIBezierPath bezierPathWithOvalInRect:maskCircleRect];
    UIBezierPath *bezierPathRect = [UIBezierPath bezierPathWithRect:rect];
    [bezierPathRect appendPath:bezierPathOval];
    bezierPathRect.usesEvenOddFillRule = YES;
    [bezierPathRect fill];
    CGContextSetLineWidth(contextRef, 2);
    CGContextSetRGBStrokeColor(contextRef, 255, 255, 255, 1);
    [bezierPathOval stroke];
    CGContextRestoreGState(contextRef);
    self.layer.contentsGravity = kCAGravityCenter;
    if ([self.delegate respondsToSelector:@selector(maskCircleRectChangedTo:)]) {
        [self.delegate maskCircleRectChangedTo:maskCircleRect];
    }
}

@end
