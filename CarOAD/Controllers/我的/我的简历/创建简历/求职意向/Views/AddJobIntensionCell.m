//
//  AddJobIntensionCell.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "AddJobIntensionCell.h"

@interface AddJobIntensionCell()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel     *typeLabel;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *placeholderLabel;
@property (nonatomic, strong) UILabel     *numberLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIButton    *button;
@property (nonatomic, strong) UIView      *lineView;

@end

@implementation AddJobIntensionCell

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
                                               font:UIFont_16
                                          textColor:TextBlackColor
                                      textAlignment:NSTextAlignmentLeft
                                                tag:100];
    [self.contentView addSubview:self.titleLabel];
    
    UITextField *textField    = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.font            = UIFont_15;
    textField.textColor       = TextGrayColor;
    textField.textAlignment   = NSTextAlignmentRight;
    textField.delegate        = self;
    textField.tag             = 100;
    textField.backgroundColor = [UIColor clearColor];
    textField.placeholder     = @"";
    textField.returnKeyType   = UIReturnKeyDefault;
    textField.keyboardType    = UIKeyboardTypeDefault;
    [self.contentView addSubview:textField];
    self.textField = textField;
    
    [self.textField addTarget:self
                            action:@selector(textFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.contentMode  = UIViewContentModeScaleAspectFit;
    imageView.image        = [UIImage imageNamed:@"arrow_right_gray"];
    [self.contentView addSubview:imageView];
    self.arrowImageView = imageView;
    
    UIButton *button = [UIButton createButtonWithFrame:CGRectZero
                                                 title:nil
                                       backgroundImage:nil
                                                   tag:1000
                                                target:self
                                                action:@selector(buttonEvent:)];
    [self.contentView addSubview:button];
    self.button = button;
    
    self.lineView                 = [[UIView alloc] initWithFrame:CGRectZero];
    self.lineView.backgroundColor = LineColor;
    [self.contentView addSubview:self.lineView];
    
}

- (void) layoutSubviews {
    
    [self.typeLabel sizeToFit];
    self.typeLabel.frame = CGRectMake(15 *Scale_Width, (45 *Scale_Height - self.typeLabel.height) / 2, self.typeLabel.width, self.typeLabel.height);
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(self.typeLabel.x + self.typeLabel.width + 5 *Scale_Width, 0, self.titleLabel.width, 45 *Scale_Height);
    
    self.arrowImageView.frame = CGRectMake(Screen_Width - 22 *Scale_Height, (self.contentView.height - 14 *Scale_Height) / 2, 7 *Scale_Height, 14 *Scale_Height);
    
    self.textField.frame   = CGRectMake(self.titleLabel.x + self.titleLabel.width + 10 *Scale_Width, 0, self.arrowImageView.x - 20 *Scale_Width - self.titleLabel.x - self.titleLabel.width, self.contentView.height);
    
    self.button.frame = self.contentView.bounds;
    
    self.lineView.frame = CGRectMake(self.titleLabel.x, 45 *Scale_Height - 0.5f, self.contentView.width - self.titleLabel.x, 0.5f);
    
}

- (void) buttonEvent:(UIButton *)sender {
    
    [self.delegate clickGetJobInfoWithRow:self.row];
    
}

- (void) loadContent {
    
    NSDictionary *model        = self.data;
    NSString     *title        = model[@"title"];
    NSString     *placeholder  = model[@"placeholder"];
    NSString     *content      = model[@"content"];
    NSString     *isShowButton = model[@"isShowButton"];
    NSString     *isPhoneKey   = model[@"isPhoneKey"];
    
    if (title.length > 0) {
        
        self.titleLabel.text = title;
        
    } else {
        
        self.titleLabel.text = @"";
        
    }
    
    if (placeholder.length > 0) {
        
        self.textField.placeholder = placeholder;
        
    } else {
        
        self.textField.placeholder = @"";
        
    }
    
    if (content.length > 0) {
        
        self.textField.text = content;
        
    } else {
        
        self.textField.text = @"";
        
    }
    
    if (isShowButton.length > 0 && [isShowButton integerValue] == 1) {
        
        self.arrowImageView.hidden = NO;
        self.button.hidden = NO;
        
    } else {
        
        self.arrowImageView.hidden = YES;
        self.button.hidden = YES;
        
    }
    
    if (isPhoneKey.length > 0 && [isPhoneKey integerValue] == 1) {
        
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        
    } else {
        
        self.textField.keyboardType = UIKeyboardTypeDefault;
        
    }
    
}

- (void)dealloc {
    
    [self.textField removeTarget:self
                               action:@selector(textFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    
    if (self.textField.text.length > 14) {
        
        NSRange rangeRange = [textField.text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 14)];
        self.textField.text = [textField.text substringWithRange:rangeRange];
        [self.textField resignFirstResponder];
        
        [self.delegate showCellErrorMessage];

        int64_t delayInSeconds = 1.2f;      // 延迟的时间
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // do something
            
            [self.textField becomeFirstResponder];
            
        });
        
    }
}

#pragma mark - textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    [self.delegate getTextFieldText:textField.text forRow:self.row];
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    

    
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

@end
