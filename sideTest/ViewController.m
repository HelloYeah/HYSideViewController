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
    
    
    SideVc * vc = [[SideVc alloc]init];
    //设置侧滑的view
    self.sideView = vc.view;
    //侧滑的距离由侧滑的view的宽度决定
    vc.view.frame = CGRectMake(0, 0, 250, self.view.bounds.size.height);
    [self addChildViewController:vc];
    //设置侧滑view的block,什么时候隐藏侧滑的view可以由侧滑的控制器决定
    vc.sideblock = ^{
        [self side];
    };
    //侧滑的方向,向左边滑动
    self.HYSideDirectionType = HYSideDirectionLeft;
    
}

- (void)side{
    
    [self sideAnimateWithDuration:0.25];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.isSide) {
        [self side];
    }
}

@end
