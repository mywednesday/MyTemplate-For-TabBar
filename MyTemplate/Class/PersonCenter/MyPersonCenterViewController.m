//
//  MyPersonCenterViewController.m
//  MyTemplate
//
//  Created by qnsoft on 15/9/14.
//  Copyright (c) 2015年 wzp. All rights reserved.
//

#import "MyPersonCenterViewController.h"
#import "Masonry.h"
#import "BaseCell.h"
#import "ProDelegateFirstViewController.h"
#import "TextSizeCaculateViewController.h"
#import "RichTextViewController.h"
#import "OCGrammarViewController.h"
#import "MultiThreadViewController.h"
#import "DataPersistenceViewController.h"
#import "FileManageViewController.h"
#import "DataSecurityVC.h"
#import "UIView+WZPSeparator.h"
#import "UIViewController+WZPExtension.h"




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
    // 设置导航默认标题的颜色及字体大小
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName: [UIFont systemFontOfSize:19.0]};
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
        case 2:
        {
            RichTextViewController *myVC = [[RichTextViewController alloc] initWithNibName:nil bundle:nil];
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
        case 3:
        {
            OCGrammarViewController *myVC = [[OCGrammarViewController alloc] initWithNibName:nil bundle:nil];
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
        case 4:
        {
            MultiThreadViewController *myVC = [[MultiThreadViewController alloc] initWithNibName:nil bundle:nil];
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
        case 5:
        {
            DataPersistenceViewController *myVC = [[DataPersistenceViewController alloc] initWithNibName:nil bundle:nil];
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
        case 6:
        {
            FileManageViewController *myVC = [[FileManageViewController alloc] initWithNibName:nil bundle:nil];
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
        case 7:
        {
            DataSecurityVC *myVC = [[DataSecurityVC alloc] instanceInitialViewControllerFromStoryboard:@"personcenter"
                                                                                                bundle:nil
                                                                                            identifier:@"DataSecurityVC"];
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
    NSInteger numberofrows = 0;
    switch (section) {
        case 0:
            numberofrows = 8;
            break;
        default:
            break;
    }
    return numberofrows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"grammarViewCell";     //作为Cell的唯一标识符，使不再页面中的Cell可以重复利用
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)        //设置Cell风格
        cell = [[BaseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    cell.selectedBackgroundView = nil;
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.textLabel.font = [UIFont systemFontOfSize: 15.0];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    
    NSArray *titleAndContents = @[@[@"IOS页面间传值的方式",@"Delegate/NSNotification/Block/NSUserDefault/单例/设置属性",],
                                  @[@"动态计算高度",@"根据UILabel中的文字，动态计算其高度",],
                                  @[@"富文本",@"NSMutableAttributedString",],
                                  @[@"OC基本知识",@"NSArray、NSDictionary",],
                                  @[@"多线程",@"NSThread、NSOperation、GCD",],
                                  @[@"数据持久化",@"自定义对象、NSArray、NSDictionary",],
                                  @[@"文件操作",@"NSFileManager",],
                                  @[@"数据安全",@"对称、非对称加密（AES、RSA）",]];
    
    
    if (indexPath.section < 1) {
        cell.textLabel.text = titleAndContents[indexPath.row][0];
        cell.detailTextLabel.text = titleAndContents[indexPath.row][1];
    }
    
    CusDebugLog(@"%@",titleAndContents[indexPath.row][0]);
    
    
    
    [cell addSeparatorToBottom:0 leftEdge:15 rightEdge:15 withHeight:2 withColor:nil];
    return cell;
}





- (void) loginSuccess: (NSNotification *) notify {
    NSLog(@"\nloginSuccess:\n%@",[notify.userInfo objectForKey:@"comeFromView"]);
}
@end
