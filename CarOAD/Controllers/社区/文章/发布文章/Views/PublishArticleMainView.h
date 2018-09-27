//
//  PublishArticleMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/19.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol PublishArticleMainViewDelegate <NSObject>

- (void) chooseTypeWithTag:(NSInteger)tag;

- (void) chooseCarType;

- (void) addTitleImageView;

- (void) addTextViewImage;

/**
 发布文章

 @param title        标题
 @param titleImage   封面图
 @param contentArray 内容数组
 @param imagesArray  内容图片数组
 */
- (void) publishArticleWithTitle:(NSString *)title
                      titleImage:(UIImage *)titleImage
                    contentArray:(NSArray *)contentArray
                     imagesArray:(NSArray *)imagesArray;

@end

@interface PublishArticleMainView : CustomView

@property (nonatomic, weak) id <PublishArticleMainViewDelegate> delegate;

@property (nonatomic, strong) NSArray *buttonTitleArray;

- (void) buildsubview;

- (void) addTitleImageWithImage:(UIImage *)image;

- (void) addImageForTextViewWithImage:(UIImage *)image;

- (void) showhideKeyboardWithKeyRect:(CGRect)keyRect duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options;
- (void) hidehideKeyboardWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options;

@end
