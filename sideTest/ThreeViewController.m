//
//  ThreeViewController.m
//  sideTest
//
//  Created by Sekorm on 16/8/16.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "ThreeViewController.h"
#import "LeftSideVC.h"
#import "RightSideVC.h"
@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"向左侧滑" style:UIBarButtonItemStylePlain target:self action:@selector(leftSide)];
    //创建侧滑出来的控制器
    RightSideVC * vc = [[RightSideVC alloc]init];
    //设置侧滑出来的View的宽度,小于屏幕宽度
    vc.view.frame = CGRectMake(0, 0, 150, 0);
    //设置左侧的控制器
    [self setRightSideVC:vc];
    //侧滑控制器 - 退出侧滑状态的代码块
    __weak typeof(self) weakSelf = self;
    vc.exitRightSideblock = ^{
        [weakSelf leftSide];
    };

    
    //设置向右侧滑
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"向右侧滑" style:UIBarButtonItemStylePlain target:self action:@selector(rightSide)];
    LeftSideVC * vc1 = [[LeftSideVC alloc]init];
    vc1.view.frame = CGRectMake(0, 0, 250, 0);
    //设置左侧的控制器
    [self setLeftSideVC:vc1];
    vc1.exitLeftSideblock = ^{
        [weakSelf rightSide];
    };
}

- (void)leftSide{
    
    [self sideAnimateDuration:0.25 SideDirection:HYSideDirectionLeft];
}

- (void)rightSide{
    
    [self sideAnimateDuration:0.25 SideDirection:HYSideDirectionRight];
}


@end
