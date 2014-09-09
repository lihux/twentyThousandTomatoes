//
//  TTTomatoMasterViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-9.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTTomatoMasterViewController.h"

@interface TTTomatoMasterViewController ()

@end

@implementation TTTomatoMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tt_tabbar_tomato_selected"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
