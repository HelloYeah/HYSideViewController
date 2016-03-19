//
//  UIViewController+Side.m
//  sideTest
//
//  Created by HelloYeah on 16/3/18.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "UIViewController+Side.h"
#import <objc/runtime.h>
//导航条高度
const  CGFloat HYNavigationBarHeight = 64;

@implementation UIViewController (Side)

static UIView * _mainView;

#pragma mark - 通过运行时动态添加属性

//定义关联的Key
static const char * sideViewKey = "sideView";

- (void)setSideView:(UIView *)sideView{
    
    [[UIApplication sharedApplication].keyWindow addSubview:sideView];
    
    objc_setAssociatedObject(self, sideViewKey, sideView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    _mainView = self.navigationController?self.navigationController.view:self.view;
    
}

- (UIView *)sideView{
    return  objc_getAssociatedObject(self, sideViewKey);
}

- (HYSideDirection)HYSideDirectionType{
    
    return _HYSideDirectionType;
}

//侧滑方向
static HYSideDirection _HYSideDirectionType;
//侧滑出来的宽度
static CGFloat _sideWidth;
//目前是否已经滑出
static bool _isSide;

- (void)setHYSideDirectionType:(HYSideDirection)HYSideDirectionType{
    
    _HYSideDirectionType = HYSideDirectionType;
    
    CGRect rect = self.sideView.bounds;
    
    
    if (HYSideDirectionType == HYSideDirectionRight) {
        
        //右滑,滑动距离
        _sideWidth = rect.size.width;
        
        //右滑,则sideView被添加到view左边
        self.sideView.frame = CGRectMake(- rect.size.width, 0, rect.size.width, [UIScreen mainScreen].bounds.size.height);
    }else{
        
        //左滑,滑动距离
        _sideWidth = -rect.size.width;
        //左滑,则sideView被添加到view右边
        self.sideView.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width , 0 , rect.size.width, rect.size.height);
    }
    
}

- (void)sideAnimateWithDuration:(NSTimeInterval)duration{
    
    if (_isSide) {
        _isSide = NO;
        [self hideSideViewWithDuration:(NSTimeInterval)duration];
        return;
    }
   _isSide = YES;
    
    
    if (self.HYSideDirectionType == HYSideDirectionLeft	 ) {
        
        //左滑动画
        [UIView animateWithDuration:duration animations:^{
            
            _mainView.transform = CGAffineTransformMakeTranslation(-_sideWidth, 0);
            
            self.sideView.transform = CGAffineTransformMakeTranslation(-_sideWidth, 0);
        }];
        
    }else{
        
        //右滑动画
        [UIView animateWithDuration:duration animations:^{
            
            _mainView.transform = CGAffineTransformMakeTranslation(_sideWidth, 0);;
            
            self.sideView.transform = CGAffineTransformMakeTranslation(_sideWidth, 0);
        }];
    }
}

//侧滑时间
- (void)hideSideViewWithDuration:(NSTimeInterval)duration{
    
    [UIView animateWithDuration:duration animations:^{
        _mainView.transform = CGAffineTransformIdentity;
        self.sideView.transform = CGAffineTransformIdentity;
    }];
}



@end
