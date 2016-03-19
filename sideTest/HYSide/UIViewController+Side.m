//
//  UIViewController+Side.m
//  sideTest
//
//  Created by HelloYeah on 16/3/18.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "UIViewController+Side.h"

const  CGFloat HYNavigationBarHeight = 64;

@implementation UIViewController (Side)

static UIView * _sideView;

static UIView * _mainView;


- (void)setSideView:(UIView *)sideView{
    
    [[UIApplication sharedApplication].keyWindow addSubview:sideView];
    
    _sideView = sideView;
    
    _mainView = self.navigationController?self.navigationController.view:self.view;
 
}

- (UIView *)sideView{
    return _sideView;
}

- (HYSideDirection)HYSideDirectionType{
    
    return _HYSideDirectionType;
}

static HYSideDirection _HYSideDirectionType;
static CGFloat _sideWidth;
static bool _isSide;

- (void)setHYSideDirectionType:(HYSideDirection)HYSideDirectionType{
    
    _HYSideDirectionType = HYSideDirectionType;
    
    CGRect rect = _sideView.bounds;
    
    
    if (HYSideDirectionType == HYSideDirectionRight) {
        
        //右滑,滑动距离
        _sideWidth = rect.size.width;
        
        //右滑,则sideView被添加到view左边
        _sideView.frame = CGRectMake(- rect.size.width, 0, rect.size.width, [UIScreen mainScreen].bounds.size.height);
    }else{
        
        //左滑,滑动距离
        _sideWidth = -rect.size.width;
        //左滑,则sideView被添加到view右边
        _sideView.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width , 0 , rect.size.width, rect.size.height);
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
            
            _sideView.transform = CGAffineTransformMakeTranslation(-_sideWidth, 0);
        }];
        
    }else{
        
        //右滑动画
        [UIView animateWithDuration:duration animations:^{
            
            _mainView.transform = CGAffineTransformMakeTranslation(_sideWidth, 0);;
            
            _sideView.transform = CGAffineTransformMakeTranslation(_sideWidth, 0);
        }];
    }
}

- (void)hideSideViewWithDuration:(NSTimeInterval)duration{
    
    [UIView animateWithDuration:duration animations:^{
        
        _mainView.transform = CGAffineTransformIdentity;
        _sideView.transform = CGAffineTransformIdentity;
    }];
}



@end
