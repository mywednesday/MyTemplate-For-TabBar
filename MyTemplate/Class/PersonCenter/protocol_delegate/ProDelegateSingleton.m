//
//  ProDelegateSingleton.m
//  MyTemplate
//
//  Created by qnsoft on 15/10/22.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "ProDelegateSingleton.h"

@implementation ProDelegateSingleton

+ (instancetype) shareProDelegateSingleton {
//    http://blog.csdn.net/ryantang03/article/details/8622415
    
    static ProDelegateSingleton *_shareSingleton = nil;
    dispatch_once_t oncePredicate;
    //线程安全
    dispatch_once(&oncePredicate, ^{
        _shareSingleton = [[ProDelegateSingleton alloc] init];
    });
    
    return _shareSingleton;
}




@end
