//
//  UIViewController+GetInstanceFromStoryBoard.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-9.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "UIViewController+GetInstanceFromStoryBoard.h"

@implementation UIViewController (GetInstanceFromStoryBoard)

/**
 *  NOTICE: Cause we use NSStringFromClass([self class] string as our storyboard identifier in this method, we must set the storyboard identifier to the real
 class name in storyboard.
 *
 *  @return : a instance of the speicific view controller
 */
+ (instancetype)getInstanceFromStoryBoard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

@end
