//
//  OADPublishQuestionAndAnswerViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/6.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "OADPublishQuestionAndAnswerViewController.h"

#import "PushQAViewModel.h"
#import "CommunityMainViewModel.h"

#import "PublishQuestionAndAnswerHeaderView.h"
#import "PublishQuestionAndAnswerChooseCarTypeCell.h"
#import "PublishQuestionAndAnswerContentCell.h"

#import "OADChooseCarTypeViewController.h"
#import <Photos/Photos.h>

@interface OADPublishQuestionAndAnswerViewController ()<CustomAdapterTypeTableViewCellDelegate, PublishQuestionAndAnswerHeaderViewDelegate, PublishQuestionAndAnswerContentCellDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    NSArray  *uploadImagesArray;
    NSString *uploadTextContent;
    NSArray  *typeArray;
    
    NSDictionary *selectedCarBrandData;
    NSDictionary *selectedCarTypeData;
    
}
@property (nonatomic, strong) PublishQuestionAndAnswerHeaderView *headerView;
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation OADPublishQuestionAndAnswerViewController

- (NSMutableDictionary *)params {
    
    if (!_params) {
        
        _params = [[NSMutableDictionary alloc] init];
    }
    
    return _params;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getTagList];
    
}

- (void) initialization {
    
    self.adapters              = [NSMutableArray array];
    NSMutableArray *indexPaths = [NSMutableArray array];
    
    {
        
        NSDictionary *data = nil;
        
        TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"PublishQuestionAndAnswerChooseCarTypeCell"
                                                                                                        data:data
                                                                                                  cellHeight:50 *Scale_Height
                                                                                                    cellType:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        adapter.indexPath      = indexPath;
        [self.adapters addObject:adapter];
        [indexPaths addObject:indexPath];
        
    }
    
    {
        
        NSDictionary *data = nil;
        
        TableViewCellDataAdapter *adapter = [TableViewCellDataAdapter cellDataAdapterWithCellReuseIdentifier:@"PublishQuestionAndAnswerContentCell"
                                                                                                        data:data
                                                                                                  cellHeight:(Screen_Width - 50 *Scale_Width) / 3 + 205 *Scale_Height
                                                                                                    cellType:0];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        adapter.indexPath      = indexPath;
        [self.adapters addObject:adapter];
        [indexPaths addObject:indexPath];
        
    }
    
}

- (void)setNavigationController {
    
    self.navTitle = @"发布问答";
    
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight - SafeAreaBottomHeight - 50 *Scale_Width);
    self.tableView.frame = self.contentView.bounds;
    self.tableView.backgroundColor = BackGrayColor;
    
    [PublishQuestionAndAnswerChooseCarTypeCell registerToTableView:self.tableView];
    [PublishQuestionAndAnswerContentCell registerToTableView:self.tableView];
    
    self.bottomView.frame = CGRectMake(0, self.view.height - 50 *Scale_Width - SafeAreaBottomHeight, self.view.width, 50 *Scale_Width + SafeAreaBottomHeight);
    self.bottomView.hidden = NO;
    self.bottomView.backgroundColor = MainColor;
    //  创建发布按钮
    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 0, self.bottomView.width, 50 *Scale_Width)
                                                 title:@"发布"
                                       backgroundImage:nil
                                                   tag:5000
                                                target:self
                                                action:@selector(buttonEvent:)];
    
    button.backgroundColor = MainColor;
    button.titleLabel.font = UIFont_17;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bottomView addSubview:button];
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (uploadTextContent.length <= 0) {
        
        [MBProgressHUD showMessageTitle:@"请输入您遇到的问题" toView:self.view afterDelay:1.f];
        return;
        
    }

    NSString *carBrandId = selectedCarBrandData[@"brandId"];
    NSString *carTypeId  = selectedCarTypeData[@"carTypeId"];
    
    if (carBrandId.length > 0 && carTypeId.length > 0) {
        
        [self.params setObject:carBrandId  forKey:@"carBrandId"];
        [self.params setObject:carTypeId   forKey:@"carModelId"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请选择车辆品牌" toView:self.view afterDelay:1.f];
        return;
        
    }

    /** 上传服务器   先异步传图片至OSS
     *
     *  1.用户ID          用户Id
     *  2.TagId          问题标签
     *  3.CarBrandId     车品牌编号
     *  4.QAInfo         问题内容
     *  5.QAImgURL       图片URL  *注：图片以list的形式上传
     *
     */
    // 串行队列的创建方法
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [self.params setObject:accountInfo.user_id forKey:@"userId"];
    [self.params setObject:uploadTextContent forKey:@"QAInfo"];
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    if (uploadImagesArray.count > 0) {
        
        [OSSImageUploader asyncUploadImages:uploadImagesArray complete:^(NSArray<NSString *> *names, UploadImageState state) {
            
            NSString *imageString = [names componentsJoinedByString:@","];
            
            [self.params setObject:imageString forKey:@"QAImgURL"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [PushQAViewModel requestPost_pushQuestionAndAnswerNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
                    
                    [self requestSucessWithData:info];
                    
                } error:^(NSString *errorMessage) {
                    
                    [MBProgressHUD hideHUDForView:self.view];
                    
                } failure:^(NSError *error) {
                    
                    [self requestFailedWithError:error];
                    
                }];
                
            });
            
        }];
        
    } else {
        
        [self.params setObject:@"" forKey:@"QAImgURL"];
        
        [PushQAViewModel requestPost_pushQuestionAndAnswerNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
            
            [self requestSucessWithData:info];
            
        } error:^(NSString *errorMessage) {
            
            [MBProgressHUD hideHUDForView:self.view];
            
        } failure:^(NSError *error) {
            
            [self requestFailedWithError:error];
            
        }];
        
    }
    
}

- (void) requestSucessWithData:(id)data; {
    
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD showMessageTitle:@"发布成功！" toView:self.view afterDelay:1.f];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    });
    
}

- (void) requestFailedWithError:(NSError *)error; {
    
    CarOadLog(@"error --- %@",error);
    
}

- (void) getTagList {
    
    NSDictionary *params = @{@"tagType":@"1"};
    
    [MBProgressHUD showMessage:nil toView:self.view];
    
    [CommunityMainViewModel requestPost_getTagListNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
        
        typeArray = info[@"data"];
        
        NSMutableArray *buttonTitleArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *model in info[@"data"]) {
            
            [buttonTitleArray addObject:[model objectForKey:@"tag"]];
            
        }
        
        NSString *typeId = typeArray[0][@"tagId"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (typeId.length > 0) {
                
                [self.params setObject:typeId forKey:@"tagId"];
                
            }

            [MBProgressHUD hideHUDForView:self.view];
            self.tableView.tableHeaderView = [self createHraderViewWithTagArray:buttonTitleArray];
            
            [self initialization];
            [self.tableView reloadData];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showMessageTitle:@"暂无问答标签" toView:self.view afterDelay:1.f];
            
        });
        
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        
    }];
    
}

- (UIView *) createHraderViewWithTagArray:(NSArray *)tagArray {
    
    PublishQuestionAndAnswerHeaderView *headerView = [[PublishQuestionAndAnswerHeaderView alloc] init];
    if (tagArray.count > 4) {
        
        headerView.frame = CGRectMake(0, 0, Screen_Width, 90 *Scale_Height);
        
    } else {
        
        headerView.frame = CGRectMake(0, 0, Screen_Width, 50 *Scale_Height);
        
    }
    headerView.buttonTitleArray = tagArray;
    [headerView buildsubview];
    headerView.delegate = self;
    self.headerView = headerView;
    
    return headerView;
    
}

#pragma mark - TableViewDelegate
//设置头分区
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 10 *Scale_Height)];
    headerView.backgroundColor = [UIColor clearColor];
    
    return headerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10 *Scale_Height;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
    
}

#pragma mark - UITableViewDataSource
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.adapters.count;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.adapters[indexPath.section].cellHeight;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        TableViewCellDataAdapter *adapter = self.adapters[indexPath.section];
        PublishQuestionAndAnswerContentCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
        cell.dataAdapter                     = adapter;
        cell.data                            = adapter.data;
        cell.tableView                       = tableView;
        cell.indexPath                       = indexPath;
        cell.delegate                        = self;
        cell.subCellDelegate                 = self;
        [cell loadContent];
        
        return cell;
        
    } else {
        
        TableViewCellDataAdapter *adapter = self.adapters[indexPath.section];
        CustomAdapterTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
        cell.dataAdapter                     = adapter;
        cell.data                            = adapter.data;
        cell.tableView                       = tableView;
        cell.indexPath                       = indexPath;
        cell.delegate                        = self;
        [cell loadContent];
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        __weak OADPublishQuestionAndAnswerViewController *weakSelf = self;
        OADChooseCarTypeViewController *viewController = [OADChooseCarTypeViewController new];
        NSMutableDictionary *contentDic = [NSMutableDictionary new];
        
        if (selectedCarBrandData && selectedCarTypeData) {
            
            [contentDic setObject:selectedCarBrandData forKey:@"selectedCarBrand"];
            [contentDic setObject:selectedCarTypeData  forKey:@"selectedCarType"];
            
        }
        viewController.selectedData = contentDic;
        viewController.carTypeInfoBlock = ^(NSDictionary *carBrandData, NSDictionary *carTypeData) {
            
            selectedCarBrandData = carBrandData;
            selectedCarTypeData  = carTypeData;

            NSString *carBrand = carBrandData[@"brandName"];
            NSString *carType  = carTypeData[@"carTypeName"];
            
            if (carBrand.length > 0 && carType.length > 0) {
                
                NSDictionary *data = @{@"carInfo" : [NSString stringWithFormat:@"%@ %@",carBrand,carType]};
                
                TableViewCellDataAdapter *adapter = weakSelf.adapters[0];
                adapter.data                      = data;
                [weakSelf.adapters replaceObjectAtIndex:0 withObject:adapter];
                [weakSelf.tableView reloadData];
                
            }
            
        };
        [self.navigationController pushViewController:viewController animated:YES];
        
    }
    
}

#pragma mark - PublishQuestionAndAnswerHeaderViewDelegate
- (void) chooseQATagWithTag:(NSInteger)tag; {
    
    NSString *typeId = typeArray[tag][@"tagId"];
    if (typeId.length > 0) {
        
        [self.params setObject:typeId forKey:@"tagId"];
        
    }
    
}

#pragma mark - PublishQuestionAndAnswerContentCellDelegate
- (void) getTextViewText:(NSString *)text; {
    
    uploadTextContent = text;
    
    NSMutableDictionary *model = [[NSMutableDictionary alloc] init];
    if (text.length > 0) {
        
        [model setObject:text forKey:@"content"];
        
    }
    
    TableViewCellDataAdapter *adapter = self.adapters[1];
    adapter.data                      = model;
    [self.adapters replaceObjectAtIndex:1 withObject:adapter];
    
}

- (void) addImageWithImageArray:(NSArray *)imageArray; {
    
    uploadImagesArray = imageArray;
    
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

- (void) deleteImageWithImageArray:(NSArray *)imageArray; {
    
    uploadImagesArray = imageArray;
    
    if (uploadTextContent.length > 0) {
        
        NSDictionary *data = @{@"content" : uploadTextContent,
                               @"images"  : uploadImagesArray
                               };
        
        TableViewCellDataAdapter *adapter = self.adapters[1];
        adapter.data                      = data;
        [self.adapters replaceObjectAtIndex:1 withObject:adapter];
        [self.tableView reloadData];
        
    } else {
        
        NSDictionary *data = @{@"images"  : uploadImagesArray};
        
        TableViewCellDataAdapter *adapter = self.adapters[1];
        adapter.data                      = data;
        [self.adapters replaceObjectAtIndex:1 withObject:adapter];
        [self.tableView reloadData];
        
    }

}

- (void) showErrorMessage:(NSString *)message; {
    
    [MBProgressHUD showMessageTitle:message toView:self.view afterDelay:1.f];
    
}

//  选择照片完成之后的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSMutableArray *tmpImageArray = [NSMutableArray array];
    
    for (UIImage *image in uploadImagesArray) {
        
        [tmpImageArray addObject:image];
        
    }
    
    [tmpImageArray addObject:resultImage];
    
    uploadImagesArray = [tmpImageArray copy];
    
    if (uploadTextContent.length > 0) {
        
        NSDictionary *data = @{@"content" : uploadTextContent,
                               @"images"  : uploadImagesArray
                               };
        
        TableViewCellDataAdapter *adapter = self.adapters[1];
        adapter.data                      = data;
        [self.adapters replaceObjectAtIndex:1 withObject:adapter];
        [self.tableView reloadData];
        
    } else {
        
        NSDictionary *data = @{@"images"  : uploadImagesArray};
        
        TableViewCellDataAdapter *adapter = self.adapters[1];
        adapter.data                      = data;
        [self.adapters replaceObjectAtIndex:1 withObject:adapter];
        [self.tableView reloadData];
        
    }
    
    //使用模态返回到软件界面
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//  点击取消按钮所执行的方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
