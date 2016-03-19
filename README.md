# HYSideCatagory

#####导读

左右侧滑是App开发中非常常见的功能,目前大部分App都有实现这个功能.

为了节省时间,提高开发效率,笔者对左右侧滑功能写了自己的一个分类.代码十分轻简,接口简单好用.

简单介绍一下这个侧滑的使用

1. 设置侧滑出来的view,view的宽高,则是滑出view的尺寸.
2. 设置侧滑方向,控制滑出方向.		
3. 设置侧滑动画的时间.
4. isSide滑出状态,根据这个值调用sideAnimateWithDuration:,从而外界可以控制view的滑出和隐藏.


######简书<http://www.jianshu.com/p/53bc00aa47d7>
---

* ##### 看一下UIViewController+Side分类的API接口

		
		
		@interface UIViewController (Side)
		
		/**     侧滑出来的View   */
		@property (weak,nonatomic) UIView * sideView;
		
		/**    侧滑的方向,也决定了sideView是在mainPanelView 的左边还是右边    */
		@property (assign,nonatomic) HYSideDirection HYSideDirectionType;
		/**    滑出状态 */
		@property (assign,nonatomic) BOOL  isSide;
		
		/**     侧滑并设置侧滑动画时间      */
		- (void)sideAnimateWithDuration:(NSTimeInterval)duration;
		
		@end
接口是不是很简单,欢迎大家下载试用.好用不要忘记star哦

###### 效果图如下

![1.gif](http://upload-images.jianshu.io/upload_images/1338042-c704015fa33c2a05.gif?imageMogr2/auto-orient/strip)
---
![2.gif](http://upload-images.jianshu.io/upload_images/1338042-580bd91e4ad6d22e.gif?imageMogr2/auto-orient/strip)
