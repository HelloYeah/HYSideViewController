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
/** 侧滑并设置侧滑动画时间 */
- (void)sideAnimateDuration:(NSTimeInterval)duration SideDirection:(HYSideDirection)sideDirectionType;
/** 设置左侧的控制器 */
- (void)setLeftSideVC:(UIViewController *)leftSideVC;
/** 设置右侧的控制器 */
- (void)setRightSideVC:(UIViewController *)rightSideVC;
@end
