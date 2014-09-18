//
//  TTPhotoCollectionViewCell.m
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-18.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import "TTPhotoCollectionViewCell.h"

@interface TTPhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@end

@implementation TTPhotoCollectionViewCell

- (void)setSelected:(BOOL)selected
{
    self.selectedButton.selected = selected;
}

@end
