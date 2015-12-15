//
//  BaseVC.h
//  MyTemplate
//
//  Created by qnsoft on 15/10/15.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, UILeftBarButtonItemStyle) {
    UILeftBarButtonItemStyleImage = 0,
    UILeftBarButtonItemStyleTitle = 1,
    UILeftBarButtonItemStyleTitleAndImage = 2
};




@interface BaseVC : UIViewController


/**
    导航左侧按钮的风格样式，默认为:UILeftBarButtonItemStyleImage
 */
@property (nonatomic,assign) UILeftBarButtonItemStyle leftBarButtonItemStyle;
/**
    导航的侧滑返回是否可用，默认不可用
 */
@property (nonatomic,assign) BOOL sideSlipForNavBackWorked;



@end
