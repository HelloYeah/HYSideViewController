//
//  UIViewController+Side.h
//  sideTest
//
//  Created by HelloYeah on 16/3/18.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    HYSideDirectionRight,
    HYSideDirectionLeft
} HYSideDirection;

@interface UIViewController (Side)
/** 滑出状态 */
@property (assign,nonatomic) BOOL  isSide;
/** 侧滑并设置侧滑动画时间 */
- (void)sideAnimateDuration:(NSTimeInterval)duration;
/** 设置侧滑控制器 侧滑方向 */
- (void)setSideVC:(UIViewController *)sideVC SideDirection:(HYSideDirection)sideDirectionType;
@end
