//
//  RennHeadService.h
//  RennSDK
//
//  Created by Li Chengliang on 13-4-10.
//  Copyright (c) 2013年 Li Chengliang. All rights reserved.
//

#import "RennParam.h"

extern NSString *kRennServiceTypeSetPhotoHead;

/*
 API链接: http://wiki.dev.renren.com/wiki/V2/photo/head/set
 */
@interface SetPhotoHeadParam : RennParam

//必选
@property (nonatomic, retain) NSString *photoId;

@end
