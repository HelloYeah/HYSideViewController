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

@property (nonatomic,strong) UIViewController * sideVC;
@end

@implementation HYSideViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hy_panGesture:)]];
}

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
    _sideVC = sideVC;
}

- (void)hy_panGesture:(UIPanGestureRecognizer *)pan{

    CGPoint translation = [pan translationInView:pan.view];
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [self.view convertPoint:self.view.frame.origin toView:[UIApplication sharedApplication].keyWindow];
        NSLog(@"%@",NSStringFromCGPoint(point));
        [self sideDistance:translation.x];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
//        self.view
    }
}

- (void)sideAnimateDuration:(NSTimeInterval)duration{
    
    if (self.isSide) {
        NSLog(@"是否被滑出");
        self.isSide = NO;
        [UIView animateWithDuration:duration animations:^{
            for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
                view.transform = CGAffineTransformIdentity;
            }
        }completion:^(BOOL finished) {
            self.sideView.hidden = YES;
        }];
        
        return;
    }
    
    self.isSide = YES;
    self.sideView.hidden = NO;
    CGFloat _sideWidth = (self.sideDirectionType == HYSideDirectionRight) ? self.sideView.frame.size.width : - self.sideView.frame.size.width;
    [UIView animateWithDuration:duration animations:^{
        [self sideDistance:_sideWidth];
    }];
}

- (void)sideDistance:(CGFloat)distance{

    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
        view.transform = CGAffineTransformMakeTranslation(distance, 0);
    }
}

@end
