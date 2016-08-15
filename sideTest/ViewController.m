//
//  ViewController.m
//  sideTest
//
//  Created by HelloYeah on 16/3/18.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Side.h"
#import "SideVc.h"

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"侧滑" style:UIBarButtonItemStylePlain target:self action:@selector(side)];
    
    //1.创建侧滑出来的控制机器
    SideVc * vc = [[SideVc alloc]init];
    //2.设置侧滑出来的View的宽度,小于屏幕宽度
    vc.view.frame = CGRectMake(0, 0, 250, 0);
    //3.添加侧滑出来的控制器 以及 侧滑方向
    [self setSideVC:vc SideDirection:HYSideDirectionLeft];
    //4.侧滑控制器 - 退出侧滑状态的代码块
    __weak typeof(self) weakSelf = self;
    vc.sideblock = ^{
        [weakSelf sideAnimateDuration:0.25];
    };
}

- (void)side{
    
    [self sideAnimateDuration:0.25];
    if(self.navigationController.navigationBar.barStyle == UIBarStyleBlack){
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    }else{
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.isSide) {
        [self side];
    }
}

@end
