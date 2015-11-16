//
//  MultiThreadViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/11/11.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "MultiThreadViewController.h"
#import <Masonry.h>

NSLock *lock;

@interface MultiThreadViewController ()
@property (nonatomic, strong) UIButton *myNSThreadButton;               //NSThread按钮
@property (nonatomic, strong) UIButton *myNSThreadWithNSLockButton;     //使用线程锁NSLock的NSThread按钮
@property (nonatomic, strong) UIButton *myNSOperationButton;            //NSOperation按钮
@property (nonatomic, strong) UIButton *myGCDButton;                    //GCD按钮



@property (nonatomic, strong) NSThread *myThread;
@end




@implementation MultiThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多线程";
    self.view.backgroundColor = VIEW_NORMAL_BG_COLOR;
    
    
    
#pragma mark -- NSThread按钮 --
    _myNSThreadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [_myNSThreadButton setTitle:@"按钮(NSThread)" forState:UIControlStateNormal];
    [_myNSThreadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myNSThreadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateFocused];
    [_myNSThreadButton setBackgroundColor:[UIColor redColor]];
    [_myNSThreadButton addTarget:self action:@selector(threadBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_myNSThreadButton];
    [_myNSThreadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
#pragma mark -- NSOperation按钮 --
    _myNSOperationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [_myNSOperationButton setTitle:@"按钮(NSOperation)" forState:UIControlStateNormal];
    [_myNSOperationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myNSOperationButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateFocused];
    [_myNSOperationButton setBackgroundColor:[UIColor redColor]];
    [_myNSOperationButton addTarget:self action:@selector(operationBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_myNSOperationButton];
    [_myNSOperationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myNSThreadButton.mas_bottom).offset(50);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
#pragma mark -- GCD按钮 --
    _myGCDButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [_myGCDButton setTitle:@"按钮(GCD)" forState:UIControlStateNormal];
    [_myGCDButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myGCDButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateFocused];
    [_myGCDButton setBackgroundColor:[UIColor redColor]];
    [_myGCDButton addTarget:self action:@selector(gcdBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_myGCDButton];
    [_myGCDButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myNSOperationButton.mas_bottom).offset(50);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];
    
    
    
#pragma mark -- NSThread With NSLock 按钮 --
    _myNSThreadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [_myNSThreadButton setTitle:@"按钮(NSThread With NSLock)" forState:UIControlStateNormal];
    [_myNSThreadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_myNSThreadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateFocused];
    [_myNSThreadButton setBackgroundColor:[UIColor redColor]];
    [_myNSThreadButton addTarget:self action:@selector(threadWithLockBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_myNSThreadButton];
    [_myNSThreadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myGCDButton.mas_bottom).offset(50);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(30);
        make.centerX.equalTo(self.view);
    }];

    
    
    
    
}







/**
    NSThread按钮点击事件
    NSThread适合执行长时间的任务，
 */
- (void) threadBtnAction {
    
    //这两种使用isMainThread的方式都是可以的
    NSLog(@"\nisMainThread = %@", [[NSThread currentThread] isMainThread] ? @"YES" : @"NO");
    NSLog(@"\nisMainThread = %@", [NSThread isMainThread] ? @"YES" : @"NO");
    //判断App是否多线程应用程序
    NSLog(@"\nisMultiThreaded = %@", [NSThread isMultiThreaded] ? @"YES" : @"NO");
    
    
    _myThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadFunction) object:nil];
    [_myThread setThreadPriority:0.8];          //设置线程优先级，取值范围[0.0, 1.0]，1.0为最高优先级
    _myThread.name = @"NSThread测试线程";
    [_myThread start];
    for (int i = 0; i < 30; i++) {
        NSLog(@"main - %d",i);
    }
    
    
    
    //另外一种发起线程的方式
//    [NSThread detachNewThreadSelector:@selector(threadFunction) toTarget:self withObject:nil];          //直接启动
    
}


/**
    NSThread执行方法
 */
- (void) threadFunction {
    for (int i = 0; i < 30; i++) {
        NSLog(@"child - %d",i);
    }
    
    //不知道有什么用
    NSLog(@"\ncallStackReturnAddresses = %@", [NSThread callStackReturnAddresses]);
    NSLog(@"\ncallStackSymbols = %@", [NSThread callStackSymbols]);
    
    
    
    //线程属性
    NSLog(@"\nthreadDictionary = %@",[[NSThread currentThread] threadDictionary]);      //用来存储线程中用到的数据
    NSLog(@"\nname = %@",[[NSThread currentThread] name]);                  //线程名称，可以用此属性判断是哪个线程
    NSLog(@"\nstackSize = %lu",[[NSThread currentThread] stackSize]);       //4KB的倍数
    
    
    
    //线程优先级
    NSLog(@"\nthreadPriority = %f",[[NSThread currentThread] threadPriority]);      //返回当前线程的优先级,默认0.5,这里的返回值可能会和设置的有细微的差别
    
    
    
    //线程状态
    NSLog(@"\nisMultiThreaded = %@", [NSThread isMultiThreaded] ? @"YES" : @"NO");
    NSLog(@"\nisMainThread = %@", [[NSThread currentThread] isMainThread] ? @"YES" : @"NO");
    NSLog(@"\nmainThread = %@", [NSThread mainThread]);
    NSLog(@"\ncurrentThread = %@", [NSThread currentThread]);
    NSLog(@"\ncurrentThread.cancelled = %@", [NSThread currentThread].cancelled ? @"YES" : @"NO");
    NSLog(@"\ncurrentThread.finished = %@", [NSThread currentThread].finished ? @"YES" : @"NO");
    NSLog(@"\ncurrentThread.executing = %@", [NSThread currentThread].executing ? @"YES" : @"NO");
    [NSThread exit];        //exit方法执行后，线程立即结束，故而后续的方法都不会执行
    //下边的方法都不会执行，因为exit后线程立即结束
    NSLog(@"\ncurrentThread.cancelled = %@", [NSThread currentThread].cancelled ? @"YES" : @"NO");
    NSLog(@"\ncurrentThread.finished = %@", [NSThread currentThread].finished ? @"YES" : @"NO");
    NSLog(@"\ncurrentThread.executing = %@", [NSThread currentThread].executing ? @"YES" : @"NO");
}




/**
    NSOperation按钮点击事件
 */
- (void) operationBtnAction {
//    NSOperation
    
    
}




/**
    GCD按钮点击事件
 
 
     GCD就是为了在“多核”上使用多线程技术
     1> 要使用GCD，所有的方法都是dispatch开头的
     2> 名词解释
     global  全局
     queue   队列
     async   异步
     sync    同步
 
 */
- (void) gcdBtnAction {
    
    
}





/**
    NSThread With NSLock
 
 
    正常的输出是：该方法中的两个字符串是成对出现的，不会被threadWithLockFunction中的输出打断
 */
- (void) threadWithLockBtnAction {
    int x;
    lock = [[NSLock alloc] init];
    [NSThread detachNewThreadSelector:@selector(threadWithLockFunction) toTarget:self withObject:nil];
    for(x=0;x<50;++x) {
        [lock lock];
        printf("Main thread says x is %i\n",x);
        usleep(10000);
        printf("Main thread lets go\n",x);
        [lock unlock];
        usleep(100);
    }
}





/**
    NSThread With NSLock 调用方法
 */
- (void) threadWithLockFunction {
    int x;
    for(x=0;x<50;++x) {
        [lock lock];
        printf("Object Thread says x is %i\n",x);
        usleep(1);
        [lock unlock];
    }
}




























@end
