//
//  ProDelegateSecondViewController.h
//  MyTemplate
//
//  Created by qnsoft on 15/10/21.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyBaseViewController.h"

//定义一个Block
typedef void (^StrBlock) (NSString *str);


//定义数据传递类型
typedef NS_ENUM(NSInteger, DataPassWay) {
    DataPassWayByDeleagate = 0,
    DataPassWayByNotification = 1,
    DataPassWayByBlock = 3,
    DataPassWayByNSUserDefault = 4,
    DataPassWayBySingleton = 5,
    DataPassWayByProperty = 6
};





@protocol ProDelegateSecondVCDelegate <NSObject>
@required
- (void) sendDataFrom_2_To_1:(NSString *)fetchString;
@optional
//
@end







@interface ProDelegateSecondViewController : MyBaseViewController


@property (nonatomic,strong) NSString *myFirstVCString;         //第一个页面的数据


//设置代理(为防止循环引用，此处采用了weak)
@property (nonatomic,weak) id<ProDelegateSecondVCDelegate> delegate;          //一定要将具体实现了委托方法的对象赋值给，这里的delegate
@property (nonatomic,assign) DataPassWay Page_1_To_2_DataPassWay;               //页面1向页面2的传值方式


@property (nonatomic, copy) StrBlock myBlock;
- (void) sendDataByBlock:(StrBlock) strBlock;
- (id) initwithBlock:(StrBlock) str;


@end
