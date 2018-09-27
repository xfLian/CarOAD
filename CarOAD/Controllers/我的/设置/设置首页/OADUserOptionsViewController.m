//
//  OADUserOptionsViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/9.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADUserOptionsViewController.h"

#import "UserOptionsCell.h"
#import "UserOptionsViewModel.h"

#import "OADAboutUsViewController.h"
#import "OADFeedbackViewController.h"

#import "JPUSHService.h"

@interface OADUserOptionsViewController ()

@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) UIButton       *loginButton;

@end

@implementation OADUserOptionsViewController

- (NSMutableArray *)datasArray {

    if (_datasArray == nil) {

        _datasArray = [[NSMutableArray alloc] init];
    }
    return _datasArray;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;

    [self initialization];

    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];

    if (accountInfo.user_id) {

        [self.loginButton setTitle:@"退出登录" forState:UIControlStateNormal];

    } else {

        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];

    }

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void) initialization {

    NSArray *datasArray = @[@{@"datas":@[@{@"title":@"检查更新",
                                           @"type":@"",
                                           @"isShowArrow":@"1",
                                           @"isShowLine":@"1"}
                                         ,@{@"title":@"清除缓存",
                                            @"type":@"正在计算……",
                                            @"isShowArrow":@"1",
                                            @"isShowLine":@"0"}
                                         ]}
                            ,@{@"datas":@[@{@"title":@"关于我们",
                                             @"type":@"",
                                             @"isShowArrow":@"1",
                                             @"isShowLine":@"1"}
                                           ,@{@"title":@"意见反馈",
                                              @"type":@"",
                                              @"isShowArrow":@"1",
                                              @"isShowLine":@"1"}
                                           ,@{@"title":@"联系客服",
                                              @"type":CustomerServicePhone,
                                              @"isShowArrow":@"0",
                                              @"isShowLine":@"0"}
                                          ]}];
    
    self.datasArray = [datasArray copy];

    [self.tableView reloadData];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        unsigned long long size = [[ClearCacheFile new] folderSizeAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"MyHTML.html"]];
        size += [SDImageCache sharedImageCache].getSize;   //CustomFile + SDWebImage 缓存

        //设置文件大小格式
        NSString *sizeText = nil;
        if (size >= pow(10, 9)) {
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        }else if (size >= pow(10, 6)) {
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        }else if (size >= pow(10, 3)) {
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        }else {
            sizeText = [NSString stringWithFormat:@"%zdB", size];
        }

        {

            NSMutableArray *tmpDatasArray          = [[NSMutableArray alloc] init];
            tmpDatasArray                          = [datasArray mutableCopy];

            NSMutableDictionary *firstSectionData = [[NSMutableDictionary alloc] init];
            firstSectionData                      = [tmpDatasArray[0] mutableCopy];

            NSMutableArray *firstSectionDataArray = [NSMutableArray arrayWithArray:firstSectionData[@"datas"]];

            NSMutableDictionary *secondRowData = [[NSMutableDictionary alloc] init];
            secondRowData                      = [firstSectionDataArray[1] mutableCopy];

            [secondRowData setObject:sizeText forKey:@"type"];

            [firstSectionDataArray replaceObjectAtIndex:1 withObject:secondRowData];
            [firstSectionData setObject:[firstSectionDataArray copy] forKey:@"datas"];
            [tmpDatasArray replaceObjectAtIndex:0 withObject:firstSectionData];
            self.datasArray = [tmpDatasArray copy];

        }

        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView reloadData];

        });

    });

}

- (void)setNavigationController {

    self.navTitle     = @"设置";
    self.leftItemText = @"返回";
    [super setNavigationController];

}

- (void)buildSubView {

    [super buildSubView];
    
    self.tableView.backgroundColor = BackGrayColor;
    
    self.tableView.tableFooterView = [self creatFooterView];
    [UserOptionsCell registerToTableView:self.tableView];

}

- (UIView *) creatFooterView {

    UIView *footerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height + SafeAreaBottomHeight)];
    footerView.backgroundColor = BackGrayColor;

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 20 *Scale_Height, footerView.width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"登录"
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = CarOadColor(210, 33, 33);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_M_16;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [footerView addSubview:button];
        self.loginButton = button;
        
    }

    return footerView;

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
            
            //  删除推送标签
            OADAccountInfo *deleAccountInfo = [OADSaveAccountInfoTool accountInfo];
            NSSet *set = [[NSSet alloc] initWithArray:@[deleAccountInfo.user_phone]];
            
            [JPUSHService deleteTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                
            } seq:0];
            
            NSDictionary   *dict = @{};
            OADAccountInfo *accountInfo = [OADAccountInfo accountInfoWithDictionary:dict];
            [OADSaveAccountInfoTool saveAccountInfo:accountInfo];

            [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];

        }

    }

}

#pragma mark - UITableViewDataSource
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *backView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 10 *Scale_Height)];
    backView.backgroundColor = BackGrayColor;
    return backView;

}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10 *Scale_Height;

}

//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return self.datasArray.count;
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSDictionary *model      = self.datasArray[section];
    NSArray      *datasArray = model[@"datas"];
    return datasArray.count;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44 *Scale_Height;

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UserOptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserOptionsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (self.datasArray.count > 0) {

        NSDictionary *model      = self.datasArray[indexPath.section];
        NSArray      *datasArray = model[@"datas"];
        cell.data = datasArray[indexPath.row];
        [cell loadContent];

    }

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

        if (indexPath.row == 0) {
            
            [MBProgressHUD showMessage:nil toView:self.view];
            NSDictionary *params = @{@"appType":@"IOS"};
            [UserOptionsViewModel requestPost_checkAdminNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                NSString *net_Version = [info[@"data"][0][@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                NSString *app_Version = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""];

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSArray  *messageArray = [info[@"data"][0][@"updateNew"] componentsSeparatedByString:@";"];
                    NSString *message = nil;
                    
                    for (int i = 0; i < messageArray.count; i++) {
                        
                        if (i == 0) {
                            
                            message = messageArray[0];
                            
                        } else {
                            
                            message = [NSString stringWithFormat:@"%@\n%@",message,messageArray[i]];
                            
                        }
                        
                    }

                    if ([net_Version integerValue] > [app_Version integerValue]) {
                        
                        UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:@"版本更新" message:message preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIView *subView1 = alertDialog.view.subviews[0];
                        UIView *subView2 = subView1.subviews[0];
                        UIView *subView3 = subView2.subviews[0];
                        UIView *subView4 = subView3.subviews[0];
                        UIView *subView5 = subView4.subviews[0];
                        UILabel *messageLabel = subView5.subviews[1];
                        messageLabel.textAlignment = NSTextAlignmentLeft;
                        
                        UIAlertAction *cleanAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            
                            
                        }];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            
                            
                        }];
                        
                        [alertDialog addAction:cleanAction];
                        [alertDialog addAction:okAction];
                        [self presentViewController:alertDialog animated:YES completion:nil];
                        
                    } else {
                        
                        UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:@"版本更新" message:@"您当前已是最新版本，无需更新" preferredStyle:UIAlertControllerStyleAlert];
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            
                            
                        }];
                        
                        [alertDialog addAction:okAction];
                        [self presentViewController:alertDialog animated:YES completion:nil];
                        
                    }
                    
                });
                
            } error:^(NSString *errorMessage) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
                
            } failure:^(NSError *error) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
                
            }];

        } else {

            [self clearCacheClick];

        }

    } else {

        if (indexPath.row == 0) {

            OADAboutUsViewController *viewController = [OADAboutUsViewController new];
            [self.navigationController pushViewController:viewController animated:YES];

        } else if (indexPath.row == 1) {

            OADFeedbackViewController *viewController = [OADFeedbackViewController new];
            [self.navigationController pushViewController:viewController animated:YES];

        } else {

            NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",CustomerServicePhone]; //number为号码字
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];

        }

    }


}

- (void)clearCacheClick {

    [MBProgressHUD showMessage:@"正在清除缓存···" toView:self.view];

    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            {

                NSMutableArray *tmpDatasArray          = [[NSMutableArray alloc] init];
                tmpDatasArray                          = [self.datasArray mutableCopy];

                NSMutableDictionary *firstSectionData = [[NSMutableDictionary alloc] init];
                firstSectionData                      = [tmpDatasArray[0] mutableCopy];

                NSMutableArray *firstSectionDataArray = [NSMutableArray arrayWithArray:firstSectionData[@"datas"]];

                NSMutableDictionary *secondRowData = [[NSMutableDictionary alloc] init];
                secondRowData                      = [firstSectionDataArray[1] mutableCopy];

                [secondRowData setObject:@"0B" forKey:@"type"];

                [firstSectionDataArray replaceObjectAtIndex:1 withObject:secondRowData];
                [firstSectionData setObject:[firstSectionDataArray copy] forKey:@"datas"];
                [tmpDatasArray replaceObjectAtIndex:0 withObject:firstSectionData];
                self.datasArray = [tmpDatasArray copy];

            }

            dispatch_async(dispatch_get_main_queue(), ^{

                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.tableView reloadData];

            });

        });

    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
