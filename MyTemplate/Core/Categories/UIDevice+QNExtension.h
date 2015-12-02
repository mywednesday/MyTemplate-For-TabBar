//
//  UIDevice+QNExtension.h
//  GGSJ
//
//  Created by 刘昶 on 15/11/20.
//  Copyright © 2015年 com.channelsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (QNExtension)

-(NSString *)qn_deviceModel;

-(NSString *)qn_formatedIdentifierForVendor;
@end
