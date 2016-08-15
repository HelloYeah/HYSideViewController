//
//  HYSideViewController.m
//  sideTest
//
//  Created by Sekorm on 16/8/15.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "HYSideViewController.h"

@interface HYSideViewController ()
/** 设置侧滑出来的View */
@property (weak,nonatomic) UIView * sideView;
/** 设置侧滑的方向,也决定了sideView是在mainPanelView 的左边还是右边 */
@property (assign,nonatomic) HYSideDirection sideDirectionType;
@end

@implementation HYSideViewController

- (void)setSideView:(UIView *)sideView{
    
    _sideView = sideView;
    [[UIApplication sharedApplication].keyWindow addSubview:sideView];
}

- (void)setSideDirectionType:(HYSideDirection)sideDirectionType{

    _sideDirectionType = sideDirectionType;
    CGRect rect = self.sideView.bounds;
    CGFloat _sideWidth = self.sideView.bounds.size.width;
    if (sideDirectionType == HYSideDirectionRight) {
        _sideWidth = rect.size.width;
        self.sideView.frame = CGRectMake(- rect.size.width, 0, rect.size.width, [UIScreen mainScreen].bounds.size.height);
    }else{
        _sideWidth = - rect.size.width;
        self.sideView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width , 0 , rect.size.width, [UIScreen mainScreen].bounds.size.height);
    }
}

- (void)setSideVC:(UIViewController *)sideVC SideDirection:(HYSideDirection)sideDirectionType{
    
    self.sideView = sideVC.view;
    self.sideDirectionType = sideDirectionType;
    [self addChildViewController:sideVC];
}

- (void)sideAnimateDuration:(NSTimeInterval)duration{
    
    if (self.isSide) {
        NSLog(@"是否被滑出");
        self.isSide = NO;
        [UIView animateWithDuration:duration animations:^{
            for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
                view.transform = CGAffineTransformIdentity;
            }
        }];
        return;
    }
    
    self.isSide = YES;
    CGFloat _sideWidth = (self.sideDirectionType == HYSideDirectionRight) ? self.sideView.frame.size.width : - self.sideView.frame.size.width;
    [UIView animateWithDuration:duration animations:^{
        for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
            view.transform = CGAffineTransformMakeTranslation(_sideWidth, 0);
        }
    }];
}

@end
