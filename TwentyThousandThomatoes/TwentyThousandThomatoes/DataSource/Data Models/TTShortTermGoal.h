//
//  TTShortTermGoal.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-11.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TTShortTermGoal : NSManagedObject

@property (nonatomic, retain) NSManagedObject *parentGoal;
@property (nonatomic, retain) NSSet *tomatoes;
@end

@interface TTShortTermGoal (CoreDataGeneratedAccessors)

- (void)addTomatoesObject:(NSManagedObject *)value;
- (void)removeTomatoesObject:(NSManagedObject *)value;
- (void)addTomatoes:(NSSet *)values;
- (void)removeTomatoes:(NSSet *)values;

@end
