//
//  OADAddJobIntensionViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/15.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADAddJobIntensionViewController.h"

#import "CreateCVJobIntensionViewModel.h"

#import "AddJobIntensionCell.h"
#import "EdiUserInfomationChooseTypeView.h"

#import "OADCreateCVViewController.h"

@interface OADAddJobIntensionViewController ()<EdiUserInfomationChooseTypeViewDelegate, AddJobIntensionCellDelegate>

@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) EdiUserInfomationChooseTypeView *chooseTypeView;
@property (nonatomic, strong) CreateCVJobIntensionData *viewData;

@end

@implementation OADAddJobIntensionViewController

- (EdiUserInfomationChooseTypeView *)chooseTypeView {
    
    if (!_chooseTypeView) {
        
        _chooseTypeView          = [[EdiUserInfomationChooseTypeView alloc] init];
        _chooseTypeView.delegate = self;
    }
    
    return _chooseTypeView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
    self.viewData = self.data;
    [self loadTableViewData];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"求职意向";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void) initialization {

    self.datasArray = [NSMutableArray array];
    
    {
        
        NSDictionary *model = @{@"title":@"期望职位",
                                @"placeholder":@"请输入您期望的职位",
                                @"content":@"",
                                @"isShowButton":@"0"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"期望薪资",
                                @"placeholder":@"请选择您期望的薪资",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"期望工种",
                                @"placeholder":@"请选择您期望的工种",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"工作性质",
                                @"placeholder":@"请选择您期望的工作性质",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"期望地点",
                                @"placeholder":@"请选择您期望的工作地点",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
}

- (void) loadTableViewData {
    
    NSMutableArray *datasArray = [NSMutableArray array];
    
    for (int i = 0; i < self.datasArray.count; i++) {
        
        NSMutableDictionary *model = [[NSMutableDictionary alloc] init];
        
        NSDictionary *tmpModel = self.datasArray[i];
        model = [tmpModel mutableCopy];
        
        CreateCVJobIntensionData *data = self.viewData;
        if (i == 0) {
            
            NSString *content = data.skillPost;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 1) {
            
            NSString *content = data.hopeSalaryName;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 2) {
            
            NSString *content = data.workTypeName;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 3) {
            
            NSString *content = data.workNatureName;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 4) {
            
            NSString *content = data.workAddress;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        }
        
        [datasArray addObject:model];
        
    }
    
    self.datasArray = [datasArray mutableCopy];
    [self.tableView reloadData];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = BackGrayColor;
    
    [AddJobIntensionCell registerToTableView:self.tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(10 *Scale_Height, 0, 0, 0);
    self.tableView.tableFooterView = [self creatFooterView];
    
}

- (UIView *) creatFooterView {
    
    UIView *footerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height + SafeAreaBottomHeight)];
    footerView.backgroundColor = BackGrayColor;
    
    {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 20 *Scale_Height, footerView.width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"保存"
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
        
    }
    
    return footerView;
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    CreateCVJobIntensionData *data = self.viewData;
    
    if (data.skillPost.length > 0) {
        
        [params setObject:data.skillPost forKey:@"hopePost"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请输入您期望的职位" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.hopeSalary.length > 0) {
        
        [params setObject:data.hopeSalary forKey:@"hopeSalary"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择您期望的薪资" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.workType.length > 0) {
        
        [params setObject:data.workType forKey:@"workTypeId"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择您期望的工种" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.workNature.length > 0) {
        
        [params setObject:data.workNature forKey:@"workNature"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择您期望的工作性质" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.provinceId.length > 0 && data.cityId.length > 0 && data.areaId.length > 0) {
        
        [params setObject:data.provinceId forKey:@"provinceId"];
        [params setObject:data.cityId forKey:@"cityId"];
        [params setObject:data.areaId forKey:@"areaId"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择您期望的工作地点" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.intentionId.length > 0) {
        
        [params setObject:data.intentionId forKey:@"intentionId"];
        
    } else {
        
        [params setObject:@"" forKey:@"intentionId"];
        
    }
    
    
    [params setObject:data.CVId forKey:@"CVId"];
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [CreateCVJobIntensionViewModel requestPost_addIntentionNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        __weak OADAddJobIntensionViewController *weakSelf = self;
        
        [MBProgressHUD showMessageTitle:@"保存成功" toView:self.view afterDelay:1.5f];
        int64_t delayInSeconds = 1.6f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            weakSelf.isNeedLoadCVData(YES);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
        
    }];

}

#pragma mark - UITableViewDataSource
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasArray.count;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45 *Scale_Height;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddJobIntensionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddJobIntensionCell" forIndexPath:indexPath];
    cell.selectionStyle       = UITableViewCellSelectionStyleNone;
    cell.row                  = indexPath.row;
    cell.delegate             = self;
    
    if (self.datasArray.count > 0) {
        
        cell.data = self.datasArray[indexPath.row];
        [cell loadContent];
        
    }
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark - AddJobIntensionCellDelegate
- (void) clickGetJobInfoWithRow:(NSInteger)row; {
    
    if (row == 1) {
        
        [self.chooseTypeView showChooseTypeViewWithType:salary_range_view];
        
    } else if (row == 2) {
        
        [self.chooseTypeView showChooseTypeViewWithType:type_of_work_view];
        
    } else if (row == 3) {
        
        [self.chooseTypeView showChooseTypeViewWithType:nature_of_work_view];
        
    } else if (row == 4) {
        
        [self.chooseTypeView showChooseTypeViewWithType:address_view];
        
    }
    
}

- (void) getTextFieldText:(NSString *)text forRow:(NSInteger)row; {
    
    if (row == 0) {
        
        CreateCVJobIntensionData *model = self.viewData;
        model.skillPost = text;
        self.viewData = model;
        
    }
    
}

- (void)showCellErrorMessage {
    
    [MBProgressHUD showMessageTitle:@"请输入长度不超过14字的内容" toView:self.view afterDelay:1.f];
    
}

#pragma mark - EdiUserInfomationChooseTypeViewDelegate
- (void) chooseJobTypeWithData:(id)data forViewType:(EChooseJobTypeType)viewType; {
    
    CreateCVJobIntensionData *model = self.viewData;
    NSString *title = data[@"title"];
    NSString *titleId = data[@"titleId"];
    
    if (viewType == salary_range_view) {
        
        model.hopeSalaryName = title;
        model.hopeSalary = titleId;
        
    } else if (viewType == type_of_work_view) {
        
        model.workTypeName = title;
        model.workType = titleId;
        
    } else if (viewType == nature_of_work_view) {
        
        model.workNatureName = title;
        model.workNature = titleId;
        
    }
    
    self.viewData = model;
    [self loadTableViewData];
    
}

- (void) getSelectedProvinceData:(NSDictionary *)provinceData
                        cityData:(NSDictionary *)cityData
                        areaData:(NSDictionary *)areaData; {
    
    NSString *provinceId = provinceData[@"provinceid"];
    NSString *cityId     = cityData[@"cityid"];
    NSString *areaId     = areaData[@"areaId"];
    
    if (provinceId.length > 0 && cityId.length > 0 && areaId.length > 0) {
        
        NSString *province = provinceData[@"province"];
        NSString *city     = cityData[@"city"];
        NSString *area     = areaData[@"area"];
        
        CreateCVJobIntensionData *data = self.viewData;
        data.province = province;
        data.city = city;
        data.area = area;
        data.provinceId = provinceId;
        data.cityId = cityId;
        data.areaId = areaId;
        data.workAddress = city;
        self.viewData = data;
        [self loadTableViewData];

    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
