//
//  MyOperateTipsHelper.h
//  MyTemplate
//
//  Created by qnsoft on 15/9/25.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SpecificViewKey) {
    SpecificViewKey_ForTalk = 0,
    SpecificViewKey_ForPerson = 1
};



@interface MyOperateTipsHelper : UIViewController

//是否有操作提示正在显示
@property (nonatomic, assign) BOOL isOperateTipsShowing;


/**
 显示一个指定页面的操作提示
 */
- (void) showOperateTipsForSpecificView:(SpecificViewKey) specificViewKey;





@end
