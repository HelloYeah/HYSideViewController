//
//  TwoViewController.m
//  sideTest
//
//  Created by Sekorm on 16/8/15.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "TwoViewController.h"
#import "SideVc.h"
#import "RightSideVC.h"

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"向左侧滑" style:UIBarButtonItemStylePlain target:self action:@selector(rightSide)];
    //创建侧滑出来的控制器
    SideVc * vc = [[SideVc alloc]init];
    //设置侧滑出来的View的宽度,小于屏幕宽度
    vc.view.frame = CGRectMake(0, 0, 250, 0);
    //设置左侧的控制器
    [self setLeftSideVC:vc];
    //侧滑控制器 - 退出侧滑状态的代码块
    __weak typeof(self) weakSelf = self;
    vc.exitLeftSideblock = ^{
        [weakSelf rightSide];
    };
    
    //设置向右侧滑
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"向右侧滑" style:UIBarButtonItemStylePlain target:self action:@selector(leftSide)];
    RightSideVC * vc1 = [[RightSideVC alloc]init];
    vc1.view.frame = CGRectMake(0, 0, 250, 0);
    [self setRightSideVC:vc1];
    vc1.exitRightSideblock = ^{
        [weakSelf leftSide];
    };
}

- (void)rightSide{
    
    [self sideAnimateDuration:0.25 SideDirection:HYSideDirectionRight];
}

- (void)leftSide{
    
    [self sideAnimateDuration:0.25 SideDirection:HYSideDirectionLeft];
}

@end
