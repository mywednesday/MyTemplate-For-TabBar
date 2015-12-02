//
//  UIBarButtonItem+CLExtenstion.m
//  dsb
//
//  Created by 刘昶 on 15/5/11.
//  Copyright (c) 2015年 tpg. All rights reserved.
//

#import "UIBarButtonItem+CLExtenstion.h"

@implementation UIBarButtonItem (CLExtenstion)
+(instancetype)cl_barButtonWithImageNameNormal:(NSString *)normal highlight:(NSString *)highlight target:(id)target action:(SEL)action{
    
    return [self cl_barButtonWithImageNameNormal:normal imageEdgeInset:UIEdgeInsetsZero highlight:highlight target:target action:action];
}
+(instancetype)cl_barButtonWithImageNameNormal:(NSString *)normal
                                imageEdgeInset:(UIEdgeInsets)insets
                                     highlight:(NSString *)highlight
                                        target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 44)];
    btn.imageView.contentMode = UIViewContentModeCenter;
    [btn setImage:[UIImage imageNamed:normal] forState: UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = insets;

    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}
+(instancetype)cl_barBackButtonWithTarget:(id)target action:(SEL)action{
    return [self cl_barButtonWithImageNameNormal:@"navigationbar_back_normal" highlight:@"navigationbar_back_highlight" target:target action:action];
}

+(instancetype)cl_barButtonWithImageNormal:(UIImage *)normal highlight:(UIImage *)highlight frame:(CGRect) frame tintColor:(UIColor *)tintColor target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    if (normal) {
        [btn setImage:normal forState:UIControlStateNormal];
    }
    if (highlight) {
        [btn setImage:normal forState:UIControlStateHighlighted];
    }
    if (tintColor) {
        btn.tintColor = tintColor;
    }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}
@end
