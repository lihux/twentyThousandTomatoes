//
//  TTTomato.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-11.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TTShortTermGoal;

@interface TTTomato : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * timeDurationsInMinutes;
@property (nonatomic, retain) TTShortTermGoal *owner;

@end
