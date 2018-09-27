//
//  OADPublishCommentAnswerViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADPublishCommentAnswerViewController.h"

#import "PublishCommentAnswerMainView.h"

#import "PublishCommentViewModel.h"

@interface OADPublishCommentAnswerViewController ()<PublishCommentAnswerMainViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    NSArray *imagesArray;
    NSArray *uploadImagesArray;
    NSString *tagId;
    
}
@property (nonatomic, strong) PublishCommentAnswerMainView *subView;
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation OADPublishCommentAnswerViewController

- (NSMutableDictionary *)params {
    
    if (!_params) {
        
        _params = [[NSMutableDictionary alloc] init];
    }
    
    return _params;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self removeTap];
    
}

- (void)KeyboardHide {
    
    
    
    
}

- (void)setNavigationController {
    
    self.leftItemText = @"返回";
    
    self.rightItemText = @"发表";
    
    [super setNavigationController];
    
}

- (void)clickRightItem {
    
    NSString *content = [self.subView getContentText];
    
    if (content.length > 0) {

        [MBProgressHUD showMessage:nil toView:self.view];

        OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
        if ([self.type isEqualToString:@"问答"]) {
            
            [self.params setObject:accountInfo.user_id forKey:@"userId"];
            [self.params setObject:self.qaId forKey:@"QAId"];
            [self.params setObject:content   forKey:@"ansContent"];
            
            if (uploadImagesArray.count > 0) {

                [self pushQAContentWithTextContent:content];

            } else {

                [self stareNetWorkingForPublishMessage];

            }

        } else {

            [self.params setObject:accountInfo.user_id    forKey:@"userId"];
            [self.params setObject:self.qaId forKey:@"artId"];
            [self.params setObject:content   forKey:@"content"];
            [self.params setObject:@"1"      forKey:@"dataType"];

            if ([self.type isEqualToString:@"文章"]) {

                [self.params setObject:@"1" forKey:@"source"];

            } else if ([self.type isEqualToString:@"咨询"]) {

                [self.params setObject:@"2" forKey:@"source"];

            } else if ([self.type isEqualToString:@"新闻"]) {

                [self.params setObject:@"3" forKey:@"source"];

            } else if ([self.type isEqualToString:@"视频"]) {

                [self.params setObject:@"4" forKey:@"source"];

            }

            [self stareNetWorkingForPublishMessage];

        }

    } else {
        
        [MBProgressHUD showMessageTitle:@"请输入你的评论内容" toView:self.view afterDelay:1.f];
        
    }
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    PublishCommentAnswerMainView *subView = [[PublishCommentAnswerMainView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    subView.content = self.content;

    if ([self.type isEqualToString:@"问答"]) {

        [subView buildsubviewWithIsQA:YES];

    } else {

        [subView buildsubviewWithIsQA:NO];

    }

    subView.delegate = self;
    [self.contentView addSubview:subView];
    
    self.subView = subView;
    
}

#pragma mark - PushQuestionAndAnswerMainViewDelegate
- (void) chooseQATagWithTag:(NSInteger)tag; {
    
    tagId = [NSString stringWithFormat:@"%ld",tag];
    
}

- (void) chooseCarType; {
    
    
    
}

- (void) showHUDMessage:(NSString *)message {
    
    //  提示框
    
}

- (void) pushQAContentWithTextContent:(NSString *)textContent; {
    
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
    [OSSImageUploader asyncUploadImages:uploadImagesArray complete:^(NSArray<NSString *> *names, UploadImageState state) {
        
        NSString *imageString = [names componentsJoinedByString:@","];
                
        [self.params setObject:imageString forKey:@"ansImgURL"];
        
        [self stareNetWorkingForPublishMessage];
        
    }];
    
}

- (void) stareNetWorkingForPublishMessage {
    
    if ([self.type isEqualToString:@"问答"]) {
        
        NSString *ansImgURL = self.params[@"ansImgURL"];
        
        if (ansImgURL.length <= 0) {
            
            [self.params setObject:@"" forKey:@"ansImgURL"];
            
        }
        
        [PublishCommentViewModel requestPost_publishQACommentQANetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self requestSucessWithData:info];

        } error:^(NSString *errorMessage) {

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];

        } failure:^(NSError *error) {

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self requestFailedWithError:error];

        }];

    } else {

        [PublishCommentViewModel requestPost_publishQTCommentArtNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self requestSucessWithData:info];

        } error:^(NSString *errorMessage) {

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];

        } failure:^(NSError *error) {

            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self requestFailedWithError:error];

        }];

    }
    
}

- (void) requestSucessWithData:(id)data; {
    
    [MBProgressHUD showMessageTitle:@"发表成功" toView:self.view afterDelay:1.f];
    [self performSelector:@selector(popView) withObject:self afterDelay:1.f];
    
}

- (void) popView {

    [self.navigationController popViewControllerAnimated:YES];

}

- (void) requestFailedWithError:(NSError *)error; {
    
    [MBProgressHUD showMessageTitle:@"连接服务器失败！" toView:self.view afterDelay:1.f];
    
}

- (void) addImageWithImageArray:(NSArray *)imageArray; {
    
    imagesArray = imageArray;
    
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

//  选择照片完成之后的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    NSMutableArray *tmpImageArray = [NSMutableArray array];
    
    for (UIImage *image in imagesArray) {
        
        [tmpImageArray addObject:image];
        
    }
    
    [tmpImageArray addObject:resultImage];
    
    [self.subView addImageForContentViewWithImageArray:tmpImageArray];
    
    uploadImagesArray = [tmpImageArray copy];
    
    //使用模态返回到软件界面
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
