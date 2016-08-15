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

@interface UIViewController (side)
/**   设置侧滑出来的View   */
@property (weak,nonatomic) UIView * sideView;
/**    设置侧滑的方向,也决定了sideView是在mainPanelView 的左边还是右边    */
@property (assign,nonatomic) HYSideDirection sideDirectionType;
@end

@implementation UIViewController (Side)

//最开始的view,侧滑前展示的View
static UIView * _mainView;

#pragma mark - 通过运行时动态添加属性

//定义关联的Key
static const char * sideViewKey = "sideView";

//将需要侧滑出来的View添加到keyWindow上.
- (void)setSideView:(UIView *)sideView{
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:sideView];
    
    objc_setAssociatedObject(self, sideViewKey, sideView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (self.tabBarController) {
        _mainView = self.tabBarController.view;
    }else if(self.navigationController){
        _mainView = self.navigationController.view;
    }else{
        _mainView = self.view;
    }
}

- (UIView *)sideView{
    return  objc_getAssociatedObject(self, sideViewKey);
}


#pragma mark - 侧滑方向

static const char * sideDirectionTypeKey = "sideDirectionType";

- (HYSideDirection)sideDirectionType{
    
    return  [objc_getAssociatedObject(self, sideDirectionTypeKey) intValue];
}


//在设置好侧滑类型后,再设置需要侧滑出来View的frame
- (void)setSideDirectionType:(HYSideDirection)sideDirectionType{

    objc_setAssociatedObject(self, sideDirectionTypeKey, @(sideDirectionType), OBJC_ASSOCIATION_ASSIGN);
    
    CGRect rect = self.sideView.bounds;
    if (sideDirectionType == HYSideDirectionRight) {
    
        //右滑,滑动距离
        _sideWidth = rect.size.width;
        //右滑,则sideView被添加到view左边
        self.sideView.frame = CGRectMake(- rect.size.width, 0, rect.size.width, [UIScreen mainScreen].bounds.size.height);
    }else{
        
        //左滑,滑动距离
        _sideWidth = -rect.size.width;
        //左滑,则sideView被添加到view右边
        self.sideView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width , 0 , rect.size.width, [UIScreen mainScreen].bounds.size.height);
    }

}

#pragma mark - 是否侧滑
//定义关联的Key
static const char * isSideKey = "isSide";

- (BOOL)isSide{
    return  [objc_getAssociatedObject(self, isSideKey) integerValue];
}


- (void)setIsSide:(BOOL)isSide{
    
    objc_setAssociatedObject(self, isSideKey, @(isSide), OBJC_ASSOCIATION_ASSIGN);
}


//侧滑出来的宽度
static CGFloat _sideWidth;

- (void)sideAnimateWithDuration:(NSTimeInterval)duration{
    
    if (self.isSide) {
        NSLog(@"是否被滑出");
        self.isSide = NO;
        [self hideSideViewWithDuration:(NSTimeInterval)duration];
        return;
    }
    self.isSide = YES;
    

    [UIView animateWithDuration:duration animations:^{
        
        _mainView.transform = CGAffineTransformMakeTranslation(_sideWidth, 0);
        self.sideView.transform = CGAffineTransformMakeTranslation(_sideWidth, 0);
    }];
    
}

//侧滑时间
- (void)hideSideViewWithDuration:(NSTimeInterval)duration{
    
    [UIView animateWithDuration:duration animations:^{
        _mainView.transform = CGAffineTransformIdentity;
        self.sideView.transform = CGAffineTransformIdentity;
    }];
    
}

- (void)setSideVC:(UIViewController *)sideVC SideDirection:(HYSideDirection)sideDirectionType{

    self.sideView = sideVC.view;
    self.sideDirectionType = sideDirectionType;
    [self addChildViewController:sideVC];
}

@end
