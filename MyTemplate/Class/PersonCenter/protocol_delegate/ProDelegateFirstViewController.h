//
//  ProDelegateFirstViewController.h
//  MyTemplate
//
//  Created by qnsoft on 15/10/21.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "BaseVC.h"

@interface ProDelegateFirstViewController : BaseVC

@end


/**
    IOS页面间传值的方式（Delegate/NSNotification/Block/NSUserDefault/单例）
    http://blog.csdn.net/leikezhu1981/article/details/40018415
    实现了以下iOS页面间传值：
    1.委托delegate方式；                     注意委托对象的设置
        当然代理我们用起来更简单，因为太熟悉了，后一个控制器设置一个协议，设置一个delegate，
        在前一个控制器跳转到后一个控制器的时候，指定后一个控制器的代理为前一个控制器，然后前一个控制器遵守协议，
        再实现这个协议里的方法，在这个方法里会有后一个控制器传过来的数据。
 
    2.通知notification方式；                 实现通知方法的页面必须 初始化在前
        优势：可以在关系复杂的页面之间传值，异步模式
        劣势：此种方式的实现存在延迟
 
    3.block方式；
        到现在还是迷迷糊糊的，不过理解了比前两种方式要简单的多
        http://blog.csdn.net/mobanchengshuang/article/details/11751671
 
    4.NSUserDefault或者文件方式；
        NSUserDefault也是将数据存储到文件中，不过系统提供了完整的API
        优势：使用方便
        劣势：不适合存放图片等数据，不过可以通过自定义的文件方式弥补
 
    5.单例(Singleton)模式方式；
        此中方式多用于保存全局的用户信息
 
 
    6.通过设置属性(Property)，实现页面间传值
        这个是最简单的
 
 
 
 使用说明：一般在项目中出现逆向传值的时候就需要用到  代理(delegate)  、  block  或者  通知中心了
 */