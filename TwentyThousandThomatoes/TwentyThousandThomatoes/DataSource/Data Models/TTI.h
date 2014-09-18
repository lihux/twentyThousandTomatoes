//
//  TTI.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-17.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TTLifeGoal, TTYearRing;

@interface TTI : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSNumber * earnedTomatoes;
@property (nonatomic, retain) id headImage;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) TTLifeGoal *lifeGoals;
@property (nonatomic, retain) NSSet *yearRings;
@end

@interface TTI (CoreDataGeneratedAccessors)

- (void)addYearRingsObject:(TTYearRing *)value;
- (void)removeYearRingsObject:(TTYearRing *)value;
- (void)addYearRings:(NSSet *)values;
- (void)removeYearRings:(NSSet *)values;

@end
