//
//  TTYearRing.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-11.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TTYearRing : NSManagedObject

@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * ringNumber;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSString * yearAchivements;
@property (nonatomic, retain) NSString * yearDescritpion;
@property (nonatomic, retain) NSData * yearPhoto;
@property (nonatomic, retain) NSManagedObject *owner;

@end
