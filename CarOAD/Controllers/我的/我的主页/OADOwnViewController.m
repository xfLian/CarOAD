//
//  OADOwnViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADOwnViewController.h"

#import "OwnMainViewModel.h"
#import "OwnHeaderView.h"
#import "OwnCell.h"

#import "OADMessageListViewController.h"
#import "OADUserInfomationViewController.h"
#import "OADResumeListViewController.h"
#import "OADMyPublishViewController.h"
#import "OADCertificationViewController.h"
#import "OADChangePasswordViewController.h"
#import "OADUserOptionsViewController.h"
#import "OADMYSkillListViewController.h"
#import "OADMyOrderListViewController.h"
#import "OADMyEvaluateListViewController.h"
#import "OADMyDeliverListViewController.h"

@interface OADOwnViewController ()<OwnHeaderViewDelegate>
{
    
    id headerViewData;
    
}
@property (nonatomic, strong) UIImageView   *headerBackImageView;
@property (nonatomic, strong) OwnHeaderView *headerView;
@property (nonatomic, strong) UIView        *navigationBackView;
@property (nonatomic, strong) UIView        *navigationMaskView;
@property (nonatomic, strong) UILabel       *navigationTitleLabel;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSArray             *datasArray;

@property (nonatomic, strong) UIView            *badgeView;

@end

@implementation OADOwnViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    
    if (accountInfo.user_id) {
        
        [self steartNetWorkingWithUserId:accountInfo.user_id];
        
    } else {
        
        headerViewData       = nil;
        self.headerView.data = nil;
        self.datasArray = [OwnMainViewModel getListDatasArrayWithData:nil];
        [self.headerView loadContent];
        [self.tableView reloadData];
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (NSMutableDictionary *)params {
    
    if (!_params) {
        
        _params = [[NSMutableDictionary alloc] init];
    }
    
    return _params;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavigationView];
    
    [self initialization];
    
}

- (void) initialization {
    
    self.datasArray = [OwnMainViewModel getListDatasArrayWithData:nil];
    [self.tableView reloadData];
    
}

- (void) createNavigationView {
    
    UIView *navigationBackView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, SafeAreaTopHeight)];
    navigationBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:navigationBackView];
    self.navigationBackView = navigationBackView;
    
    UIView *navigationMaskView         = [[UIView alloc]initWithFrame:navigationBackView.bounds];
    navigationMaskView.backgroundColor = MainColor;
    [navigationBackView addSubview:navigationMaskView];
    self.navigationMaskView = navigationMaskView;
    
    self.navigationMaskView.hidden = YES;
    
    {
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"我的"
                                                  font:[UIFont fontWithName:@"STHeitiSC-Medium" size:17.f]
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];
        [self.view addSubview:label];
        
        [label sizeToFit];
        label.center = CGPointMake(navigationMaskView.width / 2, navigationMaskView.height - 22);
        self.navigationTitleLabel = label;
        
    }
    
    {
        
        UIImage *buttonImage = [UIImage imageNamed:@"message_item_white"];
        
        CGSize imageSize = buttonImage.size;
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(navigationBackView.width - 44, SafeAreaTopHeight - 44, 44, 44)
                                                buttonType:kButtonNormal
                                                     title:nil
                                                     image:buttonImage
                                                  higImage:nil
                                                       tag:2000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor = [UIColor clearColor];
        [self.view addSubview:button];
        
        UIView *badgeView         = [[UIView alloc]initWithFrame:CGRectMake((button.width + imageSize.width) / 2 - 6, (button.height - imageSize.height) / 2 - 2, 8, 8)];
        badgeView.backgroundColor = [UIColor redColor];
        [button addSubview:badgeView];
        badgeView.layer.masksToBounds = YES;
        badgeView.layer.cornerRadius  = badgeView.width / 2;
        self.badgeView = badgeView;
        
    }
    
}

- (void)setNavigationController {
    
    [super setNavigationController];
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (sender.tag == 2000) {
        
        if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
            
            OADMessageListViewController *viewController = [OADMessageListViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
        
    }
    
}

- (void) steartNetWorkingWithUserId:(NSString *)userId {
    
    //  获取用户个人资料
    {
        
        [MBProgressHUD showMessage:nil toView:self.view];
        
        NSDictionary *params = @{@"userId" : userId};
        [OwnMainViewModel requestPost_getMyInfoNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
            
            NSArray *dataArray = info[@"data"];
            
            if (dataArray.count > 0) {
                
                headerViewData       = dataArray[0];
                self.headerView.data = dataArray[0];
                
                self.datasArray = [OwnMainViewModel getListDatasArrayWithData:headerViewData];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self.headerView loadContent];
                    [self.tableView reloadData];
                    
                });
                
            }
            
        } error:^(NSString *errorMessage) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }];
        
    }
    
}

- (UIView *) creatHeaderView {
    
    self.headerView                 = [[OwnHeaderView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 110 *Scale_Height + SafeAreaTopHeight + Screen_Width / 16 *3)];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.headerView.delegate        = self;
    return self.headerView;
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.headerBackImageView                 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 110 *Scale_Height + SafeAreaTopHeight)];
    self.headerBackImageView.image           = [UIImage imageNamed:@""];
    self.headerBackImageView.contentMode     = UIViewContentModeScaleAspectFill;
    self.headerBackImageView.clipsToBounds   = YES;
    self.headerBackImageView.backgroundColor = MainColor;
    [self.backView addSubview:self.headerBackImageView];
    
    self.backView.backgroundColor    = BackGrayColor;
    self.contentView.frame           = CGRectMake(0, 0, Screen_Width, self.view.height - 49 - SafeAreaBottomHeight);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.tableView.frame           = self.contentView.bounds;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [self creatHeaderView];
    
    [OwnCell registerToTableView:self.tableView];
    
}

#pragma mark - ScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yOffset = self.tableView.contentOffset.y;
    
    NSDictionary *headerModel = headerViewData;
    NSString     *userName    = headerModel[@"userName"];
    
    if (yOffset >= 20) {
        
        self.navigationBackView.hidden = NO;
        self.navigationMaskView.hidden = NO;
        self.headerBackImageView.frame = CGRectMake(0, -yOffset, Screen_Width, 110 *Scale_Height + SafeAreaTopHeight);
        
        if (userName.length > 0) {
            
            self.navigationTitleLabel.text = userName;
            
        } else {
            
            self.navigationTitleLabel.text = @"我的";
            
        }
        
        [self.navigationTitleLabel sizeToFit];
        self.navigationTitleLabel.center = CGPointMake(self.navigationBackView.width / 2, self.navigationBackView.height - 22);
        
    } else {
        
        self.navigationBackView.hidden = YES;
        self.navigationMaskView.hidden = YES;
        self.headerBackImageView.frame = CGRectMake(0, 0, Screen_Width, -yOffset + 110 *Scale_Height + SafeAreaTopHeight);
        
        self.navigationTitleLabel.text = @"我的";
        [self.navigationTitleLabel sizeToFit];
        self.navigationTitleLabel.center = CGPointMake(self.navigationBackView.width / 2, self.navigationBackView.height - 22);
        
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
    
    OwnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OwnCell" forIndexPath:indexPath];
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
        
        if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
            
            if (indexPath.row == 0) {
                
                OADMyEvaluateListViewController *viewController = [OADMyEvaluateListViewController new];
                [self.navigationController pushViewController:viewController animated:YES];
                
            } else {
                
                OADMyPublishViewController *viewController = [OADMyPublishViewController new];
                [self.navigationController pushViewController:viewController animated:YES];
                
            }
            
        }
        
    } else {
        
        if (indexPath.row == 0) {
            
            NSDictionary *model = headerViewData;
            
            NSString *isRealnameAuth = model[@"isRealnameAuth"];
            
            if ([isRealnameAuth integerValue] == 0 || [isRealnameAuth integerValue] == 3) {
                
                if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
                    
                    OADCertificationViewController *viewController = [OADCertificationViewController new];
                    [self.navigationController pushViewController:viewController animated:YES];
                    
                }
                
            } else if ([isRealnameAuth integerValue] == 1) {
                
                [MBProgressHUD showMessageTitle:@"您已通过实名认证，请勿重复操作" toView:self.view afterDelay:1.5f];
                
            } else if ([isRealnameAuth integerValue] == 2) {
                
                [MBProgressHUD showMessageTitle:@"您的实名认证申请正在处理中……" toView:self.view afterDelay:1.5f];
                
            }
            
        } else if (indexPath.row == 1) {
            
            if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
                
                OADChangePasswordViewController *viewController = [OADChangePasswordViewController new];
                [self.navigationController pushViewController:viewController animated:YES];
                
            }
            
        } else {
            
            OADUserOptionsViewController *viewController = [OADUserOptionsViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
        
    }
    
}

#pragma mark - OwnHeaderViewDelegate
- (void) gotoEdiUserInfomationWithData:(id)data; {
    
    //  编辑用户资料
    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        OADUserInfomationViewController *viewController = [OADUserInfomationViewController new];
        viewController.isNeedLoadCVData = ^(BOOL isNeedLoadCVData) {
            
        };
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

- (void) clickTabBarButtonWithTag:(NSInteger)tag; {
    
    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {
        
        if (tag == 0) {
            
            OADResumeListViewController *viewController = [OADResumeListViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else if (tag == 1) {
            
            OADMyDeliverListViewController *viewController = [OADMyDeliverListViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else if (tag == 2) {
            
            OADMYSkillListViewController *viewController = [OADMYSkillListViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
            
        } else if (tag == 3) {
            
            OADMyOrderListViewController *viewController = [OADMyOrderListViewController new];
            [self.navigationController pushViewController:viewController animated:YES];
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

