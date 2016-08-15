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

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    self.sideView.hidden = YES;
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
        NSLog(@"%@--%f",NSStringFromCGPoint(point),(self.view.transform.tx));
        if (!self.isSide) {
            if(_sideDirectionType == HYSideDirectionRight && point.x >= 0 && translation.x < self.sideView.bounds.size.width && translation.x >= 0){
                self.sideView.hidden = NO;
                [self sideDistance:translation.x];
            }
        }else {
            if(_sideDirectionType == HYSideDirectionRight && point.x >= 0  && translation.x <= 0){
                self.sideView.hidden = NO;
                [self sideDistance:translation.x];
            }
            
        }
        
        
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        CGPoint point = [self.view convertPoint:self.view.frame.origin toView:[UIApplication sharedApplication].keyWindow];
        NSLog(@"%@--%f",NSStringFromCGPoint(point),(self.view.transform.tx));
        if(_sideDirectionType == HYSideDirectionRight && point.x >= 0 && point.x > [UIScreen mainScreen].bounds.size.width * 0.5){
//            self.sideView.hidden = NO;
            [self sideDistance:self.sideView.bounds.size.width];
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            self.isSide = YES;
        }else{
            [UIView animateWithDuration:0.25 animations:^{
                [self sideDistance:0];
            }];
        }
    }
}

- (void)sideAnimateDuration:(NSTimeInterval)duration{
    
    if([UIApplication sharedApplication].statusBarStyle == UIStatusBarStyleDefault){
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
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
