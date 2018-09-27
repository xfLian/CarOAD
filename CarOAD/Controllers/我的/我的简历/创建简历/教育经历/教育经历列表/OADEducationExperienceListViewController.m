//
//  OADEducationExperienceListViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADEducationExperienceListViewController.h"

#import "CreateCVEducationExperienceRootModel.h"
#import "EducationExperienceViewModel.h"

#import "EducationExperienceListCell.h"

#import "OADAddEducationExperienceViewController.h"

@interface OADEducationExperienceListViewController ()

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray      *datasArray;
@property (nonatomic, strong) UIButton            *footer_button;

@end

@implementation OADEducationExperienceListViewController

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
    
    self.navTitle     = @"教育经历";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = BackGrayColor;
    
    [EducationExperienceListCell registerToTableView:self.tableView];
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
                                                     title:@"添加教育经历"
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
    
    __weak OADEducationExperienceListViewController *weakSelf = self;
    CreateCVEducationExperienceData *tmpData = [CreateCVEducationExperienceData new];
    OADAddEducationExperienceViewController *viewController = [OADAddEducationExperienceViewController new];
    tmpData.CVId        = self.cvId;
    viewController.data = tmpData;
    viewController.addEducationExperienceSucces = ^(BOOL isAddEducationExperienceSuccess) {

        if (isAddEducationExperienceSuccess) {
            
            [weakSelf loadNewData];
            weakSelf.isNeedLoadCVData(YES);
            
        }

    };
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void) loadNewData {
    
    self.footer_button.hidden = YES;
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [EducationExperienceViewModel requestPost_getEduExpNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        CarOadLog(@"info --- %@",info);
        
        CreateCVEducationExperienceRootModel *rootModel  = [[CreateCVEducationExperienceRootModel alloc] initWithDictionary:info];
        
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        
        if (rootModel.data.count > 0) {
            
            for (CreateCVEducationExperienceData *tmpData in rootModel.data) {
                
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
    
    return 100 *Scale_Height;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EducationExperienceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EducationExperienceListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.datasArray.count > 0) {
        
        cell.data = self.datasArray[indexPath.section];
        [cell loadContent];
        
    }
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak OADEducationExperienceListViewController *weakSelf = self;
    CreateCVEducationExperienceData *tmpData = self.datasArray[indexPath.section];
    OADAddEducationExperienceViewController *viewController = [OADAddEducationExperienceViewController new];
    tmpData.CVId        = self.cvId;
    viewController.data = tmpData;
    viewController.addEducationExperienceSucces = ^(BOOL isAddEducationExperienceSuccess) {
        
        [weakSelf loadNewData];
        weakSelf.isNeedLoadCVData(YES);
        
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
    
    __weak OADEducationExperienceListViewController *weakSelf = self;
    
    [tableView setEditing:NO animated:YES];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除该消息？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            CreateCVEducationExperienceData *tmpData = weakSelf.datasArray[indexPath.section];
            NSDictionary *params = @{@"eduExpId" : tmpData.eduExpId};
            [EducationExperienceViewModel requestPost_deleteEduExpNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"删除成功" toView:self.view afterDelay:1.f];
                int64_t delayInSeconds = 1.5f;
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

@end
