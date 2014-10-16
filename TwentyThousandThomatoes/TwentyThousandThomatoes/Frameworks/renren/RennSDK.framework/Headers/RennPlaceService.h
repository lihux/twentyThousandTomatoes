//
//  RennPlaceService.h
//  RennSDK
//
//  Created by 杨 飞 on 13-6-8.
//  Copyright (c) 2013年 Li Chengliang. All rights reserved.
//

#import "RennParam.h"

extern NSString *kRennServiceTypeListPlace;
extern NSString *kRennServiceTypeListPlaceFeed;

/*
 API链接: http://wiki.dev.renren.com/wiki/V2/place/list
 */
@interface ListPlaceParam : RennParam

//可选
@property (nonatomic, assign) NSInteger pageSize;

//可选
@property (nonatomic, assign) NSInteger pageNumber;

//可选
@property (nonatomic, retain) NSString *placeName;

//可选
@property (nonatomic, retain) NSString *radius;

//必选
@property (nonatomic, retain) NSString *longitude;

//必选
@property (nonatomic, retain) NSString *latitude;

//可选
@property (nonatomic, retain) NSString *deflection;

@end


/*
 API链接: http://wiki.dev.renren.com/wiki/V2/place/feed/list
 */
@interface ListPlaceFeedParam : RennParam

//可选
@property (nonatomic, assign) NSInteger pageSize;

//可选
@property (nonatomic, assign) NSInteger pageNumber;

//必选
@property (nonatomic, retain) NSString *placeId;

//必选
@property (nonatomic, retain) NSString *locationFeedType;

@end