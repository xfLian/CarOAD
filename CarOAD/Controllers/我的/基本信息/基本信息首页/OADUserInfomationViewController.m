//
//  OADUserInfomationViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADUserInfomationViewController.h"

#import "UserInfomationDataModel.h"
#import "UserInfomationRootModel.h"

#import "UserInfomationHeaderView.h"
#import "UserInfomationEdiNameCell.h"
#import "UserInfomationEdiSexCell.h"
#import "UserInfomationEdiPhoneCell.h"
#import "UserInfomationEdiJobStatusCell.h"
#import "UserInfomationEdiOtherInfoCell.h"
#import "UserInfomationEdiSkillCell.h"
#import "EdiUserInfomationChooseTypeView.h"

#import "OADChangePhoneCodeViewController.h"

@interface OADUserInfomationViewController ()<UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UserInfomationHeaderViewDelegate, UserInfomationEdiNameCellDelegate, UserInfomationEdiSexCellDelegate, UserInfomationEdiPhoneCellDelegate, UserInfomationEdiJobStatusCellDelegate, UserInfomationEdiOtherInfoCellDelegate, UserInfomationEdiSkillCellDelegate, EdiUserInfomationChooseTypeViewDelegate>
{

    id        headerViewData;
    NSArray  *uploadImagesArray;

}

@property (nonatomic, strong) UserInfomationData *userInfoData;

@property (nonatomic, strong) UserInfomationHeaderView *headerView;
@property (nonatomic, strong) UIImageView   *headerBackImageView;
@property (nonatomic, strong) UIView        *navigationBackView;
@property (nonatomic, strong) UIView        *navigationMaskView;
@property (nonatomic, strong) UILabel       *navigationTitleLabel;

@property (nonatomic, strong) EdiUserInfomationChooseTypeView *chooseTypeView;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSMutableArray      *datasArray;

@end

@implementation OADUserInfomationViewController

- (EdiUserInfomationChooseTypeView *)chooseTypeView {

    if (!_chooseTypeView) {

        _chooseTypeView          = [[EdiUserInfomationChooseTypeView alloc] init];
        _chooseTypeView.delegate = self;
    }

    return _chooseTypeView;

}

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

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;

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

    CGRect frame      = self.tableView.frame;
    frame.size.height = self.contentView.height - frameOfKeyboard.size.height;

    [UIView animateWithDuration:duration delay:0 options:option animations:^{

        self.tableView.frame = frame;

    } completion:^(BOOL finished) {

    }];

}

- (void) hideKeyboard:(NSNotification *)notification {

    NSTimeInterval duration       = \
    [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = \
    [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];

    CGRect frame      = self.tableView.frame;
    frame.size.height = self.contentView.height;

    [UIView animateWithDuration:duration delay:0 options:option animations:^{

        self.tableView.frame = frame;

    } completion:^(BOOL finished) {

    }];

}

- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    self.navigationController.navigationBarHidden = NO;

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createNavigationView];

    [self initialization];

}

- (void) initialization {

    [MBProgressHUD showMessage:nil toView:self.view];

    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    NSDictionary   *params      = @{@"userId":accountInfo.user_id};

    [UserInfomationDataModel requestPost_getUserInfoNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        CarOadLog(@"info --- %@",info);

        UserInfomationRootModel *rootModel = [[UserInfomationRootModel alloc] initWithDictionary:info];
        UserInfomationData      *data      = rootModel.data[0];
        self.userInfoData                  = data;

        NSString *userImage  = data.userImg;
        self.headerView.data = userImage;

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.headerView loadContent];
            [self.tableView reloadData];

        });

    } error:^(NSString *errorMessage) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.5f];

    }];

}

- (void) createNavigationView {

    UIView *navigationBackView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, SafeAreaTopHeight)];
    navigationBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:navigationBackView];
    self.navigationBackView = navigationBackView;
    
    UIView *navigationMaskView         = [[UIView alloc]initWithFrame:navigationBackView.bounds];
    navigationMaskView.backgroundColor = MainColor;
    [navigationBackView addSubview:navigationMaskView];
    self.navigationMaskView = navigationMaskView;
    self.navigationMaskView.hidden = YES;

    {

        UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@""
                                                  font:[UIFont fontWithName:@"STHeitiSC-Medium" size:17.f]
                                             textColor:[UIColor whiteColor]
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];
        [self.view addSubview:label];

        [label sizeToFit];
        label.center = CGPointMake(navigationMaskView.width / 2, navigationMaskView.height - 22);
        self.navigationTitleLabel = label;

    }

    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, SafeAreaTopHeight - 44, 44, 44)
                                            buttonType:kButtonNormal
                                                 title:nil
                                                 image:[UIImage imageNamed:@"arrow_backnav"]
                                              higImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    button.backgroundColor = [UIColor clearColor];
    [self.view addSubview:button];

}

- (void)setNavigationController {

    [super setNavigationController];

}

- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        [self.navigationController popViewControllerAnimated:YES];

    } else if (sender.tag == 2000) {

        if (self.userInfoData.userImg.length <= 0 && uploadImagesArray.count <= 0) {

            [MBProgressHUD showMessageTitle:@"请添加您的头像" toView:self.view afterDelay:1.5f];
            return;

        } else {

            if (self.userInfoData.userImg.length > 0) {

                [self.params setObject:self.userInfoData.userImg forKey:@"userImg"];

            }

        }

        if (self.userInfoData.userName.length <= 0) {

            [MBProgressHUD showMessageTitle:@"请添加您的姓名" toView:self.view afterDelay:1.5f];
            return;

        } else {

            [self.params setObject:self.userInfoData.userName forKey:@"userName"];

        }

        if (self.userInfoData.userSex.length <= 0) {

            [MBProgressHUD showMessageTitle:@"请选择您的性别" toView:self.view afterDelay:1.5f];
            return;

        } else {

            [self.params setObject:self.userInfoData.userSex forKey:@"userSex"];

        }

        if (self.userInfoData.phone.length <= 0) {

            [MBProgressHUD showMessageTitle:@"请添加您的手机号码" toView:self.view afterDelay:1.5f];
            return;

        } else {

            if (self.userInfoData.phoneIdenti.length > 0) {

                if ([self.userInfoData.phoneIdenti isEqualToString:@"N"]) {

                    [MBProgressHUD showMessageTitle:@"请验证您的手机号码" toView:self.view afterDelay:1.5f];
                    return;

                } else {

                    [self.params setObject:self.userInfoData.phone forKey:@"phone"];

                }


            } else {

                [MBProgressHUD showMessageTitle:@"请验证您的手机号码" toView:self.view afterDelay:1.5f];
                return;

            }

        }

        if (self.userInfoData.applyStateId.length <= 0) {

            [MBProgressHUD showMessageTitle:@"请选择您的求职状态" toView:self.view afterDelay:1.5f];
            return;

        } else {

            [self.params setObject:self.userInfoData.applyStateId forKey:@"applyState"];

        }

        if (self.userInfoData.areaId.length <= 0 || self.userInfoData.area.length <= 0) {

            [MBProgressHUD showMessageTitle:@"请选择您的所在区域" toView:self.view afterDelay:1.5f];
            return;

        } else {

            [self.params setObject:self.userInfoData.provinceId forKey:@"provinceId"];
            [self.params setObject:self.userInfoData.cityId forKey:@"cityId"];
            [self.params setObject:self.userInfoData.areaId forKey:@"areaId"];

        }

        if (self.userInfoData.birthDate.length <= 0) {

            [MBProgressHUD showMessageTitle:@"请选择您的出生年月" toView:self.view afterDelay:1.5f];
            return;

        } else {

            [self.params setObject:self.userInfoData.birthDate forKey:@"birthDate"];

        }

        if (self.userInfoData.topEduId.length <= 0) {

            [MBProgressHUD showMessageTitle:@"请选择您的最高学历" toView:self.view afterDelay:1.5f];
            return;

        } else {

            [self.params setObject:self.userInfoData.topEduId forKey:@"topEdu"];

        }

        if (self.userInfoData.toYearId.length <= 0) {

            [MBProgressHUD showMessageTitle:@"请选择您的工作年限" toView:self.view afterDelay:1.5f];
            return;

        } else {

            [self.params setObject:self.userInfoData.toYearId forKey:@"toYear"];

        }

        if (self.userInfoData.selfMemo.length <= 0) {

            [MBProgressHUD showMessageTitle:@"请选择您的擅长技能" toView:self.view afterDelay:1.5f];
            return;

        } else {

            [self.params setObject:self.userInfoData.selfMemo forKey:@"adeptSkill"];

        }
        
        OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];

        if (accountInfo.user_id) {

            [self.params setObject:accountInfo.user_id forKey:@"userId"];

        }

        [MBProgressHUD showMessage:nil toView:self.view];
        
        __weak OADUserInfomationViewController *weakSelf = self;
        
        if (uploadImagesArray.count > 0) {

            [OSSImageUploader asyncUploadImages:uploadImagesArray complete:^(NSArray<NSString *> *names, UploadImageState state) {
                
                if (state == UploadImageFailed) {

                    [MBProgressHUD showMessageTitle:@"照片上传失败，请重新上传" toView:weakSelf.view afterDelay:1.5f];
                    
                } else {

                    NSString *imageString = [names componentsJoinedByString:@","];

                    [weakSelf.params setObject:imageString forKey:@"userImg"];
                    
                    [UserInfomationDataModel requestPost_publishUserInfoNetWorkingDataWithParams:weakSelf.params success:^(id info, NSInteger count) {
                        
                        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                        [MBProgressHUD showMessageTitle:@"保存成功" toView:self.view afterDelay:1.f];
                        int64_t delayInSeconds = 1.2f;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            
                            weakSelf.isNeedLoadCVData(YES);
                            //  保存用户数据
                            [weakSelf.navigationController popViewControllerAnimated:YES];
                            
                        });
                        
                    } error:^(NSString *errorMessage) {

                        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

                    } failure:^(NSError *error) {

                        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                        [MBProgressHUD showMessageTitle:@"保存失败" toView:self.view afterDelay:1.5f];
                        
                    }];
                    
                }
                
            }];
            
        } else {
            
            CarOadLog(@"self.params --- %@",self.params);

            [UserInfomationDataModel requestPost_publishUserInfoNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {

                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"保存成功" toView:self.view afterDelay:1.5f];
                int64_t delayInSeconds = 1.6f;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

                    //  保存用户数据
                    [self.navigationController popViewControllerAnimated:YES];

                });

            } error:^(NSString *errorMessage) {

                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

            } failure:^(NSError *error) {

                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"保存失败" toView:self.view afterDelay:1.5f];

            }];

        }

    }

}

- (UIView *) creatHeaderView {
    
    self.headerView                 = [[UserInfomationHeaderView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 130 *Scale_Height + SafeAreaTopHeight)];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.headerView.delegate        = self;
    
    return self.headerView;

}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.headerBackImageView                 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 130 *Scale_Height + SafeAreaTopHeight)];
    self.headerBackImageView.image           = [UIImage imageNamed:@""];
    self.headerBackImageView.contentMode     = UIViewContentModeScaleAspectFill;
    self.headerBackImageView.clipsToBounds   = YES;
    self.headerBackImageView.backgroundColor = MainColor;
    [self.backView addSubview:self.headerBackImageView];
    
    self.backView.backgroundColor    = BackGrayColor;
    self.contentView.frame           = CGRectMake(0, 0, Screen_Width, self.view.height);
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.tableView.frame           = self.contentView.bounds;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [self creatHeaderView];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, -SafeAreaBottomHeight, 0)];
    
    [UserInfomationEdiNameCell registerToTableView:self.tableView];
    [UserInfomationEdiSexCell registerToTableView:self.tableView];
    [UserInfomationEdiPhoneCell registerToTableView:self.tableView];
    [UserInfomationEdiJobStatusCell registerToTableView:self.tableView];
    [UserInfomationEdiOtherInfoCell registerToTableView:self.tableView];
    [UserInfomationEdiSkillCell registerToTableView:self.tableView];
    
    self.tableView.tableHeaderView = [self creatHeaderView];

}

#pragma mark - ScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat yOffset = self.tableView.contentOffset.y;

    NSDictionary *headerModel = headerViewData;
    NSString     *userName    = headerModel[@"userName"];

    if (yOffset >= 130 *Scale_Height) {

        self.navigationBackView.hidden = NO;
        self.navigationMaskView.hidden = NO;
        self.headerBackImageView.frame = CGRectMake(0, -yOffset, Screen_Width, 130 *Scale_Height + SafeAreaTopHeight);

        if (userName.length > 0) {

            self.navigationTitleLabel.text = userName;

        } else {

            self.navigationTitleLabel.text = @"基本信息";

        }

        [self.navigationTitleLabel sizeToFit];
        self.navigationTitleLabel.center = CGPointMake(self.navigationBackView.width / 2, self.navigationBackView.height - 22);

    }else {

        self.navigationBackView.hidden = YES;
        self.navigationMaskView.hidden = YES;
        self.headerBackImageView.frame = CGRectMake(0, 0, Screen_Width, -yOffset + 130 *Scale_Height + SafeAreaTopHeight);

        self.navigationTitleLabel.text = @"";
        [self.navigationTitleLabel sizeToFit];
        self.navigationTitleLabel.center = CGPointMake(self.navigationBackView.width / 2, self.navigationBackView.height - 22);

    }

}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.01;

}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return nil;

}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = BackGrayColor;
    if (section == 5) {

        backView.frame = CGRectMake(0, 0, Screen_Width, 60 *Scale_Height);

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, backView.width - 30 *Scale_Width, backView.height - 20 *Scale_Height)
                                                     title:@"保存"
                                           backgroundImage:nil
                                                       tag:2000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = MainColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 5 *Scale_Height;
        button.titleLabel.font     = UIFont_M_17;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backView addSubview:button];
        
    } else {

        backView.frame = CGRectMake(0, 0, Screen_Width, 10 *Scale_Height);

    }

    return backView;

}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 5) {

        return  60 *Scale_Height;

    } else {

        return  10 *Scale_Height;

    }

}

//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 6;
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;

}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 5) {

        return  140 *Scale_Height;

    } else {

        return  60 *Scale_Height;

    }

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

        UserInfomationEdiNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfomationEdiNameCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate       = self;

        cell.data = self.userInfoData.userName;

        [cell loadContent];
        return cell;

    } else if (indexPath.section == 1) {

        UserInfomationEdiSexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfomationEdiSexCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate       = self;

        cell.data = self.userInfoData.userSex;

        [cell loadContent];
        return cell;

    } else if (indexPath.section == 2) {

        UserInfomationEdiPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfomationEdiPhoneCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate       = self;

        cell.data        = self.userInfoData.phone;
        cell.phoneIdenti = self.userInfoData.phoneIdenti;

        [cell loadContent];

        return cell;

    } else if (indexPath.section == 3) {

        UserInfomationEdiJobStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfomationEdiJobStatusCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate       = self;

        cell.data = self.userInfoData.applyState;

        [cell loadContent];

        return cell;

    } else if (indexPath.section == 4) {

        UserInfomationEdiOtherInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfomationEdiOtherInfoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate       = self;

        cell.userAddress        = self.userInfoData.area;
        cell.userBirthday       = self.userInfoData.birthDate;
        cell.userEducation      = self.userInfoData.topEdu;
        cell.userWorkExperience = self.userInfoData.toYear;
        
        [cell loadContent];
        
        return cell;
        
    } else {
        
        UserInfomationEdiSkillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfomationEdiSkillCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate       = self;
        
        cell.data = self.userInfoData.selfMemo;
        
        [cell loadContent];
        
        return cell;
        
    }
    
}

#pragma mark - UserInfomationHeaderViewDelegate
- (void) ediUserImage; {

    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.allowsEditing = YES;
    pickerController.delegate      = self;

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"拍照或选择照片" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

        //  设置相册呈现的样式
        pickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;//图片分组列表样式

        //  使用模态呈现相册
        [self presentViewController:pickerController animated:YES completion:^{

        }];


    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"从系统相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

        //  设置相册呈现的样式
        pickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;//图片分组列表样式

        //  使用模态呈现相册
        [self presentViewController:pickerController animated:YES completion:^{

        }];

    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];

    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - EdiUserInfomationChooseTypeViewDelegate
- (void) chooseJobTypeWithData:(id)data forViewType:(EChooseJobTypeType)viewType; {

    NSDictionary *titleDic = data;
    if (viewType == job_status_view) {

        NSString *applyStateId = titleDic[@"titleId"];
        NSString *applyState   = titleDic[@"title"];
        self.userInfoData.applyState = applyState;
        self.userInfoData.applyStateId = applyStateId;

        NSIndexSet *indexPath = [[NSIndexSet alloc] initWithIndex:3];
        [self.tableView reloadSections:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];

    } else if (viewType == education_view) {

        NSString *topEduId = titleDic[@"titleId"];
        NSString *topEdu   = titleDic[@"title"];
        self.userInfoData.topEdu = topEdu;
        self.userInfoData.topEduId = topEduId;

        NSIndexSet *indexPath = [[NSIndexSet alloc] initWithIndex:4];
        [self.tableView reloadSections:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];

    } else if (viewType == work_experience_view) {

        NSString *toYearId = titleDic[@"titleId"];
        NSString *toYear   = titleDic[@"title"];
        self.userInfoData.toYear = toYear;
        self.userInfoData.toYearId = toYearId;

        NSIndexSet *indexPath = [[NSIndexSet alloc] initWithIndex:4];
        [self.tableView reloadSections:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }

}

- (void) getSelectedProvinceData:(NSDictionary *)provinceData
                        cityData:(NSDictionary *)cityData
                        areaData:(NSDictionary *)areaData; {

    NSString *provinceId = provinceData[@"provinceid"];
    NSString *cityId     = cityData[@"cityid"];
    NSString *areaId     = areaData[@"areaId"];

    if (provinceId.length > 0 && cityId.length > 0 && areaId.length > 0) {

        self.userInfoData.provinceId = provinceId;
        self.userInfoData.cityId = cityId;
        self.userInfoData.areaId = areaId;

        NSString *province = provinceData[@"province"];
        NSString *city     = cityData[@"city"];
        NSString *area     = areaData[@"area"];
        self.userInfoData.province = province;
        self.userInfoData.city = city;
        self.userInfoData.area = area;

        NSIndexSet *indexPath = [[NSIndexSet alloc] initWithIndex:4];
        [self.tableView reloadSections:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];

    }

}

- (void) chooseYearDate:(NSString *)yearString
            monthString:(NSString *)monthString
              dayString:(NSString *)dayString; {

    if (yearString.length > 0 && monthString.length > 0 && dayString.length > 0) {

        NSString *birthDate = [NSString stringWithFormat:@"%@-%@",yearString,monthString];
        self.userInfoData.birthDate = birthDate;

        NSIndexSet *indexPath = [[NSIndexSet alloc] initWithIndex:4];
        [self.tableView reloadSections:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];

    }

}

#pragma mark - UserInfomationEdiNameCellDelegate
- (void) getUserNameString:(NSString *)userName; {

    self.userInfoData.userName = userName;

}

#pragma mark - UserInfomationEdiSexCellDelegate
- (void) getUserSexString:(NSString *)userSex; {

    self.userInfoData.userSex = userSex;

}

#pragma mark - UserInfomationEdiPhoneCellDelegate
- (void) chooseUserPhoneWithPhoneString:(NSString *)phoneString; {

    __weak OADUserInfomationViewController *weakSelf = self;
    OADChangePhoneCodeViewController *viewController = [OADChangePhoneCodeViewController new];
    viewController.changePhone = ^(BOOL isSuccessForPhoneAccreditation, NSString *userPhone) {

        if (isSuccessForPhoneAccreditation == YES) {

            weakSelf.userInfoData.phone = userPhone;
            weakSelf.userInfoData.phoneIdenti = @"Y";
            NSIndexSet *indexPath = [[NSIndexSet alloc] initWithIndex:2];
            [weakSelf.tableView reloadSections:indexPath withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }

    };
    [self.navigationController pushViewController:viewController animated:YES];

}

#pragma mark - UserInfomationEdiJobStatusCellDelegate
- (void) chooseUserJobStatus; {

    [self.chooseTypeView showChooseTypeViewWithType:job_status_view];

}

#pragma mark - UserInfomationEdiOtherInfoCellDelegate
- (void) chooseUserAddressWithData:(id)data;{

    [self.chooseTypeView showChooseTypeViewWithType:address_view];

}

- (void) chooseUserBirthdayWithData:(id)data;{

    [self.chooseTypeView showChooseTypeViewWithType:age_view];
    
}

- (void) chooseUserEducationWithData:(id)data;{

    [self.chooseTypeView showChooseTypeViewWithType:education_view];

}

- (void) chooseUserWorkExperienceWithData:(id)data; {

    [self.chooseTypeView showChooseTypeViewWithType:work_experience_view];

}

#pragma mark - UserInfomationEdiSkillCellDelegate
- (void) getUserSkillString:(NSString *)userSkill; {

    self.userInfoData.selfMemo = userSkill;

}

- (void) showErrorMessage:(NSString *)message; {

    [MBProgressHUD showMessageTitle:message toView:self.view afterDelay:1.5f];

}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];

    NSMutableArray *tmpImageArray = [NSMutableArray array];
    [tmpImageArray addObject:resultImage];

    uploadImagesArray = [tmpImageArray copy];

    self.headerView.data = resultImage;
    [self.headerView loadContent];

    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
