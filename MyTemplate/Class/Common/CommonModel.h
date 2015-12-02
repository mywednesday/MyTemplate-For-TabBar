//
//  CommonModel.h
//  MyTemplate
//
//  Created by qnsoft on 15/11/25.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModel : NSObject

@end




/**
    视图控制器（VC）的关联模型
 */
@interface VCContactModel : NSObject
@property (nonatomic, strong) NSString *titleName;                      //在Cell中的标题
@property (nonatomic, strong) NSString *subTitleName;                   //在Cell中的副标题
@property (nonatomic, strong) Class vcClass;         //要跳转的ViewController

+ (instancetype) contactModelWithTitleName:(NSString *) titleName
                              SubTitleName:(NSString *)subTitleName
                                     Class:(UIViewController *) vcClass;
@end