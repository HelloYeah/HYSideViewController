//
//  OneViewController.m
//  sideTest
//
//  Created by Sekorm on 16/8/16.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "OneViewController.h"
#import "LeftSideVC.h"
#import "RightSideVC.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置向右侧滑
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"向右侧滑" style:UIBarButtonItemStylePlain target:self action:@selector(rightSide)];
    LeftSideVC * vc1 = [[LeftSideVC alloc]init];
    vc1.view.frame = CGRectMake(0, 0, 250, 0);
    //设置左侧的控制器
    [self setLeftSideVC:vc1];
    __weak typeof(self) weakSelf = self;
    vc1.exitLeftSideblock = ^{
        [weakSelf rightSide];
    };
}


- (void)rightSide{
    
    [self sideAnimateDuration:0.25 SideDirection:HYSideDirectionRight];
}

@end
