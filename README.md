# HYSideViewController

#####导读

左右侧滑是App开发中非常常见的功能,目前大部分App都有实现这个功能.

为提高开发效率,笔者对左右侧滑功能进行了封装.代码简洁,思路清晰易懂,外界只需调用两个接口,即可实现左右侧滑功能!!!

####简书链接<http://www.jianshu.com/p/7e314fe9c403>

---
 #####简单介绍一下这个侧滑的使用

1-> 侧滑并设置侧滑动画时间
	
        /** 侧滑并设置侧滑动画时间 */
	- (void)sideAnimateDuration:(NSTimeInterval)duration SideDirection:(HYSideDirection)sideDirectionType;

2-> 设置侧滑控制器,可只实现一侧,也可以都实现

	/** 设置左侧的控制器 */
	- (void)setLeftSideVC:(UIViewController *)leftSideVC;
	/** 设置右侧的控制器 */
	- (void)setRightSideVC:(UIViewController *)rightSideVC;
  ---
####效果图 



![1.gif](http://upload-images.jianshu.io/upload_images/1338042-5a26ed427596500e.gif?imageMogr2/auto-orient/strip)

同时集成左滑和右滑

![2.gif](http://upload-images.jianshu.io/upload_images/1338042-5d34cc9ebd60c7cd.gif?imageMogr2/auto-orient/strip) 

---
####实现思路及主要代码详解

######思路简述
把将要侧滑出来的View添加到[UIApplication sharedApplication].keyWindow上,并用一个控制器来对这个View进行管理.如果是向右滑动,则添加到左侧.向右滑动时,将keyWindow上的所有子控件进行向右平移.我们想要的侧滑效果即可出来了.

######主要代码
1.外界通过调用setter方法,添加侧滑控制器


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
	    self.rightSideView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width , 0 , rect.size.width, [UIScreen mainScreen].bounds.size.height);
	}

2.外界调用侧滑接口,侧滑并设置侧滑动画时间.并相应的调整状态栏样式.

	- (void)sideAnimateDuration:(NSTimeInterval)duration SideDirection:(HYSideDirection)sideDirectionType{
	    
            //修改状态栏样式
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
	
	            [self hiddenSideView];
	        }];
	        return;
	    }
	    
	    self.isSide = YES;
	    if (sideDirectionType == HYSideDirectionLeft){
	        self.rightSideView.hidden = NO;
	    }else{
	        self.leftSideView.hidden = NO;
	    }
	    CGFloat _sideWidth = (sideDirectionType == HYSideDirectionRight) ? self.leftSideView.frame.size.width : - self.rightSideView.frame.size.width;
	    [UIView animateWithDuration:duration animations:^{
	        [self sideDistance:_sideWidth];
	    }];
	}

3.核心的代码是滑动手势的回调方法,滑动时,根据滑动方向,滑动距离两个条件做相应的事件处理.滑动停止时,同样根据滑动方向,滑动距离两个条件,来判断是否需要将View侧滑出来.

- 手势滑动时

![手势滑动.png](http://chuantu.biz/t5/28/1471396649x2031068758.png)


- 手势停止时
![手势停止.png](http://chuantu.biz/t5/28/1471396790x3340469684.png)





####简书链接<http://www.jianshu.com/p/7e314fe9c403>
