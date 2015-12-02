//
//  NSError+QNExtension.m
//  GGSJ
//
//  Created by 刘昶 on 15/11/20.
//  Copyright © 2015年 com.channelsoft. All rights reserved.
//

#import "NSError+QNExtension.h"

@implementation NSError (QNExtension)
-(NSString *)qn_codeStr{
    return [NSString stringWithFormat:@"%i",(int)self.code];
}
@end
