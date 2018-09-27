//
//  ManagePublishArticleText.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/23.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "ManagePublishArticleText.h"

#define LIMIT_MAX_NUMBER 50

#define Title_Font [UIFont fontWithName:@"iconfont" size:24]

@interface ManagePublishArticleText()

@end

@implementation ManagePublishArticleText

+ (void) getTitleTextViewHeightWithTextView:(UITextView *)textView
                                     finish:(void (^)(CGFloat view_height))finish
                              maxTextNumber:(void (^)(BOOL isOverstepMaxTextNumber))maxTextNumber; {

    //  textView的frame
    CGRect frame = textView.frame;

    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:0];
    style.lineSpacing = 6;
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:24], NSParagraphStyleAttributeName:style};
    
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

                CGFloat labelHeight = [[toBeString substringToIndex:LIMIT_MAX_NUMBER] heightWithStringAttribute:attribute fixedWidth:textView.width - 10];

                if (labelHeight < 40 *Scale_Height) {
                    
                    frame.size.height = 40 *Scale_Height;

                } else {

                    frame.size.height = labelHeight + 20 *Scale_Height;

                }

                //  重写textView的frame
                textView.frame = frame;

                textView.attributedText = [[NSAttributedString alloc] initWithString:[toBeString substringToIndex:LIMIT_MAX_NUMBER] attributes:attribute];

            } else {

                CGFloat labelHeight = [toBeString heightWithStringAttribute:attribute fixedWidth:textView.width - 10];

                if (labelHeight < 40 *Scale_Height) {

                    frame.size.height = 40 *Scale_Height;

                } else {

                    frame.size.height = labelHeight + 20 *Scale_Height;

                }

                //  重写textView的frame
                textView.frame = frame;

                textView.attributedText = [[NSAttributedString alloc] initWithString:toBeString attributes:attribute];

            }

            maxTextNumber(YES);

        } else {

            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            CGFloat labelHeight = [textView.text heightWithStringAttribute:attribute fixedWidth:textView.width - 10];

            if (labelHeight < 40 *Scale_Height) {

                frame.size.height = 40 *Scale_Height;

            } else {

                frame.size.height = labelHeight + 20 *Scale_Height;

            }

            textView.scrollEnabled = NO;

            //  重写textView的frame
            textView.frame = frame;

            maxTextNumber(NO);

        }

    } else{

        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况

        if (toBeString.length >= LIMIT_MAX_NUMBER) {

            CGFloat labelHeight = [[toBeString substringToIndex:LIMIT_MAX_NUMBER] heightWithStringAttribute:attribute fixedWidth:textView.width - 10];

            if (labelHeight < 40 *Scale_Height) {

                frame.size.height = 40 *Scale_Height;

            } else {

                frame.size.height = labelHeight + 20 *Scale_Height;

            }

            textView.scrollEnabled = NO;

            //  重写textView的frame
            textView.frame = frame;

            textView.attributedText = [[NSAttributedString alloc] initWithString:[toBeString substringToIndex:LIMIT_MAX_NUMBER] attributes:attribute];

            maxTextNumber(YES);

        }

    }

    finish(textView.frame.size.height);
    
}

- (NSMutableString *) toHtmlStringWithTextArray:(NSArray *)textArray; {

    NSMutableString *htmlstring=[[NSMutableString alloc]initWithString:@"<html><head><title></title><style>body{width:150px; height:350px;padding-left:200px;}.list_left{font-size:50px; width:350px}.list_right{font-size:50px; }table{ width:700px; overflow-x:hidden; overflow-y:auto;}tr{height:75px;}</style></head><body><table>"];

    return htmlstring;


}

@end
