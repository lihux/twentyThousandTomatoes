//
//  TTMidleTermGoal.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-11.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TTLongTermGoal, TTShortTermGoal;

@interface TTMidleTermGoal : NSManagedObject

@property (nonatomic, retain) TTLongTermGoal *parentGoal;
@property (nonatomic, retain) NSSet *subGoals;
@end

@interface TTMidleTermGoal (CoreDataGeneratedAccessors)

- (void)addSubGoalsObject:(TTShortTermGoal *)value;
- (void)removeSubGoalsObject:(TTShortTermGoal *)value;
- (void)addSubGoals:(NSSet *)values;
- (void)removeSubGoals:(NSSet *)values;

@end
