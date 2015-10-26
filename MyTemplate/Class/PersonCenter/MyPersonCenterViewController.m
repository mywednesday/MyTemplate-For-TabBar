//
//  MyPersonCenterViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/9/14.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyPersonCenterViewController.h"
#import "MyOperateTipsHelper.h"
#import "Masonry.h"
#import "MyTableViewCell.h"
#import "ProDelegateFirstViewController.h"
#import "TextSizeCaculateViewController.h"




@interface MyPersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myGrammarTableView;
@end






@implementation MyPersonCenterViewController



- (void) dealloc {
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MyNotification_Login_Success object:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginSuccess:)
                                                     name:MyNotification_Login_Success
                                                   object:nil];
        
    }
    return self;
}

- (void) viewDidLoad {

    self.title = @"个人中心";
    self.view.backgroundColor = VIEW_NORMAL_BG_COLOR;
    
    
    
    NSMutableDictionary *userInfoForNotify = [[NSMutableDictionary alloc] init];
    [userInfoForNotify setObject:@"个人中心" forKey:@"comeFromView"];
    [[NSNotificationCenter defaultCenter] postNotificationName:MyNotification_Login_Success
                                                        object:nil
                                                      userInfo:userInfoForNotify];
    
    
    
    
    
    
    
    
    
    //UITableView 初始化设置
    if(!_myGrammarTableView)
        _myGrammarTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myGrammarTableView.delegate = self;
    _myGrammarTableView.dataSource = self;
    _myGrammarTableView.opaque = NO;
    [_myGrammarTableView setBackgroundColor:[UIColor whiteColor]];
    _myGrammarTableView.backgroundView = nil;
    _myGrammarTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myGrammarTableView.bounces = NO;
    [self.view addSubview:_myGrammarTableView];
    [_myGrammarTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}




- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [myTips showOperateTipsForSpecificView: SpecificViewKey_ForTalk];
    
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
            ProDelegateFirstViewController *myVC = [[ProDelegateFirstViewController alloc] initWithNibName:nil bundle:nil];
            myVC.leftBarButtonItemStyle = UILeftBarButtonItemStyleImage;
            myVC.sideSlipForNavBackWorked = YES;
            myVC.hidesBottomBarWhenPushed = YES;        //隐藏底部导航Bar
            if(self.navigationController){
                [self.navigationController pushViewController:myVC animated:YES];
                
            }else if(self.presentingViewController){
                [self presentViewController:myVC animated:YES completion:^{
                    
                }];
            }
            break;
        }
        case 1:
        {
            TextSizeCaculateViewController *myVC = [[TextSizeCaculateViewController alloc] initWithNibName:nil bundle:nil];
            myVC.leftBarButtonItemStyle = UILeftBarButtonItemStyleImage;
            myVC.sideSlipForNavBackWorked = YES;
            myVC.hidesBottomBarWhenPushed = YES;        //隐藏底部导航Bar
            if(self.navigationController){
                [self.navigationController pushViewController:myVC animated:YES];
                
            }else if(self.presentingViewController){
                [self presentViewController:myVC animated:YES completion:^{
                    
                }];
            }
            break;
        }
        default:
        {
            CustomLog(@"indexPath.Row  越界");
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
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"grammarViewCell";     //作为Cell的唯一标识符，使不再页面中的Cell可以重复利用
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)        //设置Cell风格
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    cell.selectedBackgroundView = nil;
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    
    NSArray *titleAndContents = @[@[@"IOS页面间传值的方式",@"Delegate/NSNotification/Block/NSUserDefault/单例/设置属性",],
                                  @[@"动态计算高度",@"根据UILabel中的文字，动态计算其高度",],
                                  @[@"0",@"1",],
                                  @[@"2",@"3",]];
    
    
    if (indexPath.section < 1) {
        cell.textLabel.text = titleAndContents[indexPath.row][0];
        cell.detailTextLabel.text = titleAndContents[indexPath.row][1];
    }
    
    
    //设置其他属性
    switch (indexPath.row) {
        case 0:
        {
            
            break;
        }
        case 1:
        {
            
            break;
        }
        default:
        {
            CustomLog(@"indexPath.Row  越界");
            break;
        }
    }
    
    
    [cell addSeparatorLine];
    
    return cell;
}





- (void) loginSuccess: (NSNotification *) notify {
    NSLog(@"\nloginSuccess:\n%@",[notify.userInfo objectForKey:@"comeFromView"]);
}
@end
