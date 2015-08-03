//
//  ViewController.m
//  HGGestureLockerExample
//
//  Created by hoo on 15-7-9.
//  Copyright (c) 2015年 hoowang. All rights reserved.
//

#import "ViewController.h"
#import "HGGestureLockerView.h"

@interface ViewController ()<HGGestureLockerViewDelegate>
/** 手势锁 */
@property (strong, nonatomic) HGGestureLockerView* lockerView;
@end

@implementation ViewController

- (void)loadView
{
    HGGestureLockerView* lockerView = [HGGestureLockerView gestureLocker];
    self.view = lockerView;
    lockerView.delegate = self;
    self.lockerView = lockerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    HGGestureLockerView* lockerView = [HGGestureLockerView gestureLocker];
//    lockerView.frame = self.view.bounds;
//    lockerView.delegate = self;
//    [self.view addSubview:lockerView];
}

- (void)locker:(HGGestureLockerView *)lockerview didSetFinished:(NSString *)password
{
    NSLog(@"生成密码是:%@", password);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
