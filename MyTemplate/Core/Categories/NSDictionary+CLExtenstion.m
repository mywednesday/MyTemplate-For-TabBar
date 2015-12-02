//
//  NSDictionary+CLExtenstion.m
//  QNGG
//
//  Created by 刘昶 on 15/11/9.
//  Copyright © 2015年 luxy. All rights reserved.
//

#import "NSDictionary+CLExtenstion.h"

@implementation NSDictionary (CLExtenstion)

-(NSInteger)cl_getIntegerValue:(NSString *)key{
    id value = [self objectForKey:key];
    if (value) {
        return [value integerValue];
    }else{
        return 0;
    }
}

-(NSString *)cl_returnCode{
    return [self objectForKey:@"returnCode"];
}
@end
