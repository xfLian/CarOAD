//
//  OADAddSkillsCertificateViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADAddSkillsCertificateViewController.h"

#import <Photos/Photos.h>

#import "AddSkillsCertificateViewModel.h"
#import "CreateCVSkillsCertificateData.h"

#import "AddSkillsCertificateCell.h"
#import "AddJobIntensionCell.h"
#import "EdiUserInfomationChooseTypeView.h"

@interface OADAddSkillsCertificateViewController ()<EdiUserInfomationChooseTypeViewDelegate, AddJobIntensionCellDelegate, AddSkillsCertificateCellDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    NSInteger  age_tag;  //  0.证书等级  1.技能等级
    NSArray   *tmpImageStringArray;
    
}
@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) EdiUserInfomationChooseTypeView *chooseTypeView;
@property (nonatomic, strong) CreateCVSkillsCertificateData *viewData;

@end

@implementation OADAddSkillsCertificateViewController

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
    
    self.navTitle     = @"技能证书";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void) initialization {
    
    self.datasArray = [NSMutableArray array];
    
    {
        
        NSDictionary *model = @{@"title":@"职业工种",
                                @"placeholder":@"请输入职业工种",
                                @"content":@"",
                                @"isShowButton":@"0",
                                @"isHideTypeLabel":@"0"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"证书等级",
                                @"placeholder":@"请选择证书等级",
                                @"content":@"",
                                @"isShowButton":@"1",
                                @"isHideTypeLabel":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"技能等级",
                                @"placeholder":@"请选择技能等级",
                                @"content":@"",
                                @"isShowButton":@"1",
                                @"isHideTypeLabel":@"1"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"获证日期",
                                @"placeholder":@"请选择获证日期",
                                @"content":@"",
                                @"isShowButton":@"1",
                                @"isHideTypeLabel":@"0"
                                };
        [self.datasArray addObject:model];
        
    }
    
    {
        
        NSDictionary *model = @{@"title":@"证书上传",
                                @"placeholder":@"",
                                @"content":@"",
                                @"isShowButton":@"0",
                                @"isHideTypeLabel":@"0"
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
        
        CreateCVSkillsCertificateData *data = self.viewData;
        if (i == 0) {

            NSString *content = data.skillCertName;

            if (content.length > 0) {

                [model setObject:content forKey:@"content"];

            } else {

                [model setObject:@"" forKey:@"content"];

            }

        } else if (i == 1) {

            NSString *content = data.certLevel;
            
            if (content.length > 0) {
                
                if ([content integerValue] == 1) {
                    
                    [model setObject:@"一级" forKey:@"content"];
                    
                } else if ([content integerValue] == 2) {
                    
                    [model setObject:@"二级" forKey:@"content"];
                    
                } else if ([content integerValue] == 3) {
                    
                    [model setObject:@"三级" forKey:@"content"];
                    
                }
  
            } else {

                [model setObject:@"" forKey:@"content"];

            }

        } else if (i == 2) {

            NSString *content = data.skillLevel;

            if (content.length > 0) {

                if ([content integerValue] == 1) {
                    
                    [model setObject:@"初级" forKey:@"content"];
                    
                } else if ([content integerValue] == 2) {
                    
                    [model setObject:@"中级" forKey:@"content"];
                    
                } else if ([content integerValue] == 3) {
                    
                    [model setObject:@"高级" forKey:@"content"];
                    
                }

            } else {

                [model setObject:@"" forKey:@"content"];

            }

        } else if (i == 3) {

            NSString *content = data.certDate;

            if (content.length > 0) {

                [model setObject:content forKey:@"content"];

            } else {

                [model setObject:@"" forKey:@"content"];

            }

        } else if (i == 4) {

            NSString *content = data.certImg;

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
    [AddSkillsCertificateCell registerToTableView:self.tableView];
    
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
 
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    CreateCVSkillsCertificateData *data = self.viewData;
    
    if (data.skillCertName.length > 0) {
        
        [params setObject:data.skillCertName forKey:@"skillCertName"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请输入职业工种" toView:self.view afterDelay:1.f];
        return;
        
    }
    
    if (data.certLevel.length > 0) {
        
        [params setObject:data.certLevel forKey:@"certLevel"];
        
    } else {
        
        [params setObject:@"" forKey:@"certLevel"];
        
    }
    
    if (data.skillLevel.length > 0) {
        
        [params setObject:data.skillLevel forKey:@"skillLevel"];
        
    } else {
        
        [params setObject:@"" forKey:@"skillLevel"];
        
    }
    
    if (data.certDate.length > 0) {
        
        [params setObject:data.certDate forKey:@"certDate"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择获证日期" toView:self.view afterDelay:1.f];
        return;
        
    }
    
    if (data.certImg.length > 0) {
        
        [params setObject:data.certImg forKey:@"certImg"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请添加证书图片" toView:self.view afterDelay:1.f];
        return;
        
    }
    
    if (data.skillCertId.length > 0) {
        
        [params setObject:data.skillCertId forKey:@"skillCertId"];
        
    } else {
        
        [params setObject:@"" forKey:@"skillCertId"];
        
    }
    
    [params setObject:data.CVId forKey:@"CVId"];
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [params setObject:accountInfo.user_id forKey:@"userId"];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [AddSkillsCertificateViewModel requestPost_addSkillCertWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
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
        
        return 160 *Scale_Height;
        
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
        
        AddSkillsCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddSkillsCertificateCell" forIndexPath:indexPath];
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
    
    if (row == 1) {
        
        age_tag = 0;
        [self.chooseTypeView showChooseTypeViewWithType:cert_level_view];
        
    } else if (row == 2) {
        
        age_tag = 1;
        [self.chooseTypeView showChooseTypeViewWithType:skill_level_view];
        
    } else if (row == 3) {
        
        [self.chooseTypeView showChooseTypeViewWithType:age_view];
        
    }
    
}

- (void) getTextFieldText:(NSString *)text forRow:(NSInteger)row; {
    
    CreateCVSkillsCertificateData *data = self.viewData;
    
    if (text.length > 0) {
        
        data.skillCertName = text;
        
    }
    
    self.viewData = data;
    
}

- (void)showCellErrorMessage {
    
    [MBProgressHUD showMessageTitle:@"请输入长度不超过14字的内容" toView:self.view afterDelay:1.f];
    
}

#pragma mark - AddJobExperiencesCellDelegate
- (void) addImageWithImageStringArray:(NSArray *)imageStringArray; {
    
    tmpImageStringArray = imageStringArray;
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

- (void) deleteImageWithImageStringArray:(NSArray *)imageStringArray; {
    
    CreateCVSkillsCertificateData *data = self.viewData;
    if (imageStringArray.count == 0) {
        
        data.certImg = nil;
        
    } else if (imageStringArray.count == 0) {
        
        data.certImg = imageStringArray[0];
        
    } else {
        
        NSString *content = nil;
        
        for (int i = 0; i < imageStringArray.count; i++) {
            
            if (i == 0) {
                
                content = imageStringArray[0];
                
            } else {
                
                content = [NSString stringWithFormat:@"%@,%@",content,imageStringArray[i]];
                
            }
            
        }
        
        data.certImg = content;
        
    }
    
    self.viewData = data;
    [self loadTableViewData];
    
}

- (void) showErrorMessage:(NSString *)message; {
    
    [MBProgressHUD showMessageTitle:message toView:self.view afterDelay:1.f];
    
}

#pragma mark - EdiUserInfomationChooseTypeViewDelegate
- (void) chooseJobTypeWithData:(id)data forViewType:(EChooseJobTypeType)viewType; {
    
    CreateCVSkillsCertificateData *model = self.viewData;
    NSDictionary *tmpData = data;
    NSString *title = tmpData[@"title"];
    NSString *titleId = tmpData[@"titleId"];
    
    if (title.length > 0) {
        
        if (viewType == cert_level_view) {
            
            model.certLevelName = title;
            model.certLevel     = titleId;
            
        } else if (viewType == skill_level_view) {
            
            model.skillLevelName = title;
            model.skillLevel     = titleId;
            
        }
    }
    
    self.viewData = model;
    [self loadTableViewData];
    
}

- (void) chooseYearDate:(NSString *)yearString
            monthString:(NSString *)monthString
              dayString:(NSString *)dayString; {
    
    CreateCVSkillsCertificateData *data = self.viewData;
    
    if (yearString.length > 0 && monthString.length > 0 && dayString.length > 0) {
        
        data.certDate = [NSString stringWithFormat:@"%@年%@月%@日",yearString,monthString,dayString];
        
    }
    
    self.viewData = data;
    [self loadTableViewData];
    
}

//  选择照片完成之后的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    __weak OADAddSkillsCertificateViewController *weakSelf = self;
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [OSSImageUploader asyncUploadImages:@[resultImage] complete:^(NSArray<NSString *> *names, UploadImageState state) {
        
        NSString *imageString = [names componentsJoinedByString:@","];
                
        NSString *content = nil;
        
        if (tmpImageStringArray.count > 0) {
            
            for (int i = 0; i < tmpImageStringArray.count; i++) {
                
                if (i == 0) {
                    
                    content = tmpImageStringArray[0];
                    
                } else {
                    
                    content = [NSString stringWithFormat:@"%@,%@",content,tmpImageStringArray[i]];
                    
                }
                
            }
            
            content = [NSString stringWithFormat:@"%@,%@",content,imageString];
            
        } else {
            
            content = imageString;
            
        }
        
        CreateCVSkillsCertificateData *data = weakSelf.viewData;
        data.certImg = content;
        weakSelf.viewData = data;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [weakSelf loadTableViewData];
            
        });
        
    }];
    
    //使用模态返回到软件界面
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//点击取消按钮所执行的方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

@end
