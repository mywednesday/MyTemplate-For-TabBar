//
//  ProDelegateSingleton.h
//  MyTemplate
//
//  Created by qnsoft on 15/10/22.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProDelegateSingleton : NSObject



+ (instancetype) shareProDelegateSingleton;

@property (nonatomic, strong) NSString *shareString;



@end
