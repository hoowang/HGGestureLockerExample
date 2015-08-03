//
//  HGGestureLockerView.m
//  HGGestureLockerExample
//
//  Created by hoo on 15-7-9.
//  Copyright (c) 2015年 hoowang. All rights reserved.
//

#import "HGGestureLockerView.h"
#import "HGCircleView.h"

@interface HGGestureLockerView()

/** 圆点数组 */
@property (strong, nonatomic) NSMutableArray* circleViews;

/** 最后一个点 用于连接*/
@property (assign, nonatomic) CGPoint curlastPoint;
@end

@implementation HGGestureLockerView

static const NSUInteger COL_COUNT = 3;
static const NSUInteger ROW_COUNT = 3;
static const CGFloat    circleWH = 74.0f;
static const CGFloat    topMargin = 200.0f;

- (NSMutableArray *)circleViews{
    if (_circleViews) {
        return _circleViews;
    }
    
    _circleViews = [NSMutableArray array];
    return _circleViews;
}

+ (instancetype)gestureLocker{
    HGGestureLockerView* gestureLocker = [self new];
    return gestureLocker;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self createButtons];
    return self;
}

- (void)createButtons{
    for (NSUInteger i = 0; i < COL_COUNT * ROW_COUNT; ++i) {
        HGCircleView* circleView = [HGCircleView circleView];
        [self addSubview:circleView];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat margin = (self.frame.size.width - (COL_COUNT * circleWH)) / (COL_COUNT + 1);
    
    for (NSUInteger i = 0, circleIdx = 0; i != ROW_COUNT; ++i){
        for (NSUInteger j = 0; j < COL_COUNT; ++j, ++circleIdx) {
            x  = i * (circleWH  + margin)  + margin;
            y  = topMargin + j * (circleWH + margin);
            [self.subviews[circleIdx] setFrame:CGRectMake(x, y, circleWH, circleWH)];
        }
    }
}

- (CGPoint)touchPoint:(NSSet*)touches{
    UITouch* touch = [touches anyObject];
    return [touch locationInView:touch.view];
}

- (HGCircleView*)circleViewInPoint:(CGPoint)point
{
    for (HGCircleView* view in self.subviews) {
        if (CGRectContainsPoint(view.frame, point)) {
            return view;
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearLastSelected];
    self.curlastPoint = CGPointMake(-10.0f, -10.0f);
    CGPoint point = [self touchPoint:touches];
    HGCircleView* circleView = [self circleViewInPoint:point];
    if (circleView) {
        if (![circleView isSelected]) {
            
            [circleView setSelected:YES];
            [self.circleViews addObject:circleView];
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self touchPoint:touches];
    HGCircleView* circleView = [self circleViewInPoint:point];
    if (circleView && ![circleView isSelected]) {
        [circleView setSelected:YES];
        [self.circleViews addObject:circleView];
    }
    else
    {
         self.curlastPoint = point;
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [self touchPoint:touches];
    HGCircleView* circleView = [self circleViewInPoint:point];
    if (circleView) {
            if (![circleView isSelected]) {
            [circleView setSelected:YES];
            [self.circleViews addObject:circleView];
        }
    }
    
    [self notifyDelegate];
    [self clearLastSelected];

}

- (void)clearLastSelected{
    [self.circleViews makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    [self.circleViews removeAllObjects];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIImage* backgroundImage = [UIImage imageNamed:@"Home_refresh_bg"];
    [backgroundImage drawInRect:rect];
    if (0 == self.circleViews.count) {
        return;
    }
    
    UIBezierPath* bezierPath = [UIBezierPath new];
    [bezierPath moveToPoint: [[self.circleViews firstObject] center]];
    for (NSUInteger i = 1; i < self.circleViews.count; ++i) {
        [bezierPath addLineToPoint:[[self.circleViews objectAtIndex:i] center]];
    }
    
    if (NO == CGPointEqualToPoint(self.curlastPoint, CGPointMake(-10.0f, -10.0f))) {
        [bezierPath addLineToPoint:self.curlastPoint];
    }
    // 绘图
    bezierPath.lineWidth = 8;
    bezierPath.lineJoinStyle = kCGLineJoinBevel;
    [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5] set];
    
    [bezierPath stroke];
}

- (NSString*)generatePassword
{
    NSMutableString* password = [NSMutableString string];
    for (HGGestureLockerView* circleView in self.circleViews) {
        [password appendString:NSStringFromCGPoint(circleView.center)];
    }
    
    return password;
}

- (void)notifyDelegate{
    
    if ([self.delegate respondsToSelector:@selector(locker:didSetFinished:)]) {
        [self.delegate locker:self didSetFinished:[self generatePassword]];
    }
}
@end
