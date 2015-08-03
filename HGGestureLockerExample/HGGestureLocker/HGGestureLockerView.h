//
//  HGGestureLockerView.h
//  HGGestureLockerExample
//
//  Created by hoo on 15-7-9.
//  Copyright (c) 2015年 hoowang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HGGestureLockerView;
@protocol HGGestureLockerViewDelegate <NSObject>

@optional
- (void)locker:(HGGestureLockerView*)lockerview didSetFinished:(NSString*)password;

@end

@interface HGGestureLockerView : UIView

+ (instancetype)gestureLocker;
/** 代理指针*/
@property (weak, nonatomic) id<HGGestureLockerViewDelegate> delegate;
@end
