//
//  NSDate+WZPExtension.m
//  MyTemplate
//
//  Created by qnsoft on 15/12/14.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "NSDate+WZPExtension.h"




@implementation NSDate (WZPExtension)


- (NSString *) timeIntervalTo_mmss_Format: (NSTimeInterval) interval {
    NSString *timerStr = [NSString stringWithFormat:@"%02li:%02li",
                               lround(floor(interval / 60.)) % 60,
                               lround(floor(interval)) % 60];
    
    
    return timerStr;
}



- (NSString *) timeIntervalTo_HHmmss_Format: (NSTimeInterval) interval {
    NSString *timerStr = [NSString stringWithFormat:@"%02li:%02li:%02li",
                               lround(floor(interval / 3600.)) % 60,
                               lround(floor(interval / 60.)) % 60,
                               lround(floor(interval)) % 60];
    
    
    return timerStr;
}
@end
