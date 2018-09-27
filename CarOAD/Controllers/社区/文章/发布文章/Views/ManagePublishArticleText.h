//
//  ManagePublishArticleText.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/23.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagePublishArticleText : NSObject

/**
 *  标题编辑框
 *
 *  @param textView title编辑框
 */
+ (void) getTitleTextViewHeightWithTextView:(UITextView *)textView
                                     finish:(void (^)(CGFloat view_height))finish
                                     maxTextNumber:(void (^)(BOOL isOverstepMaxTextNumber))maxTextNumber;

- (NSMutableString *) toHtmlStringWithTextArray:(NSArray *)textArray;

@end
