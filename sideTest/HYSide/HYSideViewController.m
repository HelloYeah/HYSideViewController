//
//  HYSideViewController.m
//  sideTest
//
//  Created by Sekorm on 16/8/15.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "HYSideViewController.h"

@interface HYSideViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView * leftSideView; //左侧滑出的View
@property (nonatomic,strong) UIView * rightSideView; //右侧划出的View
@property (nonatomic,strong) UIViewController * leftSideVC; //左侧的控制器
@property (nonatomic,strong) UIViewController * rightSideVC; //右侧的控制器
@property (assign,nonatomic) HYSideDirection sideDirectionType; //侧滑的方向
@property (assign,nonatomic) BOOL isSide; //滑出状态
@end

@implementation HYSideViewController

#pragma mark - 生命周期方法
- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hy_panGesture:)]];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hy_tapGesture:)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    if (self.leftSideVC) {
        self.leftSideView.hidden = YES;
    }
    if (self.rightSideVC) {
        self.rightSideView.hidden = YES;
    }
}

#pragma mark - 内部方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return YES;
}
- (UIView *)leftSideView{
    
    return self.leftSideVC.view;
}

- (UIView *)rightSideView{
    
    return self.rightSideVC.view;
}

- (void)hy_tapGesture:(UITapGestureRecognizer *)tap{
    [self sideAnimateDuration:0.25 SideDirection:_sideDirectionType];
}

- (void)hy_panGesture:(UIPanGestureRecognizer *)pan{

    CGPoint translation = [pan translationInView:pan.view];
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        CGPoint point = [self.view convertPoint:self.view.frame.origin toView:[UIApplication sharedApplication].keyWindow];
        if (!self.isSide) {
            if(self.leftSideVC && point.x >= 0 && translation.x < self.leftSideView.bounds.size.width && translation.x >= 0){
                
                _sideDirectionType = HYSideDirectionLeft;
                self.leftSideView.hidden = NO;
                [self sideDistance:translation.x];
            }else if (self.rightSideVC && point.x <= 0 &&  - translation.x < self.rightSideView.bounds.size.width && translation.x <= 0){
                _sideDirectionType = HYSideDirectionRight;
                self.rightSideView.hidden = NO;
                [self sideDistance:translation.x];
            }
        }else {
            
            if(self.leftSideVC && point.x >= 0  && translation.x <= 0){
                _sideDirectionType = HYSideDirectionLeft;
                [self sideDistance:(self.leftSideView.bounds.size.width + translation.x)];
            }else if (self.rightSideVC && point.x <= 0 &&  translation.x >= 0){
                _sideDirectionType = HYSideDirectionRight;
                self.rightSideView.hidden = NO;
                [self sideDistance:(- self.rightSideView.bounds.size.width + translation.x)];
            }
        }
        
    }else if (pan.state == UIGestureRecognizerStateEnded) {
        
        CGPoint point = [self.view convertPoint:self.view.frame.origin toView:[UIApplication sharedApplication].keyWindow];
        
        if (_sideDirectionType != HYSideDirectionRight) {
            if(point.x >= 0 && point.x >= [UIScreen mainScreen].bounds.size.width * 0.5){
                
                [self sideDistance:self.rightSideView.bounds.size.width];
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                self.isSide = YES;
            }else{
                
                [UIView animateWithDuration:0.25 animations:^{
                    [self sideDistance:0];
                }];
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                self.isSide = NO;
            }
        }else{
            if( point.x <= 0 && -point.x >= [UIScreen mainScreen].bounds.size.width * 0.5){
                
                [self sideDistance:-self.leftSideView.bounds.size.width];
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
                self.isSide = YES;
            }else{
                
                [UIView animateWithDuration:0.25 animations:^{
                    [self sideDistance:0];
                }];
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                self.isSide = NO;
            }
        }
    }
}

- (void)sideDistance:(CGFloat)distance{
    
    for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
        view.transform = CGAffineTransformMakeTranslation(distance, 0);
    }
}

#pragma mark - 对外接口

- (void)sideAnimateDuration:(NSTimeInterval)duration SideDirection:(HYSideDirection)sideDirectionType{
    
    if([UIApplication sharedApplication].statusBarStyle == UIStatusBarStyleDefault){
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    if (self.isSide) {
        self.isSide = NO;
        [UIView animateWithDuration:duration animations:^{
            for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
                view.transform = CGAffineTransformIdentity;
            }
        }completion:^(BOOL finished) {

            if (sideDirectionType == HYSideDirectionLeft){
                self.leftSideView.hidden = YES;
            }else{
                self.rightSideView.hidden = YES;
            }
        }];
        return;
    }
    
    self.isSide = YES;
    if (sideDirectionType == HYSideDirectionLeft){
        self.leftSideView.hidden = NO;
    }else{
        self.rightSideView.hidden = NO;
    }
    CGFloat _sideWidth = (sideDirectionType == HYSideDirectionLeft) ? self.rightSideView.frame.size.width : - self.leftSideView.frame.size.width;
    [UIView animateWithDuration:duration animations:^{
        [self sideDistance:_sideWidth];
    }];
}

- (void)setLeftSideVC:(UIViewController *)leftSideVC{
    
    _leftSideVC = leftSideVC;
    [[UIApplication sharedApplication].keyWindow addSubview:self.leftSideView];
    CGRect rect = self.leftSideView.bounds;
    CGFloat sideWidth = self.leftSideView.bounds.size.width;
    sideWidth = rect.size.width;
    self.leftSideView.frame = CGRectMake(- rect.size.width, 0, rect.size.width, [UIScreen mainScreen].bounds.size.height);
}

- (void)setRightSideVC:(UIViewController *)rightSideVC{
    
    _rightSideVC = rightSideVC;
    [[UIApplication sharedApplication].keyWindow addSubview:self.rightSideView];
    CGRect rect = self.rightSideView.bounds;
    CGFloat sideWidth = self.rightSideView.bounds.size.width;
    sideWidth = rect.size.width;
    self.rightSideView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width , 0 , rect.size.width, [UIScreen mainScreen].bounds.size.height);;
}

@end
