//
//  UserInfomationEdiSkillCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/6.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "UserInfomationEdiSkillCell.h"

#define MAX_LIMIT_NUMS 50

@interface UserInfomationEdiSkillCell()<UITextViewDelegate>

@property (nonatomic, strong) UILabel    *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel    *placeholderLabel;
@property (nonatomic, strong) UILabel    *numberLabel;

@end

@implementation UserInfomationEdiSkillCell

@dynamic delegate;

- (void)setupCell {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    
}

- (void)buildSubview {

    self.contentView.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [UILabel createLabelWithFrame:CGRectZero
                                          labelType:kLabelNormal
                                               text:@"擅长技能"
                                               font:UIFont_13
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentCenter
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];

    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
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
    placeholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"一句话介绍自己所擅长的技能（不超过50字）" attributes:attribute];
    [self.contentView addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;

    [self.contentView addSubview:textView];
    self.textView = textView;

    UILabel *numberLabel = [UILabel createLabelWithFrame:CGRectZero
                                                    labelType:kLabelNormal
                                                         text:@"50/50"
                                                         font:UIFont_15
                                                    textColor:TextGrayColor
                                                textAlignment:NSTextAlignmentRight
                                                          tag:200];
    [self.contentView addSubview:numberLabel];
    self.numberLabel = numberLabel;

}

- (void)layoutSubviews {

    self.titleLabel.frame = CGRectMake(0, 5 *Scale_Height, Screen_Width, 20 *Scale_Height);
    self.textView.frame   = CGRectMake(15 *Scale_Width, 30 *Scale_Height, Screen_Width - 30 *Scale_Width, 100 *Scale_Height);

    CGRect frame       = self.textView.frame;
    frame.origin.x    += 5 *Scale_Width;
    frame.size.height  = 30.f *Scale_Height;
    frame.origin.y    += 6 *Scale_Height;
    frame.size.width   = Screen_Width - 35 *Scale_Width;
    self.placeholderLabel.frame = frame;

    self.numberLabel.frame = CGRectMake(Screen_Width - 115 *Scale_Width, self.contentView.height - 25 *Scale_Height, 100 *Scale_Width, 20 *Scale_Height);

}

- (void)loadContent {

    NSString *userSkill = self.data;

    if (userSkill.length > 0) {

        self.textView.text = userSkill;
        self.placeholderLabel.hidden = YES;
        NSString  *nsTextContent = self.textView.text;
        NSInteger existTextNum   = nsTextContent.length;
        self.numberLabel.text    = [NSString stringWithFormat:@"%ld/%d",MAX(0,MAX_LIMIT_NUMS - existTextNum),MAX_LIMIT_NUMS];

    } else {

        self.textView.text = @"";
        self.placeholderLabel.hidden = NO;
        self.numberLabel.text = @"50/50";

    }

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

    [self.delegate getUserSkillString:textView.text];

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
        [self.delegate showErrorMessage:@"字数不能超过50字"];
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

            [self.delegate showErrorMessage:@"字数不能超过50字"];
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

        [self.delegate showErrorMessage:@"字数不能超过50字"];

        return NO;

    }

}

@end
