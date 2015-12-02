//
//  MBProgressHUD+GGHud.h
//  QNGG
//
//  Created by 刘昶 on 15/7/20.
//  Copyright (c) 2015年 luxy. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (GGHud)
+(void)showTextHud:(NSString *)text inView:(UIView *)view time:(NSTimeInterval)time;
@end
