//
//  MyOperateTipsHelper.h
//  xhxw
//
//  Created by qnsoft on 15/9/28.
//  Copyright (c) 2015年 北京青牛科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>


//对应NSDefault中的boolForKey关键字
#define HasShownNewsViewHelp @"HasShownNewsViewHelp"            //是否显示“新闻”主页帮助向导
#define HasShownBroadCastViewHelp @"HasShownBroadCastViewHelp"  //是否显示“广播”主页帮助向导
#define HasShownVideoViewHelp @"HasShownVideoViewHelp"          //是否显示“视频”主页帮助向导
#define HasShownPersonViewHelp @"HasShownPersonViewHelp"        //是否显示“个人”主页帮助向导


#define HasShownChannelManageViewHelp @"HasShownChannelManageViewHelp"      //是否显示“频道管理”帮助向导
#define HasShownNewsSearchViewHelp @"HasShownNewsSearchViewHelp"            //是否显示“新闻搜索”帮助向导
#define HasShownFontSelectViewHelp @"HasShownFontSelectViewHelp"            //是否显示“字体设置”帮助向导



@interface MyOperateTipsHelper : UIViewController



/**
 *  显示“频道管理”帮助向导
 *  point :图片左上角坐标
 */
- (void) showOperateTipsForChannelManageAtPoint:(CGPoint) point;
/**
 *  显示“新闻搜索”帮助向导
 *  point :图片左上角坐标
 */
- (void) showOperateTipsForNewsSearchAtPoint:(CGPoint) point;
/**
 *  显示“字体设置”帮助向导
 *  point :图片左上角坐标
 */
- (void) showOperateTipsForFontSelectAtPoint:(CGPoint) point;





+ (void) dismissCurrentMoreControl;



@end
