//
//  ringtSideVC.m
//  sideTest
//
//  Created by Sekorm on 16/8/16.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "RightSideVC.h"

@interface RightSideVC ()

@end

@implementation RightSideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.exitRightSideblock) {
        self.exitRightSideblock();
    }
}

@end
