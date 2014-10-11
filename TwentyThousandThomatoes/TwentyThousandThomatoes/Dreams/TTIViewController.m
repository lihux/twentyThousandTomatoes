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

static const NSString *kMinimumBirthdayYear = @"1894";

@interface TTIViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *userHeadButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *genderButtons;
@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutletCollection(TTBottomLineTextField) NSArray *textFields;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *birthdayButton;
@property (weak, nonatomic) IBOutlet UIView *pickerContainerView;

@property (nonatomic, strong) TTI *me;
@property (nonatomic, assign) BOOL hasShowPickerView;

@end

@implementation TTIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasShowPickerView = NO;
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
    [self replacePickerContainerViewTopConstraintWithConstant:-self.pickerContainerView.bounds.size.height];
}

- (void)replacePickerContainerViewTopConstraintWithConstant:(CGFloat)constant
{
    for (NSLayoutConstraint *constraint in self.pickerContainerView.superview.constraints) {
        if (constraint.secondItem == self.pickerContainerView && constraint.secondAttribute == NSLayoutAttributeBottom) {
            constraint.constant = constant;
        }
    }
}

- (void)loadDataFromCoreData
{
    NSArray *iInfos = [[TTDataSourceManager sharedInstance] searchManagedObjectWithEntityName:NSStringFromClass([TTI class])];
    if (iInfos.count > 0) {
        self.me = iInfos[0];
        [self updateGenderButtonsWithTag:self.me.gender.integerValue];
        [self.birthdayButton setTitle:self.me.birthday forState:UIControlStateNormal];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        [self.datePicker setDate:[dateFormatter dateFromString:self.me.birthday] animated:NO];
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

- (IBAction)didTapOnDoneButton:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *birthday = [dateFormatter stringFromDate:self.datePicker.date];
    [self.birthdayButton setTitle:birthday forState:UIControlStateNormal];
    self.me.birthday = birthday;
    [self didTapOnBirthdayButton:nil];
}


- (IBAction)didTapOnBirthdayButton:(id)sender
{
    [[self respondedTextField] resignFirstResponder];
    self.hasShowPickerView = !self.hasShowPickerView;
    if (self.hasShowPickerView) {
        CGRect birthdayButtonFrame = self.birthdayButton.frame;
        birthdayButtonFrame = [self.view convertRect:birthdayButtonFrame fromView:self.birthdayButton.superview];
        CGFloat birthdayButtonYOffset = birthdayButtonFrame.origin.y + birthdayButtonFrame.size.height;
        CGFloat gap = birthdayButtonYOffset - (self.view.frame.size.height - self.pickerContainerView.frame.size.height);
        CGRect bounds = self.view.bounds;
        if (gap > 0) {
            bounds.origin.y = gap;
            NSLog(@"lihux: gap = %f, h = %f \n", gap, self.pickerContainerView.bounds.size.height);
        } else {
            gap = 0;
        }
        [self replacePickerContainerViewTopConstraintWithConstant:-gap];
        [UIView animateWithDuration:0.25 animations:^{
            self.view.bounds = bounds;
            [self.view layoutIfNeeded];
        }];
    } else {
        [self replacePickerContainerViewTopConstraintWithConstant:-self.pickerContainerView.bounds.size.height];
        CGRect bounds = self.view.bounds;
        bounds.origin.y = 0;
        [UIView animateWithDuration:0.25 animations:^{
            self.view.bounds = bounds;
            [self.view layoutIfNeeded];
        }];
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
    if (self.hasShowPickerView) {
        [self didTapOnBirthdayButton:nil];
    }
    [[self respondedTextField] resignFirstResponder];
}

- (IBAction)datePickerValueChanged:(id)sender
{
    static NSDateFormatter *dateFormatter = nil;
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if ([self.datePicker.date compare:[NSDate date]] == NSOrderedDescending) {
        [self.datePicker setDate:[NSDate date] animated:YES];
    }
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *minimumDateString = [NSString stringWithFormat:@"%@%@", kMinimumBirthdayYear, [currentDateString substringFromIndex:4]];
    NSDate *minimumDate = [dateFormatter dateFromString:minimumDateString];
    if ([self.datePicker.date compare:minimumDate] == NSOrderedAscending) {
        [self.datePicker setDate:minimumDate animated:YES];
    }
}

- (void)updateGenderButtonsWithTag:(NSInteger)tag
{
    [self.genderButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *genderButton = (UIButton *)obj;
        genderButton.selected = tag == genderButton.tag ? YES : NO;
    }];
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    if (self.hasShowPickerView) {
        [self didTapOnBirthdayButton:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
