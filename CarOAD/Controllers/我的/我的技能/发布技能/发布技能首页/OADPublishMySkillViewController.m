//
//  OADPublishMySkillViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADPublishMySkillViewController.h"
#import "PublishMySkillViewModel.h"
#import "PublishMySkillData.h"
#import "MYSkillDetailesViewModel.h"
#import "MYSkillDetailesRootModel.h"

#import "AddJobIntensionCell.h"
#import "AddJobExperiencesCell.h"
#import "EdiUserInfomationChooseTypeView.h"

#import "OADPublishMySkillChoosePhotoViewController.h"
#import "OADMyLocationViewController.h"

@interface OADPublishMySkillViewController ()<EdiUserInfomationChooseTypeViewDelegate, AddJobIntensionCellDelegate, AddJobExperiencesCellDelegate>
{
    
    NSInteger age_tag;  //  0.入职时间  1.离职时间
    BOOL textViewIsFirstResponder;
    
}
@property (nonatomic, strong) UIImageView    *headerImageView;
@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) EdiUserInfomationChooseTypeView *chooseTypeView;
@property (nonatomic, strong) PublishMySkillData *viewData;

@end

@implementation OADPublishMySkillViewController

- (EdiUserInfomationChooseTypeView *)chooseTypeView {
    
    if (!_chooseTypeView) {
        
        _chooseTypeView          = [[EdiUserInfomationChooseTypeView alloc] init];
        _chooseTypeView.delegate = self;
    }
    
    return _chooseTypeView;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(openKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

#pragma mark - 通知方法
/**
 *
 *  键盘弹起时执行该方法
 *
 *  修改tmpSubView的位置到键盘之上
 *
 */
- (void) openKeyboard:(NSNotification *)notification {
    
    CGRect frameOfKeyboard        = \
    [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration       = \
    [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = \
    [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    if (textViewIsFirstResponder == YES) {
        
        CGRect frame      = self.tableView.frame;
        frame.size.height = self.contentView.height - frameOfKeyboard.size.height;
        
        [UIView animateWithDuration:duration delay:0 options:option animations:^{
            
            self.tableView.frame = frame;
            
        } completion:^(BOOL finished) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:6 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            textViewIsFirstResponder = NO;
            
        }];
        
    }
    
}

- (void) hideKeyboard:(NSNotification *)notification {
    
    NSTimeInterval duration       = \
    [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = \
    [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        
        self.tableView.frame = self.contentView.bounds;
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewData = self.data;
    [self initialization];

}

- (void)setNavigationController {
    
    self.navTitle     = @"发布技能";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void) initialization {
    
    self.datasArray = [NSMutableArray array];
    
    {
        
        NSDictionary *model = @{@"title":@"服务名称",
                                @"placeholder":@"请输入服务名称",
                                @"content":@"",
                                @"isShowButton":@"0"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"价       格",
                                @"placeholder":@"请选输入服务价格，1-10000之间",
                                @"content":@"",
                                @"isShowButton":@"0",
                                @"isPhoneKey":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"单       位",
                                @"placeholder":@"请选择单位",
                                @"content":@"",
                                @"isShowButton":@"1",
                                @"isPhoneKey":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"服务类型",
                                @"placeholder":@"请选择服务类型",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"服务范围",
                                @"placeholder":@"请选择服务范围",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"我的位置",
                                @"placeholder":@"请选择我的位置",
                                @"content":@"",
                                @"isShowButton":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"服务内容",
                                @"placeholder":@"清晰准确的描述有助于用户了解你的服务",
                                @"content":@"",
                                @"isShowButton":@"0"
                                };
        [self.datasArray addObject:model];
        
    }
    
    if (self.viewData.skillId.length > 0) {
        
        NSDictionary *params = @{@"skillId" : self.viewData.skillId};
        
        [MBProgressHUD showMessage:nil toView:self.view];
        
        [MYSkillDetailesViewModel requestPost_getSkillInfoNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
                        
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            int64_t delayInSeconds = 0.25f;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                //  获取用户数据
                MYSkillDetailesRootModel *model = [[MYSkillDetailesRootModel alloc] initWithDictionary:info];
                
                PublishMySkillData *data = [PublishMySkillData getMySkillDataWithData:model.data[0]];
                self.viewData            = data;
                [self loadTableViewData];
                
            });
            
        } error:^(NSString *errorMessage) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];
            
        } failure:^(NSError *error) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];
            
        }];
        
    } else {
        
        [self loadTableViewData];
        
    }
    
}

- (void) loadTableViewData {
    
    NSMutableArray *datasArray = [NSMutableArray array];
    
    for (int i = 0; i < self.datasArray.count; i++) {
        
        NSMutableDictionary *model = [[NSMutableDictionary alloc] init];
        
        NSDictionary *tmpModel = self.datasArray[i];
        model = [tmpModel mutableCopy];
        
        PublishMySkillData *data = self.viewData;
        
        if (data.headerImage) {
            
            self.headerImageView.image = data.headerImage;
            
        } else {
            
            if (data.skillImg.length > 0) {
                
                NSArray *imageStringArray = [data.skillImg componentsSeparatedByString:@","];
                
                [QTDownloadWebImage downloadImageForImageView:self.headerImageView
                                                     imageUrl:[NSURL URLWithString:imageStringArray[0]]
                                             placeholderImage:@"photo_back_image"
                                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                         
                                                     }
                                                      success:^(UIImage *finishImage) {
                                                          
                                                      }];
                
            } else {
                
                self.headerImageView.image = [UIImage imageNamed:@"photo_back_image"];
                
            }
            
        }
        
        if (i == 0) {
            
            NSString *content = data.skillTitle;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 1) {
            
            NSString *content = data.price;
            
            if (content.length > 0) {
                
                [model setObject:[NSString stringWithFormat:@"¥ %@",content] forKey:@"content"];
                
            } else {
                
                [model setObject:@"¥ 0" forKey:@"content"];
                
            }
            
        } else if (i == 2) {
            
            NSString *content = data.unit;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 3) {
            
            NSString *content = data.categoryInfo;
            
            if (data.categoryInfo.length > 0) {
                
                content = data.categoryInfo;
                
            } else {
                
                content = data.skillType;
                
            }
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 4) {
            
            NSString *content = nil;
            
            if (data.province.length > 0 && data.city.length > 0) {
                
                content = [NSString stringWithFormat:@"%@ %@",data.province,data.city];
                
            } else {
                
                content = data.servereArea;
                
            }
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 5) {
            
            NSString *content = data.address;
            
            if (content.length > 0) {
                
                [model setObject:content forKey:@"content"];
                
            } else {
                
                [model setObject:@"" forKey:@"content"];
                
            }
            
        } else if (i == 6) {
            
            NSString *content = data.skillInfo;
            
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
    
    self.tableView.backgroundColor = BackGrayColor;
    
    [AddJobIntensionCell registerToTableView:self.tableView];
    [AddJobExperiencesCell registerToTableView:self.tableView];

    self.tableView.tableHeaderView = [self creatHeaderView];
    self.tableView.tableFooterView = [self creatFooterView];
    
}

- (UIView *) creatHeaderView {
    
    UIView *headerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Width / 2)];
    headerView.backgroundColor = BackGrayColor;

    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:headerView.bounds];
    iconImageView.contentMode  = UIViewContentModeScaleAspectFill;
    iconImageView.clipsToBounds = YES;
    iconImageView.backgroundColor = TextGrayColor;
    iconImageView.image           = [UIImage imageNamed:@"photo_back_image"];
    [headerView addSubview:iconImageView];
    self.headerImageView = iconImageView;
    
    UIButton *button = [UIButton createButtonWithFrame:headerView.bounds
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [headerView addSubview:button];
    
    return headerView;
    
}

- (UIView *) creatFooterView {
    
    UIView *footerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 70 *Scale_Height + SafeAreaBottomHeight)];
    footerView.backgroundColor = BackGrayColor;
    
    {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 20 *Scale_Height, footerView.width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"立即发布"
                                           backgroundImage:nil
                                                       tag:1001
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
    
    if (sender.tag == 1000) {
        
        __weak OADPublishMySkillViewController *weakSelf = self;
        PublishMySkillData *data = self.viewData;
        OADPublishMySkillChoosePhotoViewController *viewController = [OADPublishMySkillChoosePhotoViewController new];
        viewController.imageString = data.skillImg;
        viewController.addPhotoSuccess = ^(NSString *skillPhotoImageString) {
          
            PublishMySkillData *data = weakSelf.viewData;
            data.skillImg            = skillPhotoImageString;
            weakSelf.viewData = data;
            [weakSelf loadTableViewData];
            
        };
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else {
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        PublishMySkillData *data = self.viewData;
        
        if (data.skillImg.length > 0) {
            
            [params setObject:data.skillImg forKey:@"skillImg"];
            
        } else {
            
            [MBProgressHUD showMessageTitle:@"请上传服务图片" toView:self.view afterDelay:1.f];
            return;
            
        }
        
        if (data.skillTitle.length > 0) {
            
            [params setObject:data.skillTitle forKey:@"skillTitle"];
            
        } else {
            
            [MBProgressHUD showMessageTitle:@"请输入服务名称" toView:self.view afterDelay:1.f];
            return;
            
        }
        
        if (data.price.length > 0) {
            
            [params setObject:data.price forKey:@"price"];
            
        } else {
            
            [MBProgressHUD showMessageTitle:@"请输入服务价格" toView:self.view afterDelay:1.f];
            return;
            
        }
        
        if (data.unit.length > 0) {
            
            [params setObject:data.unit forKey:@"unit"];
            
        } else {
            
            [MBProgressHUD showMessageTitle:@"请输入单位" toView:self.view afterDelay:1.f];
            return;
            
        }
        
        if (data.skillType.length > 0) {
            
            [params setObject:data.skillType forKey:@"skillType"];
            
        } else {
            
            [MBProgressHUD showMessageTitle:@"请选择服务类型" toView:self.view afterDelay:1.f];
            return;
            
        }
        
        if (data.provinceId.length > 0 && data.cityId.length > 0 && data.areaId.length > 0) {
            
            [params setObject:data.provinceId forKey:@"provinceId"];
            [params setObject:data.cityId forKey:@"cityId"];
            [params setObject:data.areaId forKey:@"areaId"];
            
        } else {
            
            [MBProgressHUD showMessageTitle:@"请选择服务范围" toView:self.view afterDelay:1.f];
            return;
            
        }
        
        if (data.address.length > 0) {
            
            [params setObject:data.address forKey:@"address"];
            [params setObject:data.longitude forKey:@"longitude"];
            [params setObject:data.latitude forKey:@"latitude"];
            
        } else {
            
            [MBProgressHUD showMessageTitle:@"请选择我的位置" toView:self.view afterDelay:1.f];
            return;
            
        }
        
        if (data.skillInfo.length > 0) {
            
            [params setObject:data.skillInfo forKey:@"skillInfo"];
            
        } else {
            
            [MBProgressHUD showMessageTitle:@"请输入服务内容" toView:self.view afterDelay:1.f];
            return;
            
        }
        
        OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
        [params setObject:accountInfo.user_id forKey:@"userId"];
        
        if (data.skillId.length > 0) {
            
            [params setObject:data.skillId forKey:@"skillId"];
            
        } else {
            
            [params setObject:@"" forKey:@"skillId"];
            
        }
        
        [MBProgressHUD showMessage:nil toView:self.view];
        __weak OADPublishMySkillViewController *weakSelf = self;
        
        [PublishMySkillViewModel requestPost_publishSkillNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
    
            [MBProgressHUD showMessageTitle:@"保存成功" toView:self.view afterDelay:1.f];
            int64_t delayInSeconds = 1.2f;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                weakSelf.publishSkillSuccess(YES);
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
    
    if (indexPath.row == 6) {
        
        return 170 *Scale_Height;
        
    } else {
        
        return 45 *Scale_Height;
        
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < 6) {
        
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
        [self.chooseTypeView showChooseTypeViewWithType:unit_view];
        
    } else if (row == 3) {
        
        age_tag = 1;
        [self.chooseTypeView showChooseTypeViewWithType:sercice_type_view];
        
    } else if (row == 4) {
        
        age_tag = 2;
        [self.chooseTypeView showChooseTypeViewWithType:address_view];
        
    } else if (row == 5) {
        
        __weak OADPublishMySkillViewController *weakSelf = self;
        PublishMySkillData *data = self.viewData;
        OADMyLocationViewController *viewController = [OADMyLocationViewController new];
        viewController.getUserLocation = ^(AMapAddressData *locationData) {
            
            CLLocation *location = [[CLLocation alloc] initWithLatitude:locationData.location.latitude longitude:locationData.location.longitude];
            
            CLLocation *baidu_location = [location locationBaiduFromMars];
            
            if (locationData.address.length > 0) {
                
                data.address = locationData.address;
                
            }
            
            if (baidu_location.coordinate.latitude > 0) {
                
                data.latitude = [NSString stringWithFormat:@"%f",baidu_location.coordinate.latitude];
                
            }
            
            if (baidu_location.coordinate.longitude > 0) {
                
                data.longitude = [NSString stringWithFormat:@"%f",baidu_location.coordinate.longitude];
                
            }
            
            weakSelf.viewData = data;
            [weakSelf loadTableViewData];
            
        };
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

- (void) getTextFieldText:(NSString *)text forRow:(NSInteger)row; {
    
    PublishMySkillData *data = self.viewData;
    
    if (text.length > 0) {
        
        if (row == 0) {
            
            data.skillTitle = text;
            
        } else if (row == 1) {
            
            if ([text containsString:@"¥"]) {
                
                text = [text stringByReplacingOccurrencesOfString:@"¥" withString:@""];
                text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
                
            }
            
            data.price = text;
            
        }
        
    }
    
    self.viewData = data;
    [self loadTableViewData];
    
}

- (void)showCellErrorMessage {
    
    [MBProgressHUD showMessageTitle:@"请输入长度不超过14字的内容" toView:self.view afterDelay:1.f];
    
}

#pragma mark - AddJobExperiencesCellDelegate
- (void) getTextViewText:(NSString *)text forRow:(NSInteger)row; {
    
    PublishMySkillData *data = self.viewData;
    
    if (text.length > 0) {
        
        data.skillInfo = text;
        
    }
    
    self.viewData = data;
    
}

- (void) showErrorMessage:(NSString *)message; {
    
    [MBProgressHUD showMessageTitle:message toView:self.view afterDelay:1.5f];
    
}

- (void) textViewShouldBeginEditing; {
    
    textViewIsFirstResponder = YES;
    
}

#pragma mark - EdiUserInfomationChooseTypeViewDelegate
- (void) chooseJobTypeWithData:(id)data forViewType:(EChooseJobTypeType)viewType; {
    
    PublishMySkillData *model = self.viewData;
    NSString *title = data[@"title"];
    
    if (viewType == unit_view) {
        
        model.unit = title;
        
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
        
        PublishMySkillData *data = self.viewData;
        data.province = province;
        data.city = city;
        data.area = area;
        data.provinceId = provinceId;
        data.cityId = cityId;
        data.areaId = areaId;
        self.viewData = data;
        [self loadTableViewData];
        
    }
    
}

- (void) getSelectedCategoryData:(NSDictionary *)categoryData
                      catenaData:(NSDictionary *)catenaData
                   categoryInfoData:(NSDictionary *)categoryInfoData; {
    
    NSString *categoryId     = categoryData[@"categoryId"];
    NSString *catenaId       = catenaData[@"catenaId"];
    NSString *categoryInfoId = categoryInfoData[@"CategoryInfoId"];
    
    if (categoryId.length > 0 && catenaId.length > 0 && categoryInfoId.length > 0) {
        
        NSString *category     = categoryData[@"category"];
        NSString *catena       = catenaData[@"catena"];
        NSString *categoryInfo = categoryInfoData[@"CategoryInfo"];
        
        PublishMySkillData *data = self.viewData;
        data.category            = category;
        data.catena              = catena;
        data.categoryInfo        = categoryInfo;
        data.categoryId          = categoryId;
        data.catenaId            = catenaId;
        data.categoryInfoId      = categoryInfoId;
        data.skillType           = categoryInfoId;
        self.viewData            = data;
        [self loadTableViewData];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
