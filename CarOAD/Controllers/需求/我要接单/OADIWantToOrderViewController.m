//
//  OADIWantToOrderViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADIWantToOrderViewController.h"

#import "IWantToOrderViewModel.h"
#import "MyOrderDetailsData.h"

#define MAX_LIMIT_NUMS 50

@interface OADIWantToOrderViewController ()<UITextViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel      *priceLabel;
@property (nonatomic, strong) UITextField  *priceTextField;
@property (nonatomic, strong) UIView       *textBackView;
@property (nonatomic, strong) UITextView   *textView;
@property (nonatomic, strong) UILabel      *placeholderLabel;
@property (nonatomic, strong) UILabel      *numberLabel;
@property (nonatomic, strong) UIButton     *publiahButton;

@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation OADIWantToOrderViewController

- (NSMutableDictionary *)params {
    
    if (!_params) {
        
        _params = [[NSMutableDictionary alloc] init];
    }
    
    return _params;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.priceTextField addTarget:self
                            action:@selector(priceTextFieldDidChange:)
                  forControlEvents:UIControlEventEditingChanged];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.priceTextField removeTarget:self
                               action:@selector(priceTextFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];
    
}

- (void)priceTextFieldDidChange:(UITextField *)textField
{
    
    if ([self.priceTextField.text integerValue] > 99999) {
        
        NSRange rangeRange = [textField.text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 5)];
        self.priceTextField.text = [textField.text substringWithRange:rangeRange];
        [self.priceTextField resignFirstResponder];
        
        [MBProgressHUD showMessageTitle:@"请输入0-99999之间的报价" toView:self.view afterDelay:1.5f];
        int64_t delayInSeconds = 1.6f;      // 延迟的时间
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // do something
            
            [self.priceTextField becomeFirstResponder];
            
        });
    
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialization];
    
}

- (void)setNavigationController {
    
    self.navTitle     = @"接单留言";
    self.leftItemText = @"返回";
    [super setNavigationController];
    
}

- (void) initialization {
 
    MyOrderDetailsData *model = self.data;
    
    if (model.price.length > 0) {
        
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %@",model.price];
        
    } else {
        
        self.priceLabel.text = @"¥ 0";
        
    }
    
    if (model.demandId.length > 0) {
        
        [self.params setObject:model.demandId forKey:@"demandId"];
        
    }
    
    OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];
    [self.params setObject:accountInfo.user_id forKey:@"userId"];
    
    
}

- (void)buildSubView {
    
    self.view.backgroundColor = BackGrayColor;
    
    UIScrollView *scrollView   = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, self.view.height - 50 *Scale_Height - 64)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate        = self;
    scrollView.keyboardDismissMode = YES;
    scrollView.pagingEnabled    = YES;
    scrollView.scrollEnabled    = YES;
    [self.view addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    self.scrollView = scrollView;
    
    UIView *labelBackView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 90 *Scale_Height)];
    labelBackView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:labelBackView];
    
    {
        
        UILabel *priceTagLabel = [UILabel createLabelWithFrame:CGRectZero
                                                     labelType:kLabelNormal
                                                          text:@"发布者标价："
                                                          font:UIFont_15
                                                     textColor:TextBlackColor
                                                 textAlignment:NSTextAlignmentCenter
                                                           tag:100];
        [labelBackView addSubview:priceTagLabel];
        [priceTagLabel sizeToFit];
        priceTagLabel.frame = CGRectMake(15 *Scale_Width, 0, priceTagLabel.width, 45 *Scale_Height);
        
        UILabel *priceTagContentLabel = [UILabel createLabelWithFrame:CGRectMake(priceTagLabel.x + priceTagLabel.width + 5 *Scale_Width, priceTagLabel.y, Screen_Width - (priceTagLabel.x + priceTagLabel.width + 20 *Scale_Width), priceTagLabel.height)
                                                            labelType:kLabelNormal
                                                                 text:@""
                                                                 font:UIFont_15
                                                            textColor:[UIColor redColor]
                                                        textAlignment:NSTextAlignmentLeft
                                                                  tag:100];
        [labelBackView addSubview:priceTagContentLabel];
        self.priceLabel = priceTagContentLabel;
        
        UILabel *offerLabel = [UILabel createLabelWithFrame:CGRectZero
                                                     labelType:kLabelNormal
                                                          text:@"您的报价："
                                                          font:UIFont_15
                                                     textColor:TextBlackColor
                                                 textAlignment:NSTextAlignmentLeft
                                                           tag:100];
        [labelBackView addSubview:offerLabel];
        [offerLabel sizeToFit];
        offerLabel.frame = CGRectMake(15 *Scale_Width, 45 *Scale_Height, offerLabel.width, 45 *Scale_Height);
        
        UILabel *unitLabel = [UILabel createLabelWithFrame:CGRectZero
                                                 labelType:kLabelNormal
                                                      text:@"元"
                                                      font:UIFont_15
                                                 textColor:TextBlackColor
                                             textAlignment:NSTextAlignmentCenter
                                                       tag:100];
        [labelBackView addSubview:unitLabel];
        [unitLabel sizeToFit];
        unitLabel.frame = CGRectMake(Screen_Width - (unitLabel.width + 15 *Scale_Width), 45 *Scale_Height, unitLabel.width, 45 *Scale_Height);
        
        UITextField *textField = [UITextField createTextFieldWithFrame:CGRectMake(offerLabel.x + offerLabel.width + 5 *Scale_Width, offerLabel.y, unitLabel.x - (offerLabel.x + offerLabel.width + 20 *Scale_Width), 45 *Scale_Height)
                                                         textFieldType:k_textField_phone
                                                        delegateObject:self
                                                             leftImage:nil
                                                       placeholderText:@""
                                                                   tag:100];
        textField.textColor = [UIColor  redColor];
        [labelBackView addSubview:textField];
        textField.backgroundColor = [UIColor clearColor];
        textField.keyboardType  = UIKeyboardTypeDecimalPad;
        self.priceTextField = textField;

        UIView *lineView         = [[UIView alloc]initWithFrame:CGRectMake(0, 45 *Scale_Height, Screen_Width, 0.5f)];
        lineView.backgroundColor = LineColor;
        [labelBackView addSubview:lineView];
        
    }
    
    UIView *textBackView         = [[UIView alloc]initWithFrame:CGRectMake(0, labelBackView.y + labelBackView.height + 10 *Scale_Height, Screen_Width, 195 *Scale_Height)];
    textBackView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:textBackView];
    self.textBackView = textBackView;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15 *Scale_Width, 5 *Scale_Height, textBackView.width - 30 *Scale_Width, textBackView.height - 25 *Scale_Height)];
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
    placeholderLabel.attributedText = [[NSAttributedString alloc] initWithString:@"请输入您的接单留言（不超过50字）" attributes:attribute];
    [textBackView addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
    
    CGRect frame       = textView.frame;
    frame.origin.x    += 6 *Scale_Width;
    frame.size.height  = 30.f *Scale_Height;
    frame.origin.y    += 6 *Scale_Height;
    frame.size.width   = textBackView.width - 41 *Scale_Width;
    self.placeholderLabel.frame = frame;
    
    [textBackView addSubview:textView];
    self.textView = textView;
    
    UILabel *numberLabel = [UILabel createLabelWithFrame:CGRectMake(textBackView.width - 115 *Scale_Width, textBackView.height - 35 *Scale_Height, 100 *Scale_Width, 20 *Scale_Height)
                                               labelType:kLabelNormal
                                                    text:@"50/50"
                                                    font:UIFont_15
                                               textColor:TextGrayColor
                                           textAlignment:NSTextAlignmentRight
                                                     tag:200];
    [textBackView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    {
        
        UIButton *button = [UIButton createButtonWithFrame:CGRectMake(15 *Scale_Width, textBackView.y + textBackView.height + 10 *Scale_Height, Screen_Width - 30 *Scale_Width, 40 *Scale_Height)
                                                     title:@"确认接单"
                                           backgroundImage:nil
                                                       tag:1000
                                                    target:self
                                                    action:@selector(buttonEvent:)];
        button.backgroundColor     = MainColor;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius  = 3 *Scale_Height;
        button.titleLabel.font     = UIFont_M_17;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [scrollView addSubview:button];
        self.publiahButton = button;
        
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.width, self.publiahButton.y + self.publiahButton.height + 10 *Scale_Height);

}

- (void) buttonEvent:(id)sender {
    
    if (self.priceTextField.text.length > 0) {
        
        if ([self.priceTextField.text integerValue] > 99999) {
            
            [MBProgressHUD showMessageTitle:@"请输入0-99999之间的报价" toView:self.view afterDelay:1.5f];
            return;
            
        } else {
            
            [self.params setObject:self.priceTextField.text forKey:@"quote"];
            
        }

    } else {
        
        [MBProgressHUD showMessageTitle:@"请输入您的报价" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    if (self.textView.text.length > 0) {
        
        [self.params setObject:self.textView.text forKey:@"orderMsg"];
        
    } else {
        
        [MBProgressHUD showMessageTitle:@"请输入您的接单留言" toView:self.view afterDelay:1.5f];
        return;
        
    }
    
    [MBProgressHUD showMessage:nil toView:self.view];
    [IWantToOrderViewModel requestPost_addOrderMsgNetWorkingDataWithParams:self.params success:^(id info, NSInteger count) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"接单成功" toView:self.view afterDelay:1.f];
        int64_t delayInSeconds = 1.2f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    } error:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:errorMessage toView:self.view afterDelay:1.f];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showMessageTitle:@"请求服务器失败" toView:self.view afterDelay:1.f];
        
    }];
    
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
        [MBProgressHUD showMessageTitle:@"字数不能超过50字" toView:self.view afterDelay:1.f];
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
            
            [MBProgressHUD showMessageTitle:@"字数不能超过50字" toView:self.view afterDelay:1.f];
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
        
        [MBProgressHUD showMessageTitle:@"字数不能超过50字" toView:self.view afterDelay:1.f];
        
        return NO;
        
    }
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
