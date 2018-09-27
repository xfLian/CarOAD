//
//  OADFeedbackViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/11.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADFeedbackViewController.h"

#import "FeedbackViewModel.h"

#define MAX_LIMIT_NUMS 150
#define Add_Button_Width  (Screen_Width - 70 *Scale_Width) / 3

@interface OADFeedbackViewController ()<UITextViewDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate>
{

    BOOL     phoneIsRight;
    NSArray *uploadImagesArray;

}
@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView       *textBackView;
@property (nonatomic, strong) UITextView   *textView;
@property (nonatomic, strong) UILabel      *placeholderLabel;
@property (nonatomic, strong) UILabel      *numberLabel;
@property (nonatomic, strong) UIView       *imageBackView;
@property (nonatomic, strong) UIButton     *addButton;
@property (nonatomic, strong) UITextField  *phoneTextField;
@property (nonatomic, strong) UIButton     *publiahButton;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation OADFeedbackViewController

- (QTCheckImageScrollView *)checkImageScrollView {

    if (!_checkImageScrollView) {

        _checkImageScrollView = [QTCheckImageScrollView new];

    }

    return _checkImageScrollView;

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    [self addTextFieldNotification];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(openKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

    [self removeTextFieldNotification];
    [self removeFirstResponder];

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

    CGRect frame      = self.scrollView.frame;
    frame.size.height = self.contentView.height - frameOfKeyboard.size.height;

    [UIView animateWithDuration:duration delay:0 options:option animations:^{

        self.scrollView.frame = frame;

    } completion:^(BOOL finished) {

    }];

}

- (void) hideKeyboard:(NSNotification *)notification {

    NSTimeInterval duration       = \
    [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions option = \
    [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];

    CGRect frame      = self.scrollView.frame;
    frame.size.height = self.contentView.height - 50 *Scale_Height;

    [UIView animateWithDuration:duration delay:0 options:option animations:^{

        self.scrollView.frame = frame;

    } completion:^(BOOL finished) {

    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)setNavigationController {

    self.navTitle     = @"意见反馈";
    self.leftItemText = @"返回";
    [super setNavigationController];

}

- (void)buildSubView {

    [super buildSubView];
    
    self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, Screen_Width, self.view.height - SafeAreaTopHeight - SafeAreaBottomHeight - 50 *Scale_Height);
    UIScrollView *scrollView   = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, self.contentView.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate        = self;
    scrollView.keyboardDismissMode = YES;
    scrollView.pagingEnabled    = YES;
    scrollView.scrollEnabled    = YES;
    [self.contentView addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    self.scrollView = scrollView;

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, scrollView.width / 2 - 20 *Scale_Width, 40 *Scale_Height)
                                                     title:@"遇到问题"
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [scrollView addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Width;
        button.layer.borderColor   = MainColor.CGColor;
        button.layer.borderWidth   = 0.5f *Scale_Width;
        [button setTitleColor:MainColor forState:UIControlStateNormal];
        [button setTitleColor:TextBlackColor forState:UIControlStateNormal];
        button.selected            = YES;
        self.leftButton = button;

    }

    {

        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(scrollView.width / 2 + 5 *Scale_Width, 10 *Scale_Height, scrollView.width / 2 - 20 *Scale_Width, 40 *Scale_Height)
                                                     title:@"新功能建议"
                                           backgroundImage:nil
                                                       tag:1001
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        [scrollView addSubview:button];
        button.clipsToBounds   = YES;
        button.backgroundColor = [UIColor whiteColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Width;
        button.layer.borderColor   = LineColor.CGColor;
        button.layer.borderWidth   = 0.5f *Scale_Width;
        [button setTitleColor:MainColor forState:UIControlStateNormal];
        [button setTitleColor:TextBlackColor forState:UIControlStateNormal];
        self.rightButton = button;

    }

    UIView *textBackView         = [[UIView alloc]initWithFrame:CGRectMake(15 *Scale_Width, 60 *Scale_Height, Screen_Width - 30 *Scale_Width, 195 *Scale_Height + Add_Button_Width)];
    textBackView.backgroundColor = [UIColor whiteColor];
    textBackView.layer.masksToBounds = YES;
    textBackView.layer.cornerRadius  = 3 *Scale_Width;
    textBackView.layer.borderColor   = LineColor.CGColor;
    textBackView.layer.borderWidth   = 0.5f *Scale_Width;
    [scrollView addSubview:textBackView];
    self.textBackView = textBackView;

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(5 *Scale_Width, 5 *Scale_Height, textBackView.width - 10 *Scale_Width, textBackView.height - 25 *Scale_Height - Add_Button_Width)];
    textView.textColor   = TextBlackColor;
    textView.delegate    = self;
    textView.backgroundColor = [UIColor clearColor];
    textView.keyboardType    = UIKeyboardTypeDefault;
    textView.returnKeyType   = UIReturnKeyDone;
    textView.alwaysBounceVertical = NO;
    textView.editable        = YES;
    textView.textAlignment   = NSTextAlignmentLeft;
    textView.scrollEnabled   = NO;
    textView.font            = UIFont_15;

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    style.lineSpacing = 6;
    NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};

    //  默认显示文字
    UILabel *placeholderLabel = [UILabel createLabelWithFrame:CGRectZero
                                                    labelType:kLabelNormal
                                                         text:nil
                                                         font:UIFont_15
                                                    textColor:TextGrayColor
                                                textAlignment:NSTextAlignmentLeft
                                                          tag:200];
    placeholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"请输入您遇到的问题（不超过150字）" attributes:attribute];
    [textBackView addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;

    CGRect frame       = textView.frame;
    frame.origin.x    += 6 *Scale_Width;
    frame.size.height  = 30.f *Scale_Height;
    frame.origin.y    += 6 *Scale_Height;
    frame.size.width   = textBackView.width - 36 *Scale_Width;
    self.placeholderLabel.frame = frame;

    [textBackView addSubview:textView];
    self.textView = textView;

    UILabel *numberLabel = [UILabel createLabelWithFrame:CGRectMake(textBackView.width - 115 *Scale_Width, textBackView.height - 35 *Scale_Height - Add_Button_Width, 100 *Scale_Width, 20 *Scale_Height)
                                               labelType:kLabelNormal
                                                    text:@"150/150"
                                                    font:UIFont_15
                                               textColor:TextGrayColor
                                           textAlignment:NSTextAlignmentRight
                                                     tag:200];
    [textBackView addSubview:numberLabel];
    self.numberLabel = numberLabel;

    UIView *imageBackView = [[UIView alloc] initWithFrame:CGRectMake(10 *Scale_Width, textView.y + textView.height + 10 *Scale_Height, textBackView.width - 20 *Scale_Width, Add_Button_Width)];
    imageBackView.backgroundColor = [UIColor clearColor];
    [textBackView addSubview:imageBackView];
    self.imageBackView = imageBackView;

    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 10 *Scale_Height, Add_Button_Width - 10 *Scale_Height, Add_Button_Width - 10 *Scale_Height)
                                                 title:nil
                                       backgroundImage:[UIImage imageNamed:@"添加照片"]
                                                   tag:1002
                                                target:self
                                                action:@selector(buttonEvent:)];
    [self.imageBackView addSubview:button];
    self.addButton = button;

    UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(textBackView.x, textBackView.y + textBackView.height + 10 *Scale_Height, textBackView.width, 50 *Scale_Height)
                                                     textFieldType:k_textField_phone
                                                    delegateObject:self
                                                         leftImage:nil
                                                   placeholderText:@"请输入您的联系电话"
                                                               tag:100];
    [scrollView addSubview:textField];
    textField.backgroundColor     = [UIColor whiteColor];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius  = 3 *Scale_Width;
    textField.layer.borderColor   = LineColor.CGColor;
    textField.layer.borderWidth   = 0.5f *Scale_Width;
    self.phoneTextField = textField;

    scrollView.contentSize = CGSizeMake(scrollView.width, textField.y + textField.height + 10 *Scale_Height);

    {
        
        self.bottomView.hidden = NO;
        self.bottomView.backgroundColor = CarOadColor(129, 196, 255);
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 0, Screen_Width, 50 *Scale_Height)
                                                     title:@"提交"
                                           backgroundImage:nil
                                                       tag:1003
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor = CarOadColor(129, 196, 255);
        button.titleLabel.font = UIFont_M_17;
        [button setTitleColor:CarOadColor(215, 233, 248) forState:UIControlStateNormal];
        [self.bottomView addSubview:button];
        self.publiahButton = button;
        self.publiahButton.enabled = NO;

    }

}


- (void) buttonEvent:(UIButton *)sender {

    if (sender.tag == 1000) {

        self.leftButton.selected = YES;
        self.rightButton.selected = NO;
        self.leftButton.layer.borderColor = MainColor.CGColor;
        self.rightButton.layer.borderColor = LineColor.CGColor;

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 6;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
        self.placeholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"请输入您遇到的问题（不超过150字）" attributes:attribute];

    } else if (sender.tag == 1001) {

        self.leftButton.selected = NO;
        self.rightButton.selected = YES;
        self.leftButton.layer.borderColor = LineColor.CGColor;
        self.rightButton.layer.borderColor = MainColor.CGColor;

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineSpacing:0];
        style.lineSpacing = 6;
        NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
        self.placeholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"请输入您的建议内容（不超过150字）" attributes:attribute];

    } else if (sender.tag == 1002) {

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

    } else if (sender.tag == 1003) {

        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

        if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {

            OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];

            [params setObject:accountInfo.user_id forKey:@"userId"];
            [params setObject:@"2" forKey:@"source"];

        } else {

            return;

        }

        if (self.leftButton.selected == YES) {

            [params setObject:@"0" forKey:@"adviceMark"];

        } else {

            [params setObject:@"1" forKey:@"adviceMark"];

        }

        if (self.textView.text.length > 0) {

            [params setObject:self.textView.text forKey:@"adviceContent"];

        } else {

            if (self.leftButton.selected == YES) {

                [MBProgressHUD showMessageTitle:@"请输入您遇到的问题" toView:self.view afterDelay:1.5f];

            } else {

                [MBProgressHUD showMessageTitle:@"请输入您的建议内容" toView:self.view afterDelay:1.5f];

            }

            return;
        }

        if (self.phoneTextField.text.length > 0) {

            [params setObject:self.phoneTextField.text forKey:@"phone"];

        } else {

            [MBProgressHUD showMessageTitle:@"请输入您的联系方式" toView:self.view afterDelay:1.5f];
            return;
        }

        [MBProgressHUD showMessage:nil toView:self.view];

        if (uploadImagesArray.count > 0) {

            [OSSImageUploader asyncUploadImages:uploadImagesArray complete:^(NSArray<NSString *> *names, UploadImageState state) {
                
                if (state == UploadImageFailed) {
                    
                    [MBProgressHUD showMessageTitle:@"照片上传失败，请重新上传" toView:self.view afterDelay:1.5f];
                    
                } else {
                    
                    NSString *imageString = [names componentsJoinedByString:@","];
                    
                    [params setObject:imageString forKey:@"adviceImg"];
                    
                    [FeedbackViewModel requestPost_publishFeedbackNetWorkingDataWithParams:params success:^(id info, NSInteger count) {
                        
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showMessageTitle:@"提交成功" toView:self.view afterDelay:1.5f];
                        int64_t delayInSeconds = 1.6f;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

                            [self.navigationController popViewControllerAnimated:YES];

                        });

                    } error:^(NSString *errorMessage) {

                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

                    } failure:^(NSError *error) {

                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showMessageTitle:@"提交失败，请重新提交" toView:self.view afterDelay:1.5f];

                    }];

                }

            }];

        } else {

            CarOadLog(@"self.params --- %@",params);
            [params setObject:@"" forKey:@"adviceImg"];
            
            [FeedbackViewModel requestPost_publishFeedbackNetWorkingDataWithParams:params success:^(id info, NSInteger count) {

                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"提交成功" toView:self.view afterDelay:1.5f];
                int64_t delayInSeconds = 1.6f;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){

                    [self.navigationController popViewControllerAnimated:YES];

                });

            } error:^(NSString *errorMessage) {

                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.5f];

            } failure:^(NSError *error) {

                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showMessageTitle:@"提交失败，请重新提交" toView:self.view afterDelay:1.5f];

            }];

        }

    } else if (sender.tag >= 3000 && sender.tag < 5000) {

        [self.checkImageScrollView showwithTag:sender.tag - 3000];

    } else if (sender.tag >= 5000) {

        NSMutableArray *tmpImageArray = [NSMutableArray array];
        for (UIImage *image in uploadImagesArray) {

            [tmpImageArray addObject:image];

        }
        [tmpImageArray removeObjectAtIndex:sender.tag - 5000];
        [self addImageForContentViewWithImageArray:tmpImageArray];

    }

}

- (void) addImageForContentViewWithImageArray:(NSArray *)imageArray {

    if (imageArray.count > 4) {

        //  最多选择四张照片
        [MBProgressHUD showMessageTitle:@"最多可添加四张照片" toView:self.view afterDelay:1.5f];
        return;

    }

    uploadImagesArray                     = [imageArray copy];
    self.checkImageScrollView.imagesArray = [imageArray copy];

    for (UIView *subView in self.imageBackView.subviews) {

        [subView removeFromSuperview];

    }

    CGRect frame      = CGRectZero;
    frame.size.width  = Add_Button_Width;
    frame.size.height = Add_Button_Width;

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

        UIImage *image = imageArray[i];

        UIView *imageView = [self createImageViewWithFrame:frame image:image tag:i + 3000];
        [self.imageBackView addSubview:imageView];

    }

    {

        if (imageArray.count < 3) {

            CGRect buttonRect      = CGRectZero;
            buttonRect.size.width  = Add_Button_Width - 10 *Scale_Height;
            buttonRect.size.height = Add_Button_Width - 10 *Scale_Height;

            buttonRect.origin.x = (frame.size.height + 10 *Scale_Height) *imageArray.count;
            buttonRect.origin.y = 10 *Scale_Height;

            UIButton *button = [UIButton createButtonWithFrame:buttonRect
                                                         title:nil
                                               backgroundImage:[UIImage imageNamed:@"添加照片"]
                                                           tag:1002
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            [self.imageBackView addSubview:button];
            self.addButton = button;

            self.imageBackView.frame = CGRectMake(10 *Scale_Width, self.textView.y + self.textView.height + 10 *Scale_Height, self.textBackView.width - 20 *Scale_Width, Add_Button_Width + button.y);

            CGRect frame      = self.textBackView.frame;
            frame.size.height = self.imageBackView.y + self.imageBackView.height + 10 *Scale_Height;
            self.textBackView.frame = frame;
            self.phoneTextField.frame = CGRectMake(self.textBackView.x, self.textBackView.y + self.textBackView.height + 10 *Scale_Height, self.textBackView.width, 50 *Scale_Height);
            self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.phoneTextField.y + self.phoneTextField.height + 10 *Scale_Height);

        } else {

            CGRect buttonRect      = CGRectZero;
            buttonRect.size.width  = Add_Button_Width - 10 *Scale_Height;
            buttonRect.size.height = Add_Button_Width - 10 *Scale_Height;

            buttonRect.origin.x = (frame.size.height + 10 *Scale_Height) *(imageArray.count - 3);
            buttonRect.origin.y = 10 *Scale_Height + Add_Button_Width;
            UIButton *button = [UIButton createButtonWithFrame:buttonRect
                                                         title:nil
                                               backgroundImage:[UIImage imageNamed:@"添加照片"]
                                                           tag:1002
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            [self.imageBackView addSubview:button];
            self.addButton = button;

            if (imageArray.count < 4) {

                button.hidden = NO;

            } else {

                button.hidden = YES;

            }

            self.imageBackView.frame = CGRectMake(12 *Scale_Width, self.textView.y + self.textView.height + 10 *Scale_Height, self.scrollView.width - 24 *Scale_Width, Add_Button_Width + button.y);
            CGRect frame      = self.textBackView.frame;
            frame.size.height = self.imageBackView.y + self.imageBackView.height + 10 *Scale_Height;
            self.textBackView.frame = frame;
            self.phoneTextField.frame = CGRectMake(self.textBackView.x, self.textBackView.y + self.textBackView.height + 10 *Scale_Height, self.textBackView.width, 50 *Scale_Height);
            self.scrollView.contentSize = CGSizeMake(self.scrollView.width, self.phoneTextField.y + self.phoneTextField.height + 10 *Scale_Height);

        }

    }

}

- (UIView *) createImageViewWithFrame:(CGRect)frame image:(UIImage *)image tag:(NSInteger)tag {

    UIView *imageBackView         = [[UIView alloc] initWithFrame:frame];
    imageBackView.backgroundColor = [UIColor clearColor];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10 *Scale_Width, frame.size.width - 10 *Scale_Width, frame.size.width - 10 *Scale_Width)];
    imageView.image = image;
    imageView.contentMode  = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageBackView addSubview:imageView];

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
                                                         tag:tag + 2000
                                                      target:self
                                                      action:@selector(buttonEvent:)];
    [imageBackView addSubview:deleteButton];

    return imageBackView;

}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;{

    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;{

    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView;{

}

- (void)textViewDidEndEditing:(UITextView *)textView;{



}

- (void) textViewDidChange:(UITextView *)textView;{

    if (textView.text.length == 0) {

        [self.placeholderLabel setHidden:NO];

    } else {

        [self.placeholderLabel setHidden:YES];

    }

    UITextRange    *selectedRange = [textView markedTextRange];
    UITextPosition *pos           = [textView positionFromPosition:selectedRange.start offset:0];

    if (selectedRange && pos) {

        return;

    }

    NSString  *nsTextContent = textView.text;
    NSInteger  existTextNum  = nsTextContent.length;

    if (existTextNum >= MAX_LIMIT_NUMS) {

        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        [textView setText:s];
        [MBProgressHUD showMessageTitle:@"字数不能超过150字" toView:self.view afterDelay:1.5f];
    }

    //不让显示负数 口口日
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];

}

- (void) textViewDidChangeSelection:(UITextView *)textView;{



}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text rangeOfString:@"\n"].location != NSNotFound) {

        [textView resignFirstResponder];

        return NO;

    }

    UITextRange    *selectedRange = [textView markedTextRange];
    UITextPosition *pos           = [textView positionFromPosition:selectedRange.start offset:0];

    if (selectedRange && pos) {

        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset   = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange   offsetRange = NSMakeRange(startOffset, endOffset - startOffset);

        if (offsetRange.location < MAX_LIMIT_NUMS) {

            return YES;

        } else {

            [MBProgressHUD showMessageTitle:@"字数不能超过150字" toView:self.view afterDelay:1.5f];
            return NO;

        }

    }

    NSString  *comcatstr   = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger  caninputlen = MAX_LIMIT_NUMS - comcatstr.length;

    if (caninputlen >= 0) {

        return YES;

    } else {

        NSInteger len = text.length + caninputlen;
        NSRange   rg  = {0,MAX(len,0)};

        if (rg.length > 0) {

            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            self.numberLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)MAX_LIMIT_NUMS];
        }

        [MBProgressHUD showMessageTitle:@"字数不能超过150字" toView:self.view afterDelay:1.5f];

        return NO;

    }

}

- (void) addTextFieldNotification {

    [self.phoneTextField addTarget:self
                            action:@selector(phoneTextFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];

}

- (void) removeTextFieldNotification {

    [self.phoneTextField removeTarget:self
                               action:@selector(phoneTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];

}

- (void) removeFirstResponder; {

    [self.phoneTextField resignFirstResponder];

}

#pragma mark - Notification Method
-(void)phoneTextFieldDidChange:(UITextField *)textField
{

    NSString *toBeString = textField.text;
    if (toBeString.length > 11)
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:11];
        if (rangeIndex.length == 1)
        {
            textField.text = [toBeString substringToIndex:11];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 11)];
            textField.text = [toBeString substringWithRange:rangeRange];

        }

        [self.phoneTextField resignFirstResponder];

    } else if (toBeString.length == 11) {

        [self.phoneTextField resignFirstResponder];

    }

    BOOL isMobilePhone = [IDCardNumberconfirmationInquiryTool isMobilePhone:textField.text];

    if (isMobilePhone == YES) {

        phoneIsRight = YES;

    } else {

        phoneIsRight = NO;

    }

    [self publishButtonIsCanClick];

}

#pragma mark - textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    return YES;

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    return YES;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {


}

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (textField.tag == 100) {

        BOOL isMobilePhone = [IDCardNumberconfirmationInquiryTool isMobilePhone:textField.text];

        if (isMobilePhone == YES) {

            [self.phoneTextField resignFirstResponder];

        } else {

            if (textField.text.length > 0) {

                [MBProgressHUD showMessageTitle:@"您输入的手机号格式不正确，请重新输入" toView:self.view afterDelay:1.8f];

            }

        }

    }

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    //  限制输入字数
    if ([string rangeOfString:@"\n"].location != NSNotFound) {

        [textField resignFirstResponder];

        return NO;

    }

    return YES;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];

    return YES;

}

- (void) publishButtonIsCanClick {

    if (phoneIsRight == YES) {

        self.publiahButton.enabled = YES;
        [self.publiahButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.publiahButton.backgroundColor = MainColor;
        self.bottomView.backgroundColor = MainColor;
        
    } else {

        self.publiahButton.enabled = NO;
        [self.publiahButton setTitleColor:CarOadColor(215, 233, 248) forState:UIControlStateNormal];
        self.publiahButton.backgroundColor = CarOadColor(129, 196, 255);
        self.bottomView.backgroundColor = CarOadColor(129, 196, 255);
        
    }

}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];

    if (uploadImagesArray.count == 4) {

    } else {

        NSMutableArray *tmpImageArray = [NSMutableArray array];

        for (UIImage *image in uploadImagesArray) {

            [tmpImageArray addObject:image];

        }
        [tmpImageArray addObject:resultImage];

        [self addImageForContentViewWithImageArray:tmpImageArray];

    }

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
