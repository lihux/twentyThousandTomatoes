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

- (void)viewWillDisappear:(BOOL)animated
{
    [self saveSettingsToCoreData];
}

- (void)loadDataFromCoreData
{
    NSArray *iInfos = [[TTDataSourceManager sharedInstance] searchManagedObjectWithEntityName:NSStringFromClass([TTI class])];
    if (iInfos.count > 0) {
        self.me = iInfos[0];
        [self.userHeadButton setImage:self.me.headImage forState:UIControlStateNormal];
        [self updateGenderButtonsWithTag:self.me.gender.integerValue];
    } else {
        self.me = (TTI *)[[TTDataSourceManager sharedInstance] createManagedObjectWithEntityName:NSStringFromClass([TTI class])];
    }
}

- (void)saveSettingsToCoreData
{
    [[TTDataSourceManager sharedInstance] saveManagedObjectContext];
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
    UITextField *textField = (UITextField *)sender;
    if (textField.tag == 0) {
        self.me.name = textField.text;
    } else {
        self.me.school = textField.text;
    }
}

- (IBAction)didTapOnGenderButton:(id)sender
{
    UIButton *selectedButton = (UIButton *)sender;
    [self updateGenderButtonsWithTag:selectedButton.tag];
    self.me.gender = [NSNumber numberWithInteger:selectedButton.tag];
}


- (void)updateGenderButtonsWithTag:(NSInteger)tag
{
    [self.genderButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *genderButton = (UIButton *)obj;
        genderButton.selected = tag == genderButton.tag ? YES : NO;
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
