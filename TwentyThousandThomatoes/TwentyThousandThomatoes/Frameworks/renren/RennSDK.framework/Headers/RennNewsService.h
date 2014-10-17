//
//  RennNewsService.h
//  RennSDK
//
//  Created by 杨 飞 on 13-5-13.
//  Copyright (c) 2013年 YangFei. All rights reserved.
//

#import "RennParam.h"

extern NSString *kRennServiceTypeGetNewsCount;
extern NSString *kRennServiceTypeClearNewsCount;

extern const NSString *kTypeNewsTypeFEED;
extern const NSString *kTypeNewsTypeREMIND;
extern const NSString *kTypeNewsTypeNOTIFICATION;
extern const NSString *kTypeNewsTypeREQUEST;
extern const NSString *kTypeNewsTypeALL;

/*
 API链接: http://wiki.dev.renren.com/wiki/V2/news/counts/get
 */
@interface GetNewsCountParam : RennParam

//可选
@property (nonatomic, retain) NSString *newTypes;

@end


/*
 API链接: http://wiki.dev.renren.com/wiki/V2/news/count/clear
 */
@interface ClearNewsCountParam : RennParam

//可选
@property (nonatomic, retain) NSString *newType;

@end

