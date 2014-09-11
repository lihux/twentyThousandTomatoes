//
//  TTDataSourceManager.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-9.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@interface TTDataSourceManager : NSObject

+ (instancetype)sharedInstance;
- (BOOL)saveManagedObjectContext;
- (NSManagedObject *)createManagedObjectWithEntityName:(NSString *)entityName;
- (BOOL)deleteManagedObject:(NSManagedObject *)manangedObject;
- (NSArray *)searchManagedObjectWithEntityName:(NSString *)entityName;

@end
