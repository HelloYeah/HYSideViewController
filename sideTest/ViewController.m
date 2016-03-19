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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"侧滑" style:UIBarButtonItemStylePlain target:self action:@selector(side)];
    
    SideVc * vc = [[SideVc alloc]init];
    self.sideView = vc.view;
    vc.view.frame = CGRectMake(0, 0, 200, self.view.bounds.size.height);
      [self addChildViewController:vc];
    
  
    self.HYSideDirectionType = HYSideDirectionRight;
    
}

- (void)side{
    
    [self sideAnimateWithDuration:0.25];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self side];
}





@end
