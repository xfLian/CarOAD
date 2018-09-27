//
//  OADAddJobExperiencesViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADAddJobExperiencesViewController.h"

#import "AddJobIntensionViewModel.h"
#import "CreateCVJobexperiencesData.h"

#import "AddJobIntensionCell.h"
#import "AddJobExperiencesCell.h"
#import "EdiUserInfomationChooseTypeView.h"

@interface OADAddJobExperiencesViewController ()<EdiUserInfomationChooseTypeViewDelegate, AddJobIntensionCellDelegate, AddJobExperiencesCellDelegate>
{
    
    NSInteger age_tag;  //  0.入职时间  1.离职时间
    
}
@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) EdiUserInfomationChooseTypeView *chooseTypeView;
@property (nonatomic, strong) CreateCVJobexperiencesData *viewData;

@end

@implementation OADAddJobExperiencesViewController

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
    
    self.navTitle     = @"工作经验";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void) initialization {
    
    self.datasArray = [NSMutableArray array];
    
    {
        
        NSDictionary *model = @{@"title":@"店铺名称",
                                @"placeholder":@"请输入店铺名称",
                                @"content":@"",
                                @"isShowButton":@"0"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"在岗职位",
                                @"placeholder":@"请输入您的在岗职位",
                                @"content":@"",
                                @"isShowButton":@"0"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"入职时间",
                                @"placeholder":@"请选择您的入职时间",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"离职时间",
                                @"placeholder":@"请选择您的离职时间",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"工作内容",
                                @"placeholder":@"请填写您的工作内容",
                                @"content":@"",
                                @"isShowButton":@"0"
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
        
        CreateCVJobexperiencesData *data = self.viewData;
        if (i == 0) {
            
            NSString *content = data.shopName;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 1) {
            
            NSString *content = data.skillPost;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 2) {
            
            NSString *content = data.entryDate;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 3) {
            
            NSString *content = data.quitDate;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 4) {
            
            NSString *content = data.workContent;
            
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
    [AddJobExperiencesCell registerToTableView:self.tableView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(10 *Scale_Height, 0, 0, 0);
    self.tableView.tableFooterView = [self creatFooterView];
    
}

- (UIView *) creatFooterView {
    
    UIView *footerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height)];
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
    CreateCVJobexperiencesData *data = self.viewData;
    
    if (data.shopName.length > 0) {
        
        [params setObject:data.shopName forKey:@"shopName"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请输入店铺名称" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.skillPost.length > 0) {
        
        [params setObject:data.skillPost forKey:@"skillPost"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请输入您的在岗职位" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.entryDate.length > 0) {
        
        [params setObject:data.entryDate forKey:@"entryDate"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择您的入职时间" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.quitDate.length > 0) {
        
        [params setObject:data.quitDate forKey:@"quitDate"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择您的离职时间" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.workContent.length > 0) {
        
        [params setObject:data.workContent forKey:@"workContent"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请填写您的工作内容" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (data.workExpId.length > 0) {
        
        [params setObject:data.workExpId forKey:@"workExpId"];
        
    } else {
        
        [params setObject:@"" forKey:@"workExpId"];
        
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate          *entryDate      = [formatter dateFromString:data.entryDate];
    NSTimeInterval   _entryDate     = [entryDate timeIntervalSince1970] *1;
    
    NSDate          *quitDate      = [formatter dateFromString:data.quitDate];
    NSTimeInterval   _quitDate     = [quitDate timeIntervalSince1970] *1;
    
    if (_quitDate - _entryDate <= 0) {
        
        [MBProgressHUD showMessageTitle:@"入职时间与离职时间顺序不符，请重新选择" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    [params setObject:data.CVId forKey:@"CVId"];
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [AddJobIntensionViewModel requestPost_addWorkExpNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [MBProgressHUD showMessageTitle:@"保存成功" toView:self.view afterDelay:1.f];
        int64_t delayInSeconds = 1.2f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            self.addJobExpSucces(YES);
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
    
    if (indexPath.row == 4) {
        
        return 170 *Scale_Height;
        
    } else {
        
        return 45 *Scale_Height;
        
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < 4) {
        
        AddJobIntensionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddJobIntensionCell" forIndexPath:indexPath];
        cell.selectionStyle       = UITableViewCellSelectionStyleNone;
        cell.row                  = indexPath.row;
        cell.delegate             = self;
        
        if (self.datasArray.count > 0) {
            
            cell.data = self.datasArray[indexPath.row];
            [cell loadContent];
            
        }
        
        return cell;
        
    } else {
        
        AddJobExperiencesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddJobExperiencesCell" forIndexPath:indexPath];
        cell.selectionStyle       = UITableViewCellSelectionStyleNone;
        cell.row                  = indexPath.row;
        cell.delegate             = self;
        
        if (self.datasArray.count > 0) {
            
            cell.data = self.datasArray[indexPath.row];
            [cell loadContent];
            
        }
        
        return cell;
        
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

#pragma mark - AddJobIntensionCellDelegate
- (void) clickGetJobInfoWithRow:(NSInteger)row; {
    
    if (row == 2) {
        
        age_tag = 0;
        [self.chooseTypeView showChooseTypeViewWithType:age_view];
        
    } else if (row == 3) {
        
        age_tag = 1;
        [self.chooseTypeView showChooseTypeViewWithType:age_view];
        
    }
    
}

- (void) getTextFieldText:(NSString *)text forRow:(NSInteger)row; {
    
    CreateCVJobexperiencesData *data = self.viewData;

    if (text.length > 0) {
        
        if (row == 0) {
            
            data.shopName = text;
            
        } else if (row == 1) {
            
            data.skillPost = text;
            
        }
        
    }
    
    self.viewData = data;
    
}

- (void)showCellErrorMessage {
    
    [MBProgressHUD showMessageTitle:@"请输入长度不超过14字的内容" toView:self.view afterDelay:1.f];
    
}

#pragma mark - AddJobExperiencesCellDelegate
- (void) getTextViewText:(NSString *)text forRow:(NSInteger)row; {
    
    CreateCVJobexperiencesData *data = self.viewData;
    
    if (text.length > 0) {
        
        data.workContent = text;
        
    }
    
    self.viewData = data;
    
}

- (void) showErrorMessage:(NSString *)message; {
    
    [MBProgressHUD showMessageTitle:message toView:self.view afterDelay:1.5f];
    
}

#pragma mark - EdiUserInfomationChooseTypeViewDelegate
- (void) chooseYearDate:(NSString *)yearString
            monthString:(NSString *)monthString
              dayString:(NSString *)dayString; {
    
    CreateCVJobexperiencesData *data = self.viewData;
    
    if (yearString.length > 0 && monthString.length > 0 && dayString.length > 0) {
        
        if (age_tag == 0) {
            
            data.entryDate = [NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];
            
        } else {
            
            data.quitDate = [NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];
            
        }
        
    }
    
    self.viewData = data;
    [self loadTableViewData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
