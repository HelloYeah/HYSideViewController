//
//  HYSideViewController.h
//  sideTest
//
//  Created by Sekorm on 16/8/15.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import <UIKit/UIKit.h>

//滑动方向
typedef enum{
    HYSideDirectionRight,
    HYSideDirectionLeft
} HYSideDirection;

@interface HYSideViewController : UIViewController
/** 滑出状态 */
@property (assign,nonatomic) BOOL isSide;
/** 侧滑并设置侧滑动画时间 */
- (void)sideAnimateDuration:(NSTimeInterval)duration SideDirection:(HYSideDirection)sideDirectionType;
/** 设置侧滑控制器 侧滑方向 */
//- (void)setSideVC:(UIViewController *)sideVC SideDirection:(HYSideDirection)sideDirectionType;

- (void)setLeftSideVC:(UIViewController *)leftSideVC;

- (void)setRightSideVC:(UIViewController *)rightSideVC;
@end
