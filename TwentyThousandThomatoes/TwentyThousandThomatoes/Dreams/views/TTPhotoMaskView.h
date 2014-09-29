//
//  TTPhotoMaskView.h
//  TwentyThousandThomatoes
//
//  Created by lihux on 14-9-24.
//  Copyright (c) 2014年 lihux. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TTPhotoMaskViewMaskTypeCircle,
    TTPhotoMaskViewMaskTypeRectangle,
} TTPhotoMaskViewMaskType;

@protocol TTPhotoMaskViewDelegate <NSObject>

- (void)pickingFieldRectChangedTo:(CGRect) rect;

@end

@interface TTPhotoMaskView : UIView

@property (nonatomic, weak) id <TTPhotoMaskViewDelegate> delegate;
@property (nonatomic, assign) TTPhotoMaskViewMaskType maskType;

@end
