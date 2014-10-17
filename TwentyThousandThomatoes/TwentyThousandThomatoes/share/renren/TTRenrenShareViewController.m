//
//  TTRenrenShareViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-10-15.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTRenrenShareViewController.h"

#import "TTThirdPartShareDefines.h"
#import "RennSDK/RennSDK.h"

@interface TTRenrenShareViewController () <RennLoginDelegate>

@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@end

@implementation TTRenrenShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [RennClient initWithAppId:kDefaultRenrenAppID apiKey:kDefaultRenrenAppKey secretKey:kDefaultRenrenSecretKey];
    [RennClient setScope:@"read_user_album read_user_status publish_feed"];
    [RennClient setTokenType:@"mac"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didTapOnLoginButton:(id)sender
{
    [RennClient loginWithDelegate:self];
}

- (IBAction)didTapOnGetUserInfoButton:(id)sender
{
    PutFeedParam *param = [[PutFeedParam alloc] init];
    param.title = @"新鲜事Title";
    param.description = @"新鲜事Description";
    param.message = @"这是一条新鲜事";
    param.targetUrl = @"http://www.56.com/u72/v_OTAyNTkxMDk.html";

    [RennClient sendAsynRequest:param delegate:self];
}

#pragma mark - RennLoginDelegate
- (void)rennLoginSuccess
{
    self.infoTextView.text = @"登陆成功";
}

- (void)rennLogoutSuccess
{
    
}
- (void)rennLoginCancelded
{
    
}

- (void)rennLoginDidFailWithError:(NSError *)error
{
    
}

- (void)rennLoginAccessTokenInvalidOrExpired:(NSError *)error
{
    
}

- (void)rennService:(RennService *)service requestSuccessWithResponse:(id)response
{
    self.infoTextView.text = [NSString stringWithFormat:@"成功了：%@", response];
}
- (void)rennService:(RennService *)service requestFailWithError:(NSError*)error
{
    self.infoTextView.text = [NSString stringWithFormat:@"失败了：%@", error];
}

@end
