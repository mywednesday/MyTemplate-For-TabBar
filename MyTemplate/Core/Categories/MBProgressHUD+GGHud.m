//
//  MBProgressHUD+GGHud.m
//  QNGG
//
//  Created by 刘昶 on 15/7/20.
//  Copyright (c) 2015年 luxy. All rights reserved.
//

#import "MBProgressHUD+GGHud.h"

@implementation MBProgressHUD (GGHud)
+(void)showTextHud:(NSString *)text inView:(UIView *)view time:(NSTimeInterval)time{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:time];
}
@end
