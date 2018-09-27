//
//  OADPublishArticleViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADPublishArticleViewController.h"

#import "PublishArticleMainView.h"
#import "CommunityMainViewModel.h"

#import "NSJSON+Extension.h"

#import "PublishArticleViewModel.h"

@interface OADPublishArticleViewController ()<PublishArticleMainViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    NSArray   *imagesArray;
    NSInteger  tmpTag;
    NSString  *typeId;
    NSArray   *typeArray;
    
}
@property (nonatomic, strong) PublishArticleMainView *subView;

@property (nonatomic, assign) NSInteger tmp_tag;

@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSString *titleImageName;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSMutableArray *uploadImagesArray;

@end

@implementation OADPublishArticleViewController

- (NSMutableArray *)uploadImagesArray {

    if (!_uploadImagesArray) {

        _uploadImagesArray = [[NSMutableArray alloc] init];
    }

    return _uploadImagesArray;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

    [self.navigationController setNavigationBarHidden:NO animated:NO];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(openKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];

    [[NSNotificationCenter defaultCenter] removeObserver:self
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

    [self.subView showhideKeyboardWithKeyRect:frameOfKeyboard duration:duration delay:0 options:option];

}

- (void) hideKeyboard:(NSNotification *)notification {

    NSTimeInterval duration       = \
    [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = \
    [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];

    [self.subView hidehideKeyboardWithDuration:duration delay:0 options:option];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self removeTap];

}

- (void)setNavigationController {

    self.navTitle      = @"发布文章";
    self.leftItemText  = @"返回";
    self.rightItemText = @"完成";
    
    [super setNavigationController];

}

- (void) clickRightItem {

    [self.view endEditing:YES];

}

- (void)buildSubView {

    [super buildSubView];

    PublishArticleMainView *subView = [[PublishArticleMainView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    subView.delegate = self;
    [self.contentView addSubview:subView];

    self.subView = subView;

    [self getTagList];

}

- (void) getTagList {

    NSDictionary *params = @{@"tagType":@"2"};

    [MBProgressHUD showMessage:nil toView:self.view];

    [CommunityMainViewModel requestPost_getTagListNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

        typeArray = info[@"data"];
        
        NSMutableArray *buttonTitleArray = [[NSMutableArray alloc] init];

        for (NSDictionary *model in info[@"data"]) {

            [buttonTitleArray addObject:[model objectForKey:@"tag"]];

        }

        typeId        = typeArray[0][@"tagId"];
        self.typeName = typeArray[0][@"tag"];

        self.subView.buttonTitleArray = [buttonTitleArray copy];

        dispatch_async(dispatch_get_main_queue(), ^{

            [MBProgressHUD hideHUDForView:self.view];
            [self.subView buildsubview];

        });


    } error:^(NSString *errorMessage) {

        dispatch_async(dispatch_get_main_queue(), ^{

            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showMessageTitle:@"暂无文章标签" toView:self.view afterDelay:1.f];

        });


    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showMessageTitle:@"连接服务器失败" toView:self.view afterDelay:1.f];

    }];

}

#pragma mark - PublishArticleMainViewDelegate
- (void) chooseTypeWithTag:(NSInteger)tag; {

    typeId        = typeArray[tag][@"tagId"];
    self.typeName = typeArray[tag][@"tag"];

}

- (void) chooseCarType; {



}

- (void) addTitleImageView; {

    [self addImageWithTag:1];

}

- (void) addImageWithImageArray:(NSArray *)imageArray; {



}

- (void) addTextViewImage; {

    [self addImageWithTag:2];

}

- (void) publishArticleWithTitle:(NSString *)title
                      titleImage:(UIImage *)titleImage
                    contentArray:(NSArray *)contentArray
                     imagesArray:(NSArray *)imagesArray; {

    if (!titleImage) {

        [MBProgressHUD showMessageTitle:@"请选择封面图" toView:self.view afterDelay:1.25f];

        return;

    }

    if (title.length <= 0) {

        [MBProgressHUD showMessageTitle:@"请输入标题" toView:self.view afterDelay:1.25f];

        return;

    }

    if (contentArray.count <= 0 && imagesArray.count <= 0) {

        [MBProgressHUD showMessageTitle:@"请输入正文" toView:self.view afterDelay:1.25f];

        return;

    }

    self.titleName = title;

    [self.uploadImagesArray addObject:titleImage];

    if (imagesArray.count > 0) {

        for (UIImage *image in imagesArray) {

            [self.uploadImagesArray addObject:image];

        }



    }

    [MBProgressHUD showMessage:nil toView:self.view];
    [self replacetagWithImageArray:self.uploadImagesArray contentArray:contentArray];
    
}

#pragma mark - 上传图片
//这里就开始上传图片，拼接图片地址
-(void)replacetagWithImageArray:(NSArray *)picArr contentArray:(NSArray *)contentArray
{

    __weak typeof(self)weakSelf = self;

    NSMutableArray *contentMutableArray = [[NSMutableArray alloc] init];

    self.tmp_tag = 1;

    [OSSImageUploader asyncUploadImages:picArr complete:^(NSArray<NSString *> *names, UploadImageState state) {

        self.titleImageName = names[0];

        for (int i = 0; i < contentArray.count; i++) {

            NSDictionary *dict = contentArray[i];

            if (dict[@"image"] != nil) {
                
                NSString *imageString = names[weakSelf.tmp_tag];

                NSString *image = [NSString stringWithFormat:@"<img src=\"%@\" alt="" style=\"width:345px\" class=\"mainImg\"/>",imageString];
                [dict setValue:image forKey:@"image"];

                weakSelf.tmp_tag ++;
            }

            [contentMutableArray addObject:dict];

        }

        //  创建html文件
        [self createHtmlFileWithArray:contentMutableArray];

    }];

}

- (void) createHtmlFileWithArray:(NSArray *)textArray {
    
    NSArray  *paths         = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *saveDirectory = [paths objectAtIndex:0];
    NSString *saveFileName  = @"MyHTML.html";
    NSString *filepath      = [saveDirectory stringByAppendingPathComponent:saveFileName];

    NSMutableString *htmlstring = [[NSMutableString alloc] initWithString:@"<!DOCTYPE html><html>"];

    [htmlstring appendString:@"<head>"];
    [htmlstring appendString:@"<meta charset=\"UTF-8\">"];
    [htmlstring appendString:@"<meta name=\"viewport\" content=\"width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no\"/>"];
    [htmlstring appendString:@"<meta name=\"full-screen\" content=\"yes\">"];
    [htmlstring appendString:@"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />"];
    [htmlstring appendString:@"<meta name=\"x5-fullscreen\" content=\"true\">"];
    [htmlstring appendString:@"<title></title>"];
    [htmlstring appendString:@"<style>"];
    [htmlstring appendString:@"html, body, div, span, applet, object, iframe,h1, h2, h3, h4, h5, h6, p, blockquote, pre,a, abbr, acronym, address, big, cite, code,del, dfn, em, img, ins, kbd, q, s, samp,small, strike, strong, sub, sup, tt, var,b, u, i, center,dl, dt, dd, ol, ul, li,fieldset, form, label, legend,table, caption, tbody, tfoot, thead, tr, th, td,article, aside, canvas, details, embed,figure, figcaption, footer, header,menu, nav, output, ruby, section, summary,time, mark, audio, video, input{margin: 0;padding: 0;border: 0;font-size: 100%;font-weight: normal;vertical-align: baseline;}"];
    [htmlstring appendString:@"article, aside, details, figcaption, figure,footer, header, menu, nav, section {display: block;}"];
    [htmlstring appendString:@"body {line-height: 1;}"];
    [htmlstring appendString:@"blockquote, q {quotes: none;}"];
    [htmlstring appendString:@"blockquote:before, blockquote:after,q:before, q:after {content: none;}"];
    [htmlstring appendString:@"table {border-collapse: collapse;border-spacing: 0;}"];
    [htmlstring appendString:@"a {color: #7e8c8d;text-decoration: none;-webkit-backface-visibility: hidden;}"];
    [htmlstring appendString:@"li {list-style: none;}"];
    [htmlstring appendString:@"::-webkit-scrollbar {width: 5px;height: 5px;}"];
    [htmlstring appendString:@"::-webkit-scrollbar-track-piece {background-color: rgba(0, 0, 0, 0.2);-webkit-border-radius: 6px;}"];
    [htmlstring appendString:@"::-webkit-scrollbar-thumb:vertical {height: 5px;background-color: rgba(125, 125, 125, 0.7);-webkit-border-radius: 6px;}"];
    [htmlstring appendString:@"::-webkit-scrollbar-thumb:horizontal {width: 5px;background-color: rgba(125, 125, 125, 0.7);-webkit-border-radius: 6px;}"];
    [htmlstring appendString:@"html, body {width: 100%;}"];
    [htmlstring appendString:@"body {-webkit-text-size-adjust: none;-webkit-tap-highlight-color: rgba(0, 0, 0, 0);}"];
    [htmlstring appendString:@"html {font-size: 100px;}"];
    [htmlstring appendString:@"body,html{height:100%;}"];
    [htmlstring appendString:@"body{font-size: 0.16rem;font-family: \"hiragino sans gb\";margin:0px;padding:0;}"];
    [htmlstring appendString:@"section{padding-left:0.2rem;padding-right:0.2rem;}"];
    [htmlstring appendString:@".articel_title{width:100%;font-size:18px;line-height:25px;padding-top:10px;padding-bottom:10px;color:#403F3F;}"];
    [htmlstring appendString:@".personage{width:100%;height:60px;display:flex;justify-content: space-between;}"];
    [htmlstring appendString:@".personage img{width:40px;height:40px;border-radius:50%;display:inline-block;}"];
    [htmlstring appendString:@".personage_left{width:40%;position:relative;}"];
    [htmlstring appendString:@".name{display:inline-block;margin-top:-20px;position:absolute;top:55%;left:55px;font-size:0.12rem;color:#777676;}"];
    [htmlstring appendString:@".time{font-size:0.12rem;margin-top:0.12rem;color:#777676;}"];
    [htmlstring appendString:@".maintext{width:100%;font-size:0.12rem;color:#777676;line-height:20px;padding-bottom:0.05rem;padding-top:0.01rem}"];
    [htmlstring appendString:@".mainImg{width:100%;padding-bottom:0.15rem;padding-top:0.15rem}"];
    [htmlstring appendString:@".iconstyle{border:1px solid #777676;color:#777676;padding:0.02rem 0.06rem;border-radius:5px;font-size:0.1rem;}"];
    [htmlstring appendString:@"</style></head><body>"];
    [htmlstring appendString:@"<section>"];

    [htmlstring appendString:[NSString stringWithFormat:@"<h1 class=\"articel_title\">%@</h1>",self.titleName]];
    [htmlstring appendString:@"<div class=\"personage\">"];
    [htmlstring appendString:@"<div class=\"personage_left\">"];
    [htmlstring appendString:[NSString stringWithFormat:@"<img src=\"%@\" alt=\"\" />",self.titleImageName]];
    [htmlstring appendString:[NSString stringWithFormat:@"<p class=\"name\">%@</p>",@"1223"]];
    [htmlstring appendString:@"</div>"];
    
    //  获取发布时间
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSString *currentDateStr = [dateFormatter stringFromDate:date];

    [htmlstring appendString:[NSString stringWithFormat:@"<p class=\"time\">%@</p>",currentDateStr]];
    [htmlstring appendString:@"</div>"];

    [htmlstring appendString:@"<div class=\"maininfo\">"];
    [htmlstring appendString:@"<p class=\"maintext\">"];

    [htmlstring appendString:[NSString stringWithFormat:@"<img src=\"%@\" alt="" style=\"width:345px\" class=\"mainImg\"/>",self.titleImageName]];
    
    for (NSDictionary *model in textArray) {

        NSString *content = model[@"title"];

        if ([content isEqualToString:@"\n"]) {
            
            [htmlstring appendString:@"</p><p class=\"maintext\">"];
            
        } else if ([content rangeOfString:@"\n"].location !=NSNotFound) {
            
            NSArray *array = [content componentsSeparatedByString:@"\n"];
            
            NSString *firstString  = array[0];
            NSString *secondString = array[1];

            if (firstString.length > 0) {

                [htmlstring appendString:firstString];

            }

            [htmlstring appendString:@"</p><p class=\"maintext\">"];

            if (secondString.length > 0) {

                [htmlstring appendString:secondString];

            }

        } else if ([content isEqualToString:@"[UIImageView]"]) {

            [htmlstring appendString:model[@"image"]];

        } else if ([content isEqualToString:@" •  "]) {

            [htmlstring appendString:@" •  "];

        } else if ([content isEqualToString:@"\n •  "]) {

            [htmlstring appendString:@"</p><p class=\"maintext\"> •  "];

        } else {

            if (content.length > 0) {

                [htmlstring appendString:content];

            }

        }

    }

    [htmlstring appendString:@"</p></div>"];
    [htmlstring appendString:[NSString stringWithFormat:@"<span class=\"iconstyle\">%@</span>",self.typeName]];
    [htmlstring writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];

    CarOadLog(@"htmlstring --- %@",htmlstring);

    NSData *htmlData = [NSData dataWithContentsOfFile:filepath];

    [LXF_AliyunOSS_UploadFile asyncUploadFile:htmlData complete:^(NSArray<NSString *> *names, UploadFileState state) {

        for (NSString *name in names) {

            CarOadLog(@"name --- %@",name);

        }
        NSString *firleName = names[0];

        //  上传服务器发布文章
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
        [params setObject:accountInfo.user_id forKey:@"userId"];
        [params setObject:typeId forKey:@"tagId"];
        [params setObject:self.titleName forKey:@"title"];
        [params setObject:@"" forKey:@"articleInfo"];
        [params setObject:accountInfo.user_id forKey:@"creater"];
        [params setObject:self.titleImageName forKey:@"artCoverImg"];
        [params setObject:firleName forKey:@"artHtmlUrl"];
        [params setObject:@"1" forKey:@"source"];

        [PublishArticleViewModel requestPost_publishArticleNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showMessageTitle:@"发布成功！" toView:self.view afterDelay:1.f];

            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25/*延迟执行时间*/ * NSEC_PER_SEC));

            dispatch_after(delayTime, dispatch_get_main_queue(), ^{

                [self.navigationController popViewControllerAnimated:YES];

            });

        } error:^(NSString *errorMessage) {

            dispatch_async(dispatch_get_main_queue(), ^{

                [MBProgressHUD hideHUD];
                [MBProgressHUD showMessageTitle:@"发布失败，请重新发布" toView:self.view afterDelay:1.f];

            });

        } failure:^(NSError *error) {

            [MBProgressHUD hideHUD];
            [MBProgressHUD showMessageTitle:@"连接服务器失败" toView:self.view afterDelay:1.f];

        }];

    }];

}

#pragma mark - 添加图片
- (void) addImageWithTag:(NSInteger)tag {

    tmpTag = tag;

    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.allowsEditing = NO;
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
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];

    if (tmpTag == 1) {

        [self.subView addTitleImageWithImage:resultImage];

    } else {

        [self.subView addImageForTextViewWithImage:resultImage];

    }

    //使用模态返回到软件界面
    [self dismissViewControllerAnimated:YES completion:nil];

}

//点击取消按钮所执行的方法

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
