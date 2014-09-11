//
//  TTLifeGoal.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-11.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TTGoal.h"

@class TTI, TTLongTermGoal;

@interface TTLifeGoal : TTGoal

@property (nonatomic, retain) TTI *owner;
@property (nonatomic, retain) NSSet *subGoals;
@end

@interface TTLifeGoal (CoreDataGeneratedAccessors)

- (void)addSubGoalsObject:(TTLongTermGoal *)value;
- (void)removeSubGoalsObject:(TTLongTermGoal *)value;
- (void)addSubGoals:(NSSet *)values;
- (void)removeSubGoals:(NSSet *)values;

@end
