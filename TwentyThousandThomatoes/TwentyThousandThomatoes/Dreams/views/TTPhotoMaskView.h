//
//  TTPhotoMaskView.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-24.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTPhotoMaskViewDelegate <NSObject>

- (void)maskCircleRectChangedTo:(CGRect) rect;

@end

@interface TTPhotoMaskView : UIView

@property (nonatomic, weak) id <TTPhotoMaskViewDelegate> delegate;

@end
