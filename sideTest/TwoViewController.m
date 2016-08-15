//
//  TwoViewController.m
//  sideTest
//
//  Created by Sekorm on 16/8/15.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "TwoViewController.h"
#import "SideVc.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"向右侧滑" style:UIBarButtonItemStylePlain target:self action:@selector(side)];
    
    //1.创建侧滑出来的控制机器
    SideVc * vc = [[SideVc alloc]init];
    //2.设置侧滑出来的View的宽度,小于屏幕宽度
    vc.view.frame = CGRectMake(0, 0, 250, 0);
    //3.添加侧滑出来的控制器 以及 侧滑方向
    [self setSideVC:vc SideDirection:HYSideDirectionRight];
    //4.侧滑控制器 - 退出侧滑状态的代码块
    __weak typeof(self) weakSelf = self;
    vc.sideblock = ^{
        [weakSelf sideAnimateDuration:0.25];
    };
}


- (void)side{
    
 
    [self sideAnimateDuration:0.25];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.isSide) {
        [self side];
    }
}

@end
