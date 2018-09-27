//
//  ArticleEdiTextContentView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/31.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol ArticleEdiTextContentViewDelegate <NSObject>

- (void) changeViewHeight:(CGFloat)height;

@end

@interface ArticleEdiTextContentView : CustomView

@property (nonatomic, weak) id <ArticleEdiTextContentViewDelegate> delegate;

- (void) loadContent;

- (void) isCentre:(BOOL)isCentre;
- (void) isAddList:(BOOL)isAddList;
- (void) isBold:(BOOL)isBold;
- (void) isMaxFont:(BOOL)isMaxFont;
- (void) isAddParagraph;
- (void) addImageForTextViewWithImage:(UIImage *)image;

- (NSDictionary *) getTextContent;

@end
