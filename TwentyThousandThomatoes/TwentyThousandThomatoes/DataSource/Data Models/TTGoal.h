//
//  TTGoal.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-11.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TTGoal : NSManagedObject

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * detailDescription;
@property (nonatomic, retain) NSNumber * earnedTomatoCount;
@property (nonatomic, retain) NSDate * finishTime;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * timeIntervalInDays;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * totalTomatoCount;

@end
