//
//  UIViewController+Side.m
//  sideTest
//
//  Created by HelloYeah on 16/3/18.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "UIViewController+Side.h"
#import <objc/runtime.h>

@interface UIViewController (side)
/** 设置侧滑出来的View */
@property (weak,nonatomic) UIView * sideView;
/** 设置侧滑的方向,也决定了sideView是在mainPanelView 的左边还是右边 */
@property (assign,nonatomic) HYSideDirection sideDirectionType;
@end

@implementation UIViewController (Side)

#pragma mark - 通过运行时动态添加属性
#pragma mark  设置侧滑出来的View
//定义关联的Key
static const char * sideViewKey = "sideView";

//将需要侧滑出来的View添加到keyWindow上.
- (void)setSideView:(UIView *)sideView{
        
    [[UIApplication sharedApplication].keyWindow addSubview:sideView];
    
    objc_setAssociatedObject(self, sideViewKey, sideView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)sideView{
    return  objc_getAssociatedObject(self, sideViewKey);
}

#pragma mark  设置侧滑方向
static const char * sideDirectionTypeKey = "sideDirectionType";

- (HYSideDirection)sideDirectionType{
    
    return  [objc_getAssociatedObject(self, sideDirectionTypeKey) intValue];
}

//在设置好侧滑类型后,再设置需要侧滑出来View的frame
- (void)setSideDirectionType:(HYSideDirection)sideDirectionType{

    objc_setAssociatedObject(self, sideDirectionTypeKey, @(sideDirectionType), OBJC_ASSOCIATION_ASSIGN);
    
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

#pragma mark 侧滑状态
//定义关联的Key
static const char * isSideKey = "isSide";

- (BOOL)isSide{
    return  [objc_getAssociatedObject(self, isSideKey) integerValue];
}

- (void)setIsSide:(BOOL)isSide{
    
    objc_setAssociatedObject(self, isSideKey, @(isSide), OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - 对外的接口
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
        for (UIView * view in [UIApplication sharedApplication].keyWindow.subviews) {
            view.transform = CGAffineTransformMakeTranslation(_sideWidth, 0);
        }
    }];
}



- (void)setSideVC:(UIViewController *)sideVC SideDirection:(HYSideDirection)sideDirectionType{

    self.sideView = sideVC.view;
    self.sideDirectionType = sideDirectionType;
    [self addChildViewController:sideVC];
}

@end
