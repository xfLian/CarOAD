//
//  AddJobExperiencesCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/18.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AddJobExperiencesCell.h"

#define MAX_LIMIT_NUMS 200

@interface AddJobExperiencesCell()<UITextViewDelegate>

@property (nonatomic, strong) UILabel    *typeLabel;
@property (nonatomic, strong) UILabel    *titleLabel;
@property (nonatomic, strong) UILabel    *placeholderLabel;
@property (nonatomic, strong) UILabel    *numberLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView     *lineView;

@end

@implementation AddJobExperiencesCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.typeLabel = [UILabel createLabelWithFrame:CGRectZero
                                         labelType:kLabelNormal
                                              text:@"*"
                                              font:UIFont_15
                                         textColor:CarOadColor(210, 33, 33)
                                     textAlignment:NSTextAlignmentLeft
                                               tag:100];
    [self.contentView addSubview:self.typeLabel];
    
    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@""
                                               font:UIFont_15
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.textColor   = TextGrayColor;
    textView.delegate    = self;
    textView.backgroundColor = [UIColor clearColor];
    textView.keyboardType    = UIKeyboardTypeDefault;
    textView.returnKeyType   = UIReturnKeyDefault;
    textView.alwaysBounceVertical = NO;
    textView.editable        = YES;
    textView.textAlignment   = NSTextAlignmentLeft;
    textView.scrollEnabled   = YES;
    textView.font            = UIFont_15;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    style.lineSpacing = 6;
    NSDictionary *attribute = @{NSFontAttributeName:UIFont_15, NSParagraphStyleAttributeName:style};
    
    //  默认显示文字
    UILabel *placeholderLabel = [UILabel createLabelWithFrame:CGRectZero
                                                    labelType:kLabelNormal
                                                         text:nil
                                                         font:UIFont_16
                                                    textColor:TextGrayColor
                                                textAlignment:NSTextAlignmentLeft
                                                          tag:200];
    placeholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"请填写你的工作内容" attributes:attribute];
    [self.contentView addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
    
    [self.contentView addSubview:textView];
    self.textView = textView;
    
    UILabel *numberLabel = [UILabel createLabelWithFrame:CGRectZero
                                               labelType:kLabelNormal
                                                    text:@"200/200"
                                                    font:UIFont_15
                                               textColor:TextGrayColor
                                           textAlignment:NSTextAlignmentRight
                                                     tag:200];
    [self.contentView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.lineView];
    
}

- (void) layoutSubviews {
    
    [self.typeLabel sizeToFit];
    self.typeLabel.frame = CGRectMake(15 *Scale_Width, (45 *Scale_Height - self.typeLabel.height) / 2, self.typeLabel.width, self.typeLabel.height);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(self.typeLabel.x + self.typeLabel.width + 5 *Scale_Width, 0, self.titleLabel.width, 45 *Scale_Height);

    self.textView.frame   = CGRectMake(self.titleLabel.x, self.titleLabel.y + self.titleLabel.height, Screen_Width - 15 *Scale_Width - self.titleLabel.x, self.contentView.height - (self.titleLabel.y + self.titleLabel.height) - 25 *Scale_Height);
    
    CGRect frame       = self.textView.frame;
    frame.origin.x    += 6 *Scale_Width;
    frame.size.height  = 30.f *Scale_Height;
    frame.origin.y    += 5 *Scale_Height;
    frame.size.width   = Screen_Width - 20 *Scale_Width - self.titleLabel.x;
    self.placeholderLabel.frame = frame;
    
    self.numberLabel.frame = CGRectMake(Screen_Width - 115 *Scale_Width, self.contentView.height - 25 *Scale_Height, 100 *Scale_Width, 20 *Scale_Height);
    
    self.lineView.frame = CGRectMake(self.titleLabel.x, 45 *Scale_Height - 0.5f, self.contentView.width - self.titleLabel.x, 0.5f);
    
}

- (void) loadContent {
    
    NSDictionary *model        = self.data;
    NSString     *title        = model[@"title"];
    NSString     *placeholder  = model[@"placeholder"];
    NSString     *content      = model[@"content"];
    
    if (title.length > 0) {
        
        self.titleLabel.text = title;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (placeholder.length > 0) {
        
        self.placeholderLabel.text = placeholder;
        
    } else {
        
        self.placeholderLabel.text = @"";
        
    }
    
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
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;{
    
    if (self.delegate != NULL && [self.delegate respondsToSelector:@selector(textViewShouldBeginEditing)]) {
        
        [self.delegate textViewShouldBeginEditing];
        
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;{
    
    [self.delegate getTextViewText:textView.text forRow:self.row];
    
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
        [self.delegate showErrorMessage:@"字数不能超过200字"];
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
            
            [self.delegate showErrorMessage:@"字数不能超过200字"];
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
        
        [self.delegate showErrorMessage:@"字数不能超过200字"];
        
        return NO;
        
    }
    
}

@end
