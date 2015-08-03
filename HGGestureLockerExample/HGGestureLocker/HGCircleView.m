//
//  HGCircleView.m
//  HGGestureLockerExample
//
//  Created by hoo on 15-7-9.
//  Copyright (c) 2015年 hoowang. All rights reserved.
//

#import "HGCircleView.h"

@implementation HGCircleView

+ (instancetype)circleView{
    HGCircleView* circleView = [self new];
    return circleView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
    self.userInteractionEnabled = NO;
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
