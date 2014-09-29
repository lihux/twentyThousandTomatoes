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

@interface TTPhotoMaskView ()

@property (nonatomic, assign) CGRect pickingFieldRect;

@end

@implementation TTPhotoMaskView

-(void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat pickingFieldWidth = width < height ? (width - kWidthGap) : (height - kHeightGap);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);
    CGContextSetRGBFillColor(contextRef, 0, 0, 0, 0.35);
    CGContextSetLineWidth(contextRef, 3);
    self.pickingFieldRect = CGRectMake((width - pickingFieldWidth) / 2, (height - pickingFieldWidth) / 2, pickingFieldWidth, pickingFieldWidth);
    UIBezierPath *pickingFieldPath = [self pickingFieldShapePathForType:self.maskType];
    UIBezierPath *bezierPathRect = [UIBezierPath bezierPathWithRect:rect];
    [bezierPathRect appendPath:pickingFieldPath];
    bezierPathRect.usesEvenOddFillRule = YES;
    [bezierPathRect fill];
    CGContextSetLineWidth(contextRef, 2);
    CGContextSetRGBStrokeColor(contextRef, 255, 255, 255, 1);
    CGFloat dash[2] = {4,4};
    [pickingFieldPath setLineDash:dash count:2 phase:0];
    [pickingFieldPath stroke];
    CGContextRestoreGState(contextRef);
    self.layer.contentsGravity = kCAGravityCenter;
    if ([self.delegate respondsToSelector:@selector(pickingFieldRectChangedTo:)]) {
        [self.delegate pickingFieldRectChangedTo:self.pickingFieldRect];
    }
}

- (UIBezierPath *)pickingFieldShapePathForType:(TTPhotoMaskViewMaskType)type
{
    switch (self.maskType) {
        case TTPhotoMaskViewMaskTypeCircle:
            return [UIBezierPath bezierPathWithOvalInRect:self.pickingFieldRect];
            break;

        case TTPhotoMaskViewMaskTypeRectangle:
            return [UIBezierPath bezierPathWithRect:self.pickingFieldRect];
            break;

        default:
            break;
    }
}

@end
