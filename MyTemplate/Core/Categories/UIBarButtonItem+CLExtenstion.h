//
//  UIBarButtonItem+CLExtenstion.h
//  dsb
//
//  Created by 刘昶 on 15/5/11.
//  Copyright (c) 2015年 tpg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CLExtenstion)


+(instancetype)cl_barButtonWithImageNameNormal:(NSString *)normal highlight:(NSString *)highlight target:(id)target action:(SEL)action;
+(instancetype)cl_barButtonWithImageNameNormal:(NSString *)normal
                                imageEdgeInset:(UIEdgeInsets)insets
                                     highlight:(NSString *)highlight
                                        target:(id)target action:(SEL)action;
+(instancetype)cl_barBackButtonWithTarget:(id)target action:(SEL)action;

+(instancetype)cl_barButtonWithImageNormal:(UIImage *)normal highlight:(UIImage *)highlight frame:(CGRect) frame tintColor:(UIColor *)tintColor target:(id)target action:(SEL)action;
@end
