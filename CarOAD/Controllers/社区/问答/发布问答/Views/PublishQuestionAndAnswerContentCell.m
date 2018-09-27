//
//  PublishQuestionAndAnswerContentCell.m
//  CarOAD
//
//  Created by xf_Lian on 2018/1/7.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "PublishQuestionAndAnswerContentCell.h"

#define MAX_LIMIT_NUMS 200

#define Add_Button_Width (Screen_Width - 50 *Scale_Width) / 3

@interface PublishQuestionAndAnswerContentCell()<UITextViewDelegate>
{
    
    NSInteger  view_tag;
    NSArray   *imagesArray;
    
}
@property (nonatomic, strong) UILabel    *placeholderLabel;
@property (nonatomic, strong) UILabel    *numberLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton   *addButton;
@property (nonatomic, strong) UIView     *imageBackView;

@property (nonatomic, strong) QTCheckImageScrollView *checkImageScrollView;
@property (nonatomic, strong) NSMutableArray         *imageMutableArray;

@end

@implementation PublishQuestionAndAnswerContentCell

- (QTCheckImageScrollView *)checkImageScrollView {
    
    if (!_checkImageScrollView) {
        
        _checkImageScrollView = [QTCheckImageScrollView new];
        
    }
    
    return _checkImageScrollView;
    
}

- (NSMutableArray *)imageMutableArray {
    
    if (!_imageMutableArray) {
        
        _imageMutableArray = [NSMutableArray array];
        
    }
    
    return _imageMutableArray;
    
}

- (void)setupCell {
    
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
}

- (void) buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 150 *Scale_Height)];
    textView.textColor   = TextGrayColor;
    textView.delegate    = self;
    textView.backgroundColor = [UIColor clearColor];
    textView.keyboardType    = UIKeyboardTypeDefault;
    textView.returnKeyType   = UIReturnKeyDefault;
    textView.alwaysBounceVertical = NO;
    textView.editable        = YES;
    textView.textAlignment   = NSTextAlignmentLeft;
    textView.scrollEnabled   = YES;
    textView.font            = UIFont_16;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    style.lineSpacing = 2;
    NSDictionary *attribute = @{NSFontAttributeName:UIFont_16, NSParagraphStyleAttributeName:style};
    
    CGRect frame       = textView.frame;
    frame.origin.x    += 6 *Scale_Width;
    frame.origin.y    += 5 *Scale_Height;
    frame.size.height  = 100 *Scale_Height;
    frame.size.width   = Screen_Width - 36 *Scale_Width;
    
    //  默认显示文字
    UILabel *placeholderLabel = [UILabel createLabelWithFrame:frame
                                                    labelType:kLabelNormal
                                                         text:nil
                                                         font:UIFont_16
                                                    textColor:TextGrayColor
                                                textAlignment:NSTextAlignmentLeft
                                                          tag:200];
    placeholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"请输入你遇到的问题？\n请问：你开的是什么车？哪年的？跑了多少公里？出现什么问题？持续出现，还是在特定条件下才会出现？有照片吗？" attributes:attribute];
    placeholderLabel.numberOfLines = 0;
    [self.contentView addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
    
    [self.contentView addSubview:textView];
    self.textView = textView;
    
    UILabel *numberLabel = [UILabel createLabelWithFrame:CGRectMake(Screen_Width - 115 *Scale_Width, self.textView.y + self.textView.height + 5 *Scale_Height, 100 *Scale_Width, 20 *Scale_Height)
                                               labelType:kLabelNormal
                                                    text:@"200/200"
                                                    font:UIFont_15
                                               textColor:TextGrayColor
                                           textAlignment:NSTextAlignmentRight
                                                     tag:200];
    [self.contentView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    UIView *imageBackView = [[UIView alloc] initWithFrame:CGRectMake(15 *Scale_Width, numberLabel.y + numberLabel.height + 10 *Scale_Height, self.contentView.width - 30 *Scale_Width, Add_Button_Width)];
    imageBackView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:imageBackView];
    self.imageBackView = imageBackView;
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectMake(0, 10 *Scale_Height, Add_Button_Width - 10 *Scale_Height, Add_Button_Width - 10 *Scale_Height)
                                                 title:nil
                                       backgroundImage:[UIImage imageNamed:@"添加照片"]
                                                   tag:2000
                                                target:self
                                                action:@selector(buttonEvent:)];
    
    button.backgroundColor = MainColor;
    
    [self.imageBackView addSubview:button];
    self.addButton = button;
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    if (sender.tag == 2000) {
        
        //  添加图片
        [_subCellDelegate addImageWithImageArray:imagesArray];
        
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
        [_subCellDelegate deleteImageWithImageArray:tmpImageArray];
        
    }
    
}

- (void) addImageForContentViewWithImageArray:(NSArray *)imageArray {
    
    if (imageArray.count > 3) {
        
        //  最多选择三张照片
        [_subCellDelegate showErrorMessage:@"最多选择三张照片"];
        
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
        
        self.checkImageScrollView.imagesArray = [imageArray copy];
        
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
                                                           tag:2000
                                                        target:self
                                                        action:@selector(buttonEvent:)];
            
            button.backgroundColor = MainColor;
            
            [self.imageBackView addSubview:button];

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

- (void) loadContent; {
    
    NSDictionary *model      = self.data;
    NSString     *content    = model[@"content"];
    NSArray      *imageArray = model[@"images"];
    
    if (content.length > 0) {
        
        self.textView.text = content;
        self.placeholderLabel.hidden = YES;
        NSString  *nsTextContent = self.textView.text;
        NSInteger existTextNum   = nsTextContent.length;
        self.numberLabel.text    = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
        
    } else {
        
        self.textView.text = @"";
        self.placeholderLabel.hidden = NO;
        self.numberLabel.text = @"200/200";
        
    }

    [self addImageForContentViewWithImageArray:imageArray];
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;{
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;{
    
    [_subCellDelegate getTextViewText:textView.text];
    
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
        [_subCellDelegate showErrorMessage:@"字数不能超过200字"];
    }
    
    //不让显示负数 口口日
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];
    
}

- (void) textViewDidChangeSelection:(UITextView *)textView;{
    
    
    
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text rangeOfString:@"\n"].location != NSNotFound) {
        
        
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
            
            [_subCellDelegate showErrorMessage:@"字数不能超过200字"];
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
        
        [_subCellDelegate showErrorMessage:@"字数不能超过200字"];
        
        return NO;
        
    }
    
}

@end
