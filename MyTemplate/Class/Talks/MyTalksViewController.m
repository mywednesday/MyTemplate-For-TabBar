//
//  MyTalksViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/9/14.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyTalksViewController.h"
#import "MyOperateTipsHelper.h"
#import <Masonry.h>
#import "MyTableViewCell.h"
#import "CustomViewController.h"
#import "MapkitViewController.h"
#import "QRCodeViewController.h"
#import "CommonModel.h"
#import "UIView+WZPSeparator.h"


typedef NS_ENUM(NSInteger,SJAccountRights) { //账户权限
    SJAccountRightsNone = 0,
    SJAccountRightsVerifyCoupon = 1 << 0,
    SJAccountRightsReturnCoupon = 1 << 1,
    SJAccountRightsOrder = 1 << 2,
    SJAccountRightsAll = SJAccountRightsVerifyCoupon | SJAccountRightsReturnCoupon | SJAccountRightsOrder
};


@interface MyTalksViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *myVCContactModelArr;     //VCContactModel数组

@end




@implementation MyTalksViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        
        
    }
    return self;
}

- (void)viewDidLoad{
    
    self.title = @"会话";
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor brownColor],
                                                                    NSFontAttributeName: [UIFont systemFontOfSize:19.0]};
    self.view.backgroundColor = VIEW_NORMAL_BG_COLOR;
    
    
    
    
    
    
    NSMutableDictionary *userInfoForNotify = [[NSMutableDictionary alloc] init];
    [userInfoForNotify setObject:@"会话" forKey:@"comeFromView"];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:MyNotification_Login_Success
                                                        object:nil
                                                      userInfo:userInfoForNotify];
    
    

    
    
    //输出项目路径，以及系统版本信息
    NSLog(@"\nHome : %@",[MyGlobalHelper getSandboxDirectoryForHome]);
    NSLog(@"\nDocuments : %@",[MyGlobalHelper getSandboxDirectoryForDocuments]);
    NSLog(@"\nCaches : %@",[MyGlobalHelper getSandboxDirectoryForCaches]);
    NSLog(@"\nTmp : %@",[MyGlobalHelper getSandboxDirectoryForTmp]);
    NSLog(@"\nCURRENT_SYSTEM_VERSION = %@",CURRENT_SYSTEM_VERSION);
    
    
    
    
    
    NSArray *titleAndContents = @[@[@"CustomViewController",@"自定义的ViewController，可根据需要设置风格",],
                                  @[@"地图",@"高德地图，苹果内置地图也是调用的高德接口",],
                                  @[@"二维码",@"ZXing",],
                                  @[@"2",@"3",]];
    
    
    
    //初始化视图关系对象
    if (!_myVCContactModelArr) {
        _myVCContactModelArr = [NSArray arrayWithObjects:[VCContactModel contactModelWithTitleName:@"CustomViewController"
                                                                                      SubTitleName:@"自定义的ViewController，可根据需要设置风格" Class:NSClassFromString(@"CustomViewController")], nil];
    }
    
    
    
    
    //UITableView 初始化设置
    if(!_myTableView)
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.opaque = NO;
    [_myTableView setBackgroundColor:[UIColor whiteColor]];
    _myTableView.backgroundView = nil;
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.bounces = NO;
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //----
    
    
    SJAccountRights myRights = SJAccountRightsReturnCoupon | SJAccountRightsVerifyCoupon;
    if (myRights & SJAccountRightsOrder) {
        NSLog(@"SJAccountRightsOrder");
    }
    if (myRights & SJAccountRightsReturnCoupon) {
        NSLog(@"SJAccountRightsReturnCoupon");
    }
    if (myRights & SJAccountRightsVerifyCoupon) {
        NSLog(@"SJAccountRightsVerifyCoupon");
    }
    if (myRights & (SJAccountRightsReturnCoupon | SJAccountRightsVerifyCoupon)) {
        NSLog(@"SJAccountRightsReturnCoupon and SJAccountRightsVerifyCoupon");
    }


    
    
    NSDate *birthday = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *birthday1 = [NSDate dateWithTimeIntervalSince1970:1000000];
    NSDate *birthday2 = [NSDate dateWithTimeIntervalSince1970:-1000000];
    
    
    
    NSString *birthdayStr = [self getStringFromDate:birthday];
    NSString *birthdayStr1 = [self getStringFromDate:birthday1];
    NSString *birthdayStr2 = [self getStringFromDate:birthday2];
    NSString *gyu = @"1988-12-12";
    long long a = [gyu longLongValue];
    NSDate *adf = [NSDate dateWithTimeIntervalSince1970:[gyu longLongValue]];
    NSLog(@"\n%@",birthday);
    NSLog(@"\n%@",birthday1);
    NSLog(@"\n%@",birthday2);
    
}

- (NSString *)getStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
//    //添加显示帮助向导的代码
//    MyOperateTipsHelper *channelManageTips = [[MyOperateTipsHelper alloc] initWithNibName:nil bundle:nil];
//    [channelManageTips showOperateTipsForChannelManageAtPoint:CGPointMake(95, 25)];
    
}



#pragma mark --- UITableViewDelegate ---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            CustomViewController *customVC = [[CustomViewController alloc] initWithNibName:nil bundle:nil];
            if(self.navigationController){
                [self.navigationController pushViewController:customVC animated:YES];
                
            }else if(self.presentingViewController){
                [self presentViewController:customVC animated:YES completion:^{
                    
                }];
            }
            break;
        }
        case 1:
        {
            MapkitViewController *mapkitVC = [[MapkitViewController alloc] initWithNibName:nil bundle:nil];
            if(self.navigationController){
                [self.navigationController pushViewController:mapkitVC animated:YES];
                
            }else if(self.presentingViewController){
                [self presentViewController:mapkitVC animated:YES completion:^{
                    
                }];
            }
            break;
        }
        case 2:
        {
            QRCodeViewController *mapkitVC = [[QRCodeViewController alloc] initWithNibName:nil bundle:nil];
            if(self.navigationController){
                [self.navigationController pushViewController:mapkitVC animated:YES];
                
            }else if(self.presentingViewController){
                [self presentViewController:mapkitVC animated:YES completion:^{
                    
                }];
            }
            break;
        }
        default:
        {
            CusDebugLog(@"indexPath.Row  越界");
            break;
        }
    }
}




#pragma mark --- UITableViewDataSource ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Default is 1 if not implemented
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"talksViewCell";     //作为Cell的唯一标识符，使不再页面中的Cell可以重复利用
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)        //设置Cell风格
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    cell.selectedBackgroundView = nil;
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.textLabel.font = [UIFont systemFontOfSize: 15.0];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    
    NSArray *titleAndContents = @[@[@"CustomViewController",@"自定义的ViewController，可根据需要设置风格",],
                                  @[@"地图",@"高德地图，苹果内置地图也是调用的高德接口",],
                                  @[@"二维码",@"ZXing",],
                                  @[@"2",@"3",]];
    
    
    if (indexPath.section < 1) {
        cell.textLabel.text = titleAndContents[indexPath.row][0];
        cell.detailTextLabel.text = titleAndContents[indexPath.row][1];
    }
    
    
    //设置其他属性
    switch (indexPath.row) {
        case 0:
        {
            CusDebugLog(@"\n%@",titleAndContents[indexPath.row][1]);
            break;
        }
        case 1:
        {
            CusDebugLog(@"\n%@",titleAndContents[indexPath.row][1]);
            break;
        }
        case 3:
        {
            CusDebugLog(@"\n%@",titleAndContents[indexPath.row][1]);            
            break;
        }
        default:
        {
            CusDebugLog(@"indexPath.Row  越界");
            break;
        }
    }
    
    
    
    [cell addSeparatorToBottom:1 leftEdge:15 rightEdge:15 withHeight:2 withColor:nil];
    
    return cell;
}























@end
