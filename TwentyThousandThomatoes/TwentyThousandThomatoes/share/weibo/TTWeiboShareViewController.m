//
//  TTWeiboShareViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-10-15.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTWeiboShareViewController.h"

#import "WeiboSDK.h"
#import "TTThirdPartShareDefines.h"

@interface TTWeiboShareViewController () <WeiboSDKDelegate>

@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@end

@implementation TTWeiboShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [WeiboSDK registerApp:kDefaultWeiboAppID];
}

- (IBAction)didTapOnLoginButton:(id)sender
{
    WBAuthorizeRequest *authorizeRequest = [[WBAuthorizeRequest alloc] init];
    authorizeRequest.redirectURI = kDefaultWeiboRedirectURL;
    authorizeRequest.scope = @"all";
    [WeiboSDK sendRequest:authorizeRequest];
}

- (IBAction)didTapOnGetUserInfoButton:(id)sender
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSString *result = nil;
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
            result = @"成功";
            break;
        case WeiboSDKResponseStatusCodeAuthDeny:
            result = @"授权被拒绝";
            break;
        case WeiboSDKResponseStatusCodeUnknown:
            result = @"未知状态码";
            break;
        case WeiboSDKResponseStatusCodeUnsupport:
            result = @"不支持的code";
            break;
        case WeiboSDKResponseStatusCodeSentFail:
            result = @"发送是吧";
            break;
        case WeiboSDKResponseStatusCodeUserCancel:
            result = @"用户取消";
            break;
        case WeiboSDKResponseStatusCodeUserCancelInstall:
            result = @"用户取消安装";
            break;
            
        default:
            break;
    }
    self.infoTextView.text = [NSString stringWithFormat:@"%@\n %@", response.userInfo, result];
}
@end
