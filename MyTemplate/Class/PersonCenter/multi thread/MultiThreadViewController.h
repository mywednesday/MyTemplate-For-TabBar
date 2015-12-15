//
//  MultiThreadViewController.h
//  MyTemplate
//
//  Created by qnsoft on 15/11/11.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "BaseVC.h"


/*
 http://www.cnblogs.com/qingche/p/3496190.html
 1.iOS的三种多线程技术
 1.NSThread 每个NSThread对象对应一个线程，量级较轻（真正的多线程）
 2.以下两点是苹果专门开发的“并发”技术，使得程序员可以不再去关心线程的具体使用问题
 ØNSOperation/NSOperationQueue 面向对象的线程技术
 ØGCD —— Grand Central Dispatch（派发） 是基于C语言的框架，可以充分利用多核，是苹果推荐使用的多线程技术
 
 
 以上这三种编程方式从上到下，抽象度层次是从低到高的，抽象度越高的使用越简单，也是Apple最推荐使用的，在项目中很多框架技术分别使用了不同多线程技术。
 
 
 
 2.三种多线程技术的对比
 •NSThread:
 –优点：NSThread 比其他两个轻量级，使用简单
 –缺点：需要自己管理线程的生命周期、线程同步、加锁、睡眠以及唤醒等。线程同步对数据的加锁会有一定的系统开销
 
 •NSOperation：
 –不需要关心线程管理，数据同步的事情，可以把精力放在自己需要执行的操作上
 –NSOperation是面向对象的
 
 •GCD：
 –Grand Central Dispatch是由苹果开发的一个多核编程的解决方案。iOS4.0+才能使用，是替代NSThread， NSOperation的高效和强大的技术
 –GCD是基于C语言的
 */
@interface MultiThreadViewController : BaseVC

@end
