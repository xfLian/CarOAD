//
//  CommentAnswerDetailsMainView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@protocol CommentAnswerDetailsMainViewDelegate <NSObject>

- (void) loadNewData;
- (void) loadMoreData;

- (void) clickCloseButton;

- (void) publishCommentWithData:(id)data isComment:(BOOL)isComment;
- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag;

- (void) clickDetailsLikeButton;

@end

@interface CommentAnswerDetailsMainView : CustomView

@property (nonatomic, weak) id <CommentAnswerDetailsMainViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *datasArray;
@property (nonatomic, strong) id detailsData;
@property (nonatomic, strong) NSString *commentNumber;

//  更新tableView第一组数据
- (void) loadFirstSectionData;

- (void) showNavBackView;
- (void) hideNavBackView;

- (void) hideMJ;

- (void) showhideKeyboardWithKeyRect:(CGRect)keyRect duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options;
- (void) hidehideKeyboardWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options;

@end
