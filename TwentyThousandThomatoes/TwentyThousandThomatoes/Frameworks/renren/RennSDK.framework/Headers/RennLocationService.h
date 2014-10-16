//
//  RennLocationService.h
//  RennSDK
//
//  Created by 杨 飞 on 13-6-8.
//  Copyright (c) 2013年 Li Chengliang. All rights reserved.
//

#import "RennParam.h"

extern NSString *kLocationFeedTypeAll; //全部类型
extern NSString *kLocationFeedTypeIMAGE; //照片类型
extern NSString *kLocationFeedTypeCHECKIN;//签到类型
extern NSString *kLocationFeedTypeSTATUS;//状态类型
extern NSString *kLocationFeedTypePOINT;//地点评价类型

extern NSString *kRennServiceTypeGetLocation;
extern NSString *kRennServiceTypeListLocationFeed;

/*
 API链接: http://wiki.dev.renren.com/wiki/V2/location/get
 */
@interface GetLocationParam : RennParam

//可选
@property (nonatomic, retain) NSString *deflection;

//必选
@property (nonatomic, retain) NSString *longitude;

//必选
@property (nonatomic, retain) NSString *latitude;

@end




/*
 API链接: http://wiki.dev.renren.com/wiki/V2/location/feed/list
 */
@interface ListLocationFeedParam : RennParam

//可选
@property (nonatomic, assign) NSInteger pageSize;

//可选
@property (nonatomic, assign) NSInteger pageNumber;

//必选
@property (nonatomic, retain) NSString *locationFeedType;

//可选
@property (nonatomic, retain) NSString *radius;

//必选
@property (nonatomic, retain) NSString *longitude;

//必选
@property (nonatomic, retain) NSString *latitude;

@end