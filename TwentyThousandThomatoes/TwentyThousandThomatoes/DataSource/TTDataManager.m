//
//  TTDataManager.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-9.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTDataManager.h"

@implementation TTDataManager

+ (instancetype)sharedInstance
{
    static TTDataManager *sharedObject;
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

@end
