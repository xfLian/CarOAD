//
//  PublishCommentAnswerMainView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "PublishCommentAnswerMainView.h"

#define Add_Button_Width  (self.width - 54 *Scale_Width) / 3

#define LIMIT_MAX_NUMBER    200

@interface PublishCommentAnswerMainView()<UIScrollViewDelegate, UITextViewDelegate>
{
    
    NSInteger  view_tag;
    NSArray   *imagesArray;
    
}

@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;
@property (nonatomic, strong) NSMutableArray         *imageMutableArray;

@property (nonatomic, strong) UIView   *backView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) NSDictionary   *attributes;
@property (nonatomic, strong) UILabel        *firstPlaceholderLabel;
@property (nonatomic, strong) UILabel        *secondPlaceholderLabel;
@property (nonatomic, strong) UIView         *contentBackView;
@property (nonatomic, strong) UIButton       *addButton;
@property (nonatomic, strong) UITextView     *textView;
@property (nonatomic, strong) UIView         *imageBackView;

@end

@implementation PublishCommentAnswerMainView

- (void) buildsubviewWithIsQA:(BOOL)isQA; {
    
    self.backgroundColor = BackGrayColor;
    
    {
        
        UIView *contentBackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
        contentBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentBackView];
        self.contentBackView = contentBackView;
        
        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(15 *Scale_Width, 15 *Scale_Height, self.width - 30 *Scale_Width, 60 *Scale_Height)
                                                  labelType:kLabelNormal
                                                       text:self.content
                                                       font:UIFont_17
                                                  textColor:TextGrayColor
                                              textAlignment:NSTextAlignmentLeft
                                                        tag:100];
        titleLabel.numberOfLines = 2;
        [contentBackView addSubview:titleLabel];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15 *Scale_Width, titleLabel.y + titleLabel.height + 10 *Scale_Height, self.width - 30 *Scale_Width, 140 *Scale_Height + 20)];
        textView.textColor   = TextBlackColor;
        textView.font        = UIFont_16;
        textView.delegate    = self;
        textView.backgroundColor = [UIColor clearColor];
        textView.keyboardType    = UIKeyboardTypeDefault;
        textView.returnKeyType   = UIReturnKeyDone;
        textView.alwaysBounceVertical = NO;
        textView.editable        = YES;
        
        CGRect frame       = textView.frame;
        frame.origin.x    += 5 *Scale_Width;
        frame.size.height  = 20.f *Scale_Height;
        frame.origin.y    += 7 *Scale_Height;
        
        //  默认显示文字
        UILabel *firstPlaceholderLabel = [UILabel createLabelWithFrame:frame
                                                             labelType:kLabelNormal
                                                                  text:@"请输入你的评论内容"
                                                                  font:UIFont_16
                                                             textColor:TextGrayColor
                                                         textAlignment:NSTextAlignmentLeft
                                                                   tag:200];
        [contentBackView addSubview:firstPlaceholderLabel];
        self.firstPlaceholderLabel = firstPlaceholderLabel;
        
        [contentBackView addSubview:textView];
        self.textView = textView;

        if (isQA == YES) {

            textView.frame = CGRectMake(15 *Scale_Width, titleLabel.y + titleLabel.height + 10 *Scale_Height, self.width - 30 *Scale_Width, 140 *Scale_Height + 20);

            UIView *imageBackView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, textView.y + textView.height + 10 *Scale_Height, contentBackView.width - 30 *Scale_Width, Add_Button_Width)];
            imageBackView.backgroundColor = [UIColor clearColor];
            [contentBackView addSubview:imageBackView];
            self.imageBackView = imageBackView;

            UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 10 *Scale_Height, Add_Button_Width - 10 *Scale_Height, Add_Button_Width - 10 *Scale_Height)
                                                         title:nil
                                               backgroundImage:[UIImage imageNamed:@"添加照片"]
                                                           tag:2001
                                                        target:self
                                                        action:@selector(buttonEvent:)];

            button.backgroundColor = MainColor;

            [self.imageBackView addSubview:button];
            self.addButton = button;

            self.contentBackView.frame = CGRectMake(0, 0, self.width, imageBackView.y + imageBackView.height + 10 *Scale_Height);

        } else {

            textView.frame = CGRectMake(15 *Scale_Width, titleLabel.y + titleLabel.height + 10 *Scale_Height, self.width - 30 *Scale_Width, self.height - (titleLabel.y + titleLabel.height + 10 *Scale_Height));

            self.contentBackView.frame = CGRectMake(0, 0, self.width, self.height);

        }

    }
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (sender.tag >= 2000 && sender.tag < 3000) {
        
        //  添加图片
        [_delegate addImageWithImageArray:imagesArray];
        
    } else if (sender.tag >= 3000 && sender.tag < 4000) {
        
        //  点击图片预览
        [self.checkImageScrollView showwithTag:sender.tag - 3000];
        
    } else if (sender.tag >= 4000 && sender.tag < 5000) {
        
        //  删除图片
        NSMutableArray *tmpImageArray = [NSMutableArray array];
        for (UIImage *image in imagesArray) {
            
            [tmpImageArray addObject:image];
            
        }
        [tmpImageArray removeObjectAtIndex:sender.tag - 4000];
        [self addImageForContentViewWithImageArray:tmpImageArray];
        
    }
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;{
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;{
    
    [textView resignFirstResponder];
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView;{
    
}

- (void)textViewDidEndEditing:(UITextView *)textView;{
    
}

- (void) textViewDidChange:(UITextView *)textView;{
    
    if (textView.text.length == 0) {
        
        [self.firstPlaceholderLabel setHidden:NO];
        [self.secondPlaceholderLabel setHidden:NO];
        
    } else {
        
        [self.firstPlaceholderLabel setHidden:YES];
        [self.secondPlaceholderLabel setHidden:YES];
        
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    style.lineSpacing = 4;
    NSDictionary *attribute = @{NSFontAttributeName:UIFont_16, NSParagraphStyleAttributeName:style};
        
    //  对是否有高亮文字进行处理
    NSString *toBeString = textView.text;
    NSString *lang = [(UITextInputMode*)[[UITextInputMode activeInputModes] firstObject] primaryLanguage]; // 键盘输入模式
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        
        UITextRange *selectedRange = [textView markedTextRange];
        
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        if (!position) {
            
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length >= LIMIT_MAX_NUMBER) {

                textView.attributedText = [[NSAttributedString alloc] initWithString:[toBeString substringToIndex:LIMIT_MAX_NUMBER] attributes:attribute];
                
            } else {
                
                textView.attributedText = [[NSAttributedString alloc] initWithString:toBeString attributes:attribute];
                
            }
            
        } else {

            
        }
        
    } else{
        
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        
        if (toBeString.length >= LIMIT_MAX_NUMBER) {
            
            textView.attributedText = [[NSAttributedString alloc] initWithString:[toBeString substringToIndex:LIMIT_MAX_NUMBER] attributes:attribute];
            
        }
        
    }
    
}

- (void) textViewDidChangeSelection:(UITextView *)textView;{
    
    
    
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text rangeOfString:@"\n"].location != NSNotFound) {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}

- (void) addImageForContentViewWithImageArray:(NSArray *)imageArray {
    
    if (imageArray.count > 1) {
        
        //  最多选择三张照片
        [_delegate showHUDMessage:@"最多选择三张照片"];
        
        return;
        
    }
    
    imagesArray = imageArray;
    
    for (UIView *subView in self.imageBackView.subviews) {
        
        [subView removeFromSuperview];
        
    }
    
    CGRect frame      = CGRectZero;
    frame.size.width  = Add_Button_Width;
    frame.size.height = Add_Button_Width;
    
    for (int i = 0; i < imageArray.count; i++) {
        
        frame.origin.x = (frame.size.width + 10 *Scale_Height) *i;
        frame.origin.y = 0;
        
        UIImage *image = imageArray[i];
        
        UIView *imageView = [self createImageViewWithFrame:frame image:image tag:i + 3000];
        [self.imageBackView addSubview:imageView];
        
        self.checkImageScrollView.imagesArray = [imageArray copy];
        
    }
    
    {
        
        if (imageArray.count < 1) {
            
            CGRect buttonRect      = CGRectZero;
            buttonRect.size.width  = Add_Button_Width - 10 *Scale_Height;
            buttonRect.size.height = Add_Button_Width - 10 *Scale_Height;
            
            buttonRect.origin.x = (frame.size.height + 10 *Scale_Height) *imageArray.count;
            buttonRect.origin.y = 10 *Scale_Height;
            
            UIButton *button = [UIButton createButtonWithFrame:buttonRect
                                                         title:nil
                                               backgroundImage:[UIImage imageNamed:@"添加照片"]
                                                           tag:2001
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            
            button.backgroundColor = MainColor;
            
            [self.imageBackView addSubview:button];

        } else {

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
                                                         tag:tag + 1000
                                                      target:self
                                                      action:@selector(buttonEvent:)];
    [imageBackView addSubview:deleteButton];
    
    return imageBackView;
    
}

- (NSString *)getContentText {
    
    return self.textView.text;
    
}

@end
