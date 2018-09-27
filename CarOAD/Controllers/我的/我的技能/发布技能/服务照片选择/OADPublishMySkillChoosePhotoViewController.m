//
//  OADPublishMySkillChoosePhotoViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADPublishMySkillChoosePhotoViewController.h"

#import <Photos/Photos.h>

#define Add_Button_Width  (self.view.width - 54 *Scale_Width) / 3

@interface OADPublishMySkillChoosePhotoViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    NSArray *uploadImagesArray;
    
}
@property (nonatomic, strong) UIView *imageBackView;
@property (nonatomic, strong) UIView *photoBackView;
@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;
@property (nonatomic, strong) NSArray *photoImageArray;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation OADPublishMySkillChoosePhotoViewController

- (QTCheckImageScrollView *)checkImageScrollView {
    
    if (!_checkImageScrollView) {
        
        _checkImageScrollView = [QTCheckImageScrollView new];
        
    }
    
    return _checkImageScrollView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"服务照片";
    self.leftItemText = @"返回";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    self.photoBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.photoBackView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.photoBackView];
    
    self.imageBackView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 0)];
    self.imageBackView.backgroundColor = [UIColor clearColor];
    [self.photoBackView addSubview:self.imageBackView];
    
    if (self.imageString.length > 0) {
        
        NSArray *imageStringArray = [self.imageString componentsSeparatedByString:@","];
        self.photoImageArray = [imageStringArray copy];
        [self addImageForContentViewWithImageArray:self.photoImageArray];
        
    } else {
        
        [self addImageForContentViewWithImageArray:nil];
        
    }
    
    self.contentLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, self.photoBackView.y + self.photoBackView.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 120 *Scale_Height)
                                            labelType:kLabelNormal
                                                 text:@"1.第一张图片为封面图，最多可上传6张图片\n2.请上传清晰可见的照片\n3.高质量的服务图片会让你的服务更容易被接单\n4.图片中包含色情、不清晰、二维码等内容的服务会导致审核不通过"
                                                 font:UIFont_15
                                            textColor:TextGrayColor
                                        textAlignment:NSTextAlignmentNatural
                                                  tag:100];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.bottomView.frame = CGRectMake(0, self.view.height - 60 *Scale_Height - SafeAreaBottomHeight, Screen_Width, 60 *Scale_Height + SafeAreaBottomHeight);
    self.bottomView.hidden = NO;

    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"保存"
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
    [self.bottomView addSubview:button];
    button.backgroundColor     = MainColor;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius  = 3 *Scale_Height;
    button.titleLabel.font     = UIFont_M_16;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}


- (void) addImageForContentViewWithImageArray:(NSArray *)imageArray {

    if (imageArray.count > 6) {
        
        
        return;
    }
    
    self.photoImageArray = [imageArray copy];
    
    for (UIView *subView in self.imageBackView.subviews) {
        
        [subView removeFromSuperview];
        
    }
    
    CGRect frame      = CGRectZero;
    frame.size.width  = (self.imageBackView.width - 20 *Scale_Width) / 3;
    frame.size.height = (self.imageBackView.width - 20 *Scale_Width) / 3;
    
    for (int i = 0; i < imageArray.count; i++) {
        
        if (i < 3) {
            
            frame.origin.x = (frame.size.width + 10 *Scale_Height) *i;
            frame.origin.y = 0;
            
        } else if (i >= 3 && i < 6) {
            
            frame.origin.x = (frame.size.width + 10 *Scale_Height) *(i - 3);
            frame.origin.y = frame.size.height + 10 *Scale_Height;
            
        } else {
            
            frame.origin.x = (frame.size.width + 10 *Scale_Height) *(i - 6);
            frame.origin.y = (frame.size.height + 10 *Scale_Height) *2;
            
        }
        
        NSString *imageString = imageArray[i];
        
        UIView *imageView = [self createImageViewWithFrame:frame imageString:imageString tag:i + 3000];
        [self.imageBackView addSubview:imageView];
        
        self.checkImageScrollView.imagesArray = [imageArray copy];
        
    }
    
    {
        
        if (imageArray.count < 3) {
            
            CGRect buttonRect      = CGRectZero;
            buttonRect.size.width  = frame.size.width - 10 *Scale_Height;
            buttonRect.size.height = frame.size.width - 10 *Scale_Height;
            
            buttonRect.origin.x = (frame.size.height + 10 *Scale_Height) *imageArray.count;
            buttonRect.origin.y = 10 *Scale_Height;
            
            UIButton *button = [UIButton createButtonWithFrame:buttonRect
                                                         title:nil
                                               backgroundImage:[UIImage imageNamed:@"添加照片"]
                                                           tag:2000
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            button.backgroundColor = MainColor;
            [self.imageBackView addSubview:button];
            
            self.imageBackView.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, button.y + button.height + 10 *Scale_Height);
            
            self.photoBackView.frame = CGRectMake(0, 10 *Scale_Height + 64, Screen_Width, self.imageBackView.y + self.imageBackView.height + 10 *Scale_Height);
            
        } else if (imageArray.count >= 3 && imageArray.count < 6) {
            
            CGRect buttonRect      = CGRectZero;
            buttonRect.size.width  = frame.size.width - 10 *Scale_Height;
            buttonRect.size.height = frame.size.width - 10 *Scale_Height;
            
            buttonRect.origin.x = (frame.size.height + 10 *Scale_Height) *(imageArray.count - 3);
            buttonRect.origin.y = frame.size.height + 20 *Scale_Height;
            
            UIButton *button = [UIButton createButtonWithFrame:buttonRect
                                                         title:nil
                                               backgroundImage:[UIImage imageNamed:@"添加照片"]
                                                           tag:2000
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            button.backgroundColor = MainColor;
            [self.imageBackView addSubview:button];
            
            self.imageBackView.frame = CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, button.y + button.height + 10 *Scale_Height);
            
            self.photoBackView.frame = CGRectMake(0, 10 *Scale_Height + 64, Screen_Width, self.imageBackView.y + self.imageBackView.height + 10 *Scale_Height);
            
        }
        
        self.contentLabel.frame = CGRectMake(15 *Scale_Width, self.photoBackView.y + self.photoBackView.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 120 *Scale_Height);
        
    }
    
}

- (UIView *) createImageViewWithFrame:(CGRect)frame imageString:(NSString *)imageString tag:(NSInteger)tag {
    
    UIView *imageBackView         = [[UIView alloc] initWithFrame:frame];
    imageBackView.backgroundColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10 *Scale_Width, frame.size.width - 10 *Scale_Width, frame.size.width - 10 *Scale_Width)];
    imageView.contentMode  = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageBackView addSubview:imageView];
    
    [QTDownloadWebImage downloadImageForImageView:imageView
                                         imageUrl:[NSURL URLWithString:imageString]
                                 placeholderImage:@"contact_off_gray"
                                         progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                             
                                         }
                                          success:^(UIImage *finishImage) {
                                              
                                          }];
    
    UIButton *button = [UIButton createButtonWithFrame:imageBackView.bounds
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:tag
                                                target:self
                                                action:@selector(buttonEvent:)];
    [imageBackView addSubview:button];
    
    UIButton *deleteButton = [UIButton createButtonWithFrame:CGRectMake(frame.size.width - 20 *Scale_Width, 0, 20 *Scale_Width, 20 *Scale_Width)
                                                       title:nil
                                             backgroundImage:[UIImage imageNamed:@"4张照片-删除"]
                                                         tag:tag + 1000
                                                      target:self
                                                      action:@selector(buttonEvent:)];
    [imageBackView addSubview:deleteButton];
    
    return imageBackView;
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (sender.tag == 1000) {
        
        NSString *imageString = [self.photoImageArray componentsJoinedByString:@","];
        self.addPhotoSuccess(imageString);
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (sender.tag == 2000) {
        
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
        
    } else if (sender.tag >= 3000 && sender.tag < 4000) {
        
        //  点击图片预览
        [self.checkImageScrollView showwithTag:sender.tag - 3000];
        
    } else if (sender.tag >= 4000 && sender.tag < 5000) {
        
        //  删除图片
        NSMutableArray *tmpImageString = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.photoImageArray.count; i++) {
            
            NSString *content = self.photoImageArray[i];
            [tmpImageString addObject:content];
            
        }
        
        [tmpImageString removeObjectAtIndex:sender.tag - 4000];
        [self addImageForContentViewWithImageArray:tmpImageString];
        
    } else {
        

    }
    
}

//  选择照片完成之后的代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    __weak OADPublishMySkillChoosePhotoViewController *weakSelf = self;
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [OSSImageUploader asyncUploadImages:@[resultImage] complete:^(NSArray<NSString *> *names, UploadImageState state) {
        
        NSMutableArray *tmpImageString = [[NSMutableArray alloc] init];
        for (int i = 0; i < weakSelf.photoImageArray.count; i++) {
            
            NSString *content = weakSelf.photoImageArray[i];
            [tmpImageString addObject:content];
            
        }
        
        [tmpImageString addObject:names[0]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [weakSelf addImageForContentViewWithImageArray:tmpImageString];
            
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

@end
