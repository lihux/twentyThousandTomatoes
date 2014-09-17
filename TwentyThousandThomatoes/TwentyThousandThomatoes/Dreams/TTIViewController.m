//
//  TTIViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-14.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTIViewController.h"

#import "TTDataSourceManager.h"
#import "TTI.h"

@interface TTIViewController ()

@property (weak, nonatomic) IBOutlet UIButton *userHeadButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *genderButtons;
@property (nonatomic, strong) TTI *me;

@end

@implementation TTIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromCoreData];
}

- (void)loadDataFromCoreData
{
    NSArray *iInfos = [[TTDataSourceManager sharedInstance] searchManagedObjectWithEntityName:NSStringFromClass([TTI class])];
    if (iInfos.count > 0) {
        self.me = iInfos[0];
    }
}

- (void)updateUIForDataChange
{
    if (self.me) {
        TTI *i = self.me;
        if (i.headImage) {
        }
    }
}

- (IBAction)textFieldEditingDidEnd:(id)sender
{
}

- (IBAction)didTapOnGenderButton:(id)sender
{
    UIButton *selectedButton = (UIButton *)sender;
    [self.genderButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *genderButton = (UIButton *)obj;
        genderButton.selected = selectedButton.tag == genderButton.tag ? YES : NO;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
