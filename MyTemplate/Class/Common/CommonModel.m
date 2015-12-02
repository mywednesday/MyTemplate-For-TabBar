//
//  CommonModel.m
//  MyTemplate
//
//  Created by qnsoft on 15/11/25.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "CommonModel.h"

@implementation CommonModel

@end








/**
    视图控制器（VC）的关联模型
 */
@implementation VCContactModel
+ (instancetype) contactModelWithTitleName:(NSString *) titleName
                              SubTitleName:(NSString *) subTitleName
                                     Class:(Class) vcClass {
    return [[VCContactModel alloc] initContactModelWithTitleName:titleName
                                                    SubTitleName:subTitleName
                                                           Class:vcClass];
}


- (id) initContactModelWithTitleName:(NSString *) titleName
                        SubTitleName:(NSString *)subTitleName
                               Class:(Class) vcClass {
    self = [self init];
    if (self) {
        self.titleName = titleName;
        self.subTitleName = subTitleName;
        self.vcClass = vcClass;
    }
    return self;
}
@end