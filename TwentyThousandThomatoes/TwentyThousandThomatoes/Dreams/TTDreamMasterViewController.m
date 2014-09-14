//
//  TTDreamMasterViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-9.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTDreamMasterViewController.h"

#import "TTDataSourceManager.h"
#import "TTLifeGoal.h"
#import "TTWhoAmIViewController.h"

@interface TTDreamMasterViewController ()

@end

@implementation TTDreamMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tt_tabbar_dream_selected"];
    [self loadMyDreams];
}

- (void)loadMyDreams
{
    NSArray *myDreams = [[TTDataSourceManager sharedInstance] searchManagedObjectWithEntityName:NSStringFromClass([TTLifeGoal class])];
    if (myDreams.count) {
        ;
    } else {
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id a = segue.destinationViewController;
    if (a == nil) {
        ;
    };
}

@end
