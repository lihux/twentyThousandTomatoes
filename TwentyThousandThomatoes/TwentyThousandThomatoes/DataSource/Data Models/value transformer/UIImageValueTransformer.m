//
//  UIImageValueTransformer.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-18.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "UIImageValueTransformer.h"

@implementation UIImageValueTransformer

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    UIImage *image = (UIImage *)value;
    return UIImageJPEGRepresentation(image, 1.0);
}

- (id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}

@end
