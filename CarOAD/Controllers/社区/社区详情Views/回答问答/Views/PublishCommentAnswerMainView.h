//
//  PublishCommentAnswerMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol PublishCommentAnswerMainViewDelegate <NSObject>

- (void) chooseQATagWithTag:(NSInteger)tag;

- (void) chooseCarType;

- (void) addImageWithImageArray:(NSArray *)imageArray;

- (void) showHUDMessage:(NSString *)message;

@end

@interface PublishCommentAnswerMainView : CustomView

@property (nonatomic, weak) id <PublishCommentAnswerMainViewDelegate> delegate;

@property (nonatomic, strong) NSString *content;

- (void) addImageForContentViewWithImageArray:(NSArray *)imageArray;

- (void) buildsubviewWithIsQA:(BOOL)isQA;

- (NSString *)getContentText;

@end
