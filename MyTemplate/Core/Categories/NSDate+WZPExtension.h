//
//  NSDate+WZPExtension.h
//  MyTemplate
//
//  Created by qnsoft on 15/12/14.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WZPExtension)


/**
    change interval to "mm:ss" Format NSString, interval's unit is second
 */
- (NSString *) timeIntervalTo_mmss_Format: (NSTimeInterval) interval;

/**
    change interval to "HH:mm:ss" Format NSString, interval's unit is second
 */
- (NSString *) timeIntervalTo_HHmmss_Format: (NSTimeInterval) interval;
    
    
    
@end
