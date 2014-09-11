//
//  TTLongTermGoal.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-11.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TTLongTermGoal : NSManagedObject

@property (nonatomic, retain) NSManagedObject *parentGoal;
@property (nonatomic, retain) NSSet *subGoals;
@end

@interface TTLongTermGoal (CoreDataGeneratedAccessors)

- (void)addSubGoalsObject:(NSManagedObject *)value;
- (void)removeSubGoalsObject:(NSManagedObject *)value;
- (void)addSubGoals:(NSSet *)values;
- (void)removeSubGoals:(NSSet *)values;

@end
