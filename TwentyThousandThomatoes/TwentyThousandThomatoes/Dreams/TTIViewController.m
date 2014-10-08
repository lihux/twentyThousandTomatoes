//
//  TTIViewController.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-14.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTIViewController.h"

#import "TTDataSourceManager.h"
#import "TTBottomLineTextField.h"
#import "TTI.h"

@interface TTIViewController ()

@property (weak, nonatomic) IBOutlet UIButton *userHeadButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *genderButtons;
@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutletCollection(TTBottomLineTextField) NSArray *textFields;

@property (nonatomic, strong) TTI *me;

@end

@implementation TTIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customUI];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self saveSettingsToCoreData];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadDataFromCoreData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillhide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBoardWillChangeFrame:(NSNotification *)notification
{
    CGRect keyBoardEndFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat timeDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    keyBoardEndFrame = [self.view convertRect:keyBoardEndFrame fromView:nil];
    UITextField *responedTextField = [self respondedTextField];
    if (responedTextField) {
        CGRect textFieldFrame = [self.view convertRect:responedTextField.frame fromView:responedTextField.superview];
        CGFloat gap = textFieldFrame.origin.y + textFieldFrame.size.height - keyBoardEndFrame.origin.y;
        if (gap > 0) {
            CGRect bounds = self.view.bounds;
            bounds.origin.y += gap;
            [UIView animateWithDuration:timeDuration animations:^{
                self.view.bounds = bounds;
            }];
        }
    }
}

- (void)keyBoardWillhide:(NSNotification *)notification
{
    CGFloat timeDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat boundsOffset = self.view.bounds.origin.y;
    if (boundsOffset > 0) {
        CGRect bounds = self.view.bounds;
        bounds.origin.y = 0;
        [UIView animateWithDuration:timeDuration animations:^{
            self.view.bounds = bounds;
        }];
    }
}

- (UITextField *)respondedTextField
{
    for (UITextField *textField in self.textFields) {
        if ([textField isFirstResponder]) {
            return textField;
        }
    }
    return nil;
}

- (void)customUI
{
    self.userHeadButton.clipsToBounds = YES;
    self.userHeadButton.layer.cornerRadius = self.userHeadButton.bounds.size.width / 2;
}


- (void)loadDataFromCoreData
{
    NSArray *iInfos = [[TTDataSourceManager sharedInstance] searchManagedObjectWithEntityName:NSStringFromClass([TTI class])];
    if (iInfos.count > 0) {
        self.me = iInfos[0];
        [self updateGenderButtonsWithTag:self.me.gender.integerValue];
        if (self.me.name) {
            self.nameTextField.text = self.me.name;
        }
        if (self.me.school) {
            self.schoolTextField.text = self.me.school;
        }
        if (self.me.headImage) {
            [self.userHeadButton setImage:self.me.headImage forState:UIControlStateNormal];
        }
    } else {
        self.me = (TTI *)[[TTDataSourceManager sharedInstance] createManagedObjectWithEntityName:NSStringFromClass([TTI class])];
    }
}

- (void)saveSettingsToCoreData
{
    self.me.name = self.nameTextField.text;
    self.me.school = self.schoolTextField.text;
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

- (IBAction)didTapToCancelEdit:(id)sender
{
    [[self respondedTextField] resignFirstResponder];
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
