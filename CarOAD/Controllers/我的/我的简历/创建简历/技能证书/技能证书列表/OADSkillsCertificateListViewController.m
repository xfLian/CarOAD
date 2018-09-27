//
//  OADSkillsCertificateListViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADSkillsCertificateListViewController.h"

#import "SkillsCertificateViewModel.h"
#import "CreateCVSkillsCertificateRootModel.h"

#import "SkillsCertificateListCell.h"

#import "OADAddSkillsCertificateViewController.h"

@interface OADSkillsCertificateListViewController ()

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray      *datasArray;
@property (nonatomic, strong) UIButton            *footer_button;

@end

@implementation OADSkillsCertificateListViewController

- (NSMutableArray *)datasArray {
    
    if (_datasArray == nil) {
        
        _datasArray = [[NSMutableArray alloc] init];
    }
    return _datasArray;
}

- (NSMutableDictionary *)params {
    
    if (!_params) {
        
        _params = [[NSMutableDictionary alloc] init];
    }
    
    return _params;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
}

- (void) initialization {
    
    [self.params setObject:self.cvId forKey:@"CVId"];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"技能证书";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = BackGrayColor;
    
    [SkillsCertificateListCell registerToTableView:self.tableView];
    self.tableView.tableFooterView = [self creatFooterView];
    
    NSMutableArray *images = [NSMutableArray array];
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setImages:images forState:MJRefreshStateIdle];
    [header setImages:images forState:MJRefreshStatePulling];
    [header setImages:images forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    
}

- (UIView *) creatFooterView {
    
    UIView *footerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height + SafeAreaBottomHeight)];
    footerView.backgroundColor = BackGrayColor;
    
    {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 20 *Scale_Height, footerView.width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"添加技能证书"
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = MainColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_M_16;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [footerView addSubview:button];
        self.footer_button = button;
        self.footer_button.hidden = YES;
        
    }
    
    return footerView;
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    __weak OADSkillsCertificateListViewController *weakSelf = self;
    CreateCVSkillsCertificateData *tmpData = [CreateCVSkillsCertificateData new];
    OADAddSkillsCertificateViewController *viewController = [OADAddSkillsCertificateViewController new];
    tmpData.CVId = self.cvId;
    viewController.data = tmpData;
    viewController.addJobExpSucces = ^(BOOL isAddJobSuccess) {
        
        [weakSelf loadNewData];
        weakSelf.isNeedLoadCVData(YES);
        
    };
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void) loadNewData {
    
    self.footer_button.hidden = YES;
    [self.datasArray removeAllObjects];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [SkillsCertificateViewModel requestPost_getSkillCertNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        CreateCVSkillsCertificateRootModel *rootModel  = [[CreateCVSkillsCertificateRootModel alloc] initWithDictionary:info];
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        if (rootModel.data.count > 0) {
            
            for (CreateCVSkillsCertificateData *tmpData in rootModel.data) {
                
                [dataArray addObject:tmpData];
                
            }
            
        }
        
        self.datasArray = [dataArray mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            self.footer_button.hidden = NO;
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];
        self.footer_button.hidden = NO;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.f];
        self.footer_button.hidden = NO;
        
    }];
    
}

#pragma mark - UITableViewDataSource
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10 *Scale_Height;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 10 *Scale_Height)];
    backView.backgroundColor = BackGrayColor;
    
    return backView;
    
}

//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.datasArray.count;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (Screen_Width - 97 *Scale_Height) / 3 + 50 *Scale_Height;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SkillsCertificateListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SkillsCertificateListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.datasArray.count > 0) {
        
        cell.data = self.datasArray[indexPath.section];
        [cell loadContent];
        
    }
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak OADSkillsCertificateListViewController *weakSelf = self;
    CreateCVSkillsCertificateData *tmpData = self.datasArray[indexPath.section];
    OADAddSkillsCertificateViewController *viewController = [OADAddSkillsCertificateViewController new];
    tmpData.CVId = self.cvId;
    viewController.data = tmpData;
    viewController.addJobExpSucces = ^(BOOL isAddJobSuccess) {
        
        if (isAddJobSuccess) {
            
            [weakSelf loadNewData];
            weakSelf.isNeedLoadCVData(YES);
            
        }
        
    };
    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak OADSkillsCertificateListViewController *weakSelf = self;
    
    [tableView setEditing:NO animated:YES];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除技能证书？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            CreateCVSkillsCertificateData *tmpData = weakSelf.datasArray[indexPath.section];
            NSDictionary *params = @{@"skillCertId" : tmpData.skillCertId};
            
            [SkillsCertificateViewModel requestPost_deleteSkillCertNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"删除成功" toView:self.view afterDelay:1.f];
                int64_t delayInSeconds = 1.2f;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    
                    weakSelf.isNeedLoadCVData(YES);
                    [weakSelf loadNewData];
                    
                });
                
            } error:^(NSString *errorMessage) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
                
            } failure:^(NSError *error) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
                
            }];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
