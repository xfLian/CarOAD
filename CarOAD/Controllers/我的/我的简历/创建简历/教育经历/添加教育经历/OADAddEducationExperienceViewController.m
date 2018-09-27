//
//  OADAddEducationExperienceViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADAddEducationExperienceViewController.h"

#import "AddEducationExperienceViewModel.h"
#import "CreateCVEducationExperienceData.h"

#import "AddJobIntensionCell.h"
#import "EdiUserInfomationChooseTypeView.h"

@interface OADAddEducationExperienceViewController ()<EdiUserInfomationChooseTypeViewDelegate, AddJobIntensionCellDelegate>
{
    
    NSInteger age_tag;  //  0.入职时间  1.离职时间
    
}
@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) EdiUserInfomationChooseTypeView *chooseTypeView;
@property (nonatomic, strong) CreateCVEducationExperienceData *viewData;

@end

@implementation OADAddEducationExperienceViewController

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
    
    self.navTitle     = @"教育经历";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void) initialization {
    
    self.datasArray = [NSMutableArray array];
    
    {
        
        NSDictionary *model = @{@"title":@"入学时间",
                                @"placeholder":@"请选择入学时间",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"毕业时间",
                                @"placeholder":@"请选择毕业时间",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"毕业院校",
                                @"placeholder":@"请输入毕业院校",
                                @"content":@"",
                                @"isShowButton":@"0",
                                @"isHideTypeLabel":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"学       历",
                                @"placeholder":@"请选择学历",
                                @"content":@"",
                                @"isShowButton":@"1",
                                @"isHideTypeLabel":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"所学专业",
                                @"placeholder":@"请输入所学专业",
                                @"content":@"",
                                @"isShowButton":@"0",
                                @"isHideTypeLabel":@"1"
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
        
        CreateCVEducationExperienceData *data = self.viewData;
        if (i == 0) {
            
            NSString *content = data.entryEduDate;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 1) {
            
            NSString *content = data.endEduDate;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 2) {
            
            NSString *content = data.university;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 3) {
            
            NSString *content = data.educationName;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 4) {
            
            NSString *content = data.eduMajor;
            
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
    CreateCVEducationExperienceData *data = self.viewData;
    
    if (data.entryEduDate.length > 0) {
        
        [params setObject:data.entryEduDate forKey:@"entryEduDate"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择入学时间" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.endEduDate.length > 0) {
        
        [params setObject:data.endEduDate forKey:@"endEduDate"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择毕业时间" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.university.length > 0) {
        
        [params setObject:data.university forKey:@"university"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请输入毕业院校" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.educationName.length > 0) {
        
        [params setObject:data.educationName forKey:@"educationName"];
        [params setObject:data.education forKey:@"education"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择学历" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.eduMajor.length > 0) {
        
        [params setObject:data.eduMajor forKey:@"eduMajor"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请输入所学专业" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.eduExpId.length > 0) {
        
        [params setObject:data.eduExpId forKey:@"eduExpId"];
        
    } else {
        
        [params setObject:@"" forKey:@"eduExpId"];
        
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate          *entryEduDate      = [formatter dateFromString:data.entryEduDate];
    NSTimeInterval   _entryEduDate     = [entryEduDate timeIntervalSince1970] *1;
    
    NSDate          *endEduDate      = [formatter dateFromString:data.endEduDate];
    NSTimeInterval   _endEduDate     = [endEduDate timeIntervalSince1970] *1;
    
    if (_endEduDate - _entryEduDate <= 0) {
        
        [MBProgressHUD showMessageTitle:@"入学时间与毕业时间顺序不符，请重新选择" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    [params setObject:data.CVId forKey:@"CVId"];
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [AddEducationExperienceViewModel requestPost_addEduExpWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [MBProgressHUD showMessageTitle:@"保存成功" toView:self.view afterDelay:1.5f];
        int64_t delayInSeconds = 1.6f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            self.addEducationExperienceSucces(YES);
            [self.navigationController popViewControllerAnimated:YES];
            
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
    
    if (row == 0) {
        
        age_tag = 0;
        [self.chooseTypeView showChooseTypeViewWithType:age_view];
        
    } else if (row == 1) {
        
        age_tag = 1;
        [self.chooseTypeView showChooseTypeViewWithType:age_view];
        
    } else if (row == 3) {
        
        [self.chooseTypeView showChooseTypeViewWithType:education_view];
        
    }
    
}

- (void) getTextFieldText:(NSString *)text forRow:(NSInteger)row; {
    
    CreateCVEducationExperienceData *data = self.viewData;
    
    if (text.length > 0) {
        
        if (row == 2) {
            
            data.university = text;
            
        } else if (row == 4) {
            
            data.eduMajor = text;
            
        }
        
    }
    
    self.viewData = data;
    
}

- (void)showCellErrorMessage {
    
    [MBProgressHUD showMessageTitle:@"请输入长度不超过14字的内容" toView:self.view afterDelay:1.f];
    
}

#pragma mark - EdiUserInfomationChooseTypeViewDelegate
- (void) chooseYearDate:(NSString *)yearString
            monthString:(NSString *)monthString
              dayString:(NSString *)dayString; {
    
    CreateCVEducationExperienceData *data = self.viewData;
    
    if (yearString.length > 0 && monthString.length > 0 && dayString.length > 0) {
        
        if (age_tag == 0) {
            
            data.entryEduDate = [NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];
            
        } else {
            
            data.endEduDate = [NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];
            
        }
        
    }
    
    self.viewData = data;
    [self loadTableViewData];
    
}

- (void) chooseJobTypeWithData:(id)data forViewType:(EChooseJobTypeType)viewType; {
    
    CreateCVEducationExperienceData *model = self.viewData;
    NSDictionary *tmpData = data;
    NSString *title   = tmpData[@"title"];
    NSString *titleId = tmpData[@"titleId"];
    
    if (title.length > 0) {
        
        model.educationName = title;
        model.education     = titleId;
        
    }
    
    self.viewData = model;
    [self loadTableViewData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
