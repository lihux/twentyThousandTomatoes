//
//  TTQQShareViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-10-15.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTQQShareViewController.h"

#import "TTThirdPartShareDefines.h"
#import <TencentOpenAPI/TencentOAuth.h>

@interface TTQQShareViewController () <TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth *tencentOAuth;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;

@end

@implementation TTQQShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:kDefaultQQAppID andDelegate:self];
}

- (IBAction)didTapOnLoginQQButton:(id)sender
{
    [self.tencentOAuth authorize:@[@"get_user_info", @"add_t"]];
}

- (IBAction)didTapOnGetInfoButton:(id)sender
{
    [self.tencentOAuth getUserInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - TencentSessionDelegate
- (void)tencentDidLogin
{
    self.infoTextView.text = @"登陆成功";
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    
}

- (void)tencentDidNotNetWork
{
}

- (void)getUserInfoResponse:(APIResponse *)response
{
    if (response.retCode == URLREQUEST_SUCCEED) {
        NSMutableString *result = [NSMutableString stringWithFormat:@""];
        for (NSString *key in response.jsonResponse.allKeys) {
            [result appendString:[NSString stringWithFormat:@"%@: %@\n", key, response.jsonResponse[key]]];
        }
        self.infoTextView.text = result;
    }
}

@end
