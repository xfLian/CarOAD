//
//  CommentAnswerListCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentAnswerListCellDelegate <NSObject>

- (void) commentReplyWithData:(id)data;

- (void) clickChankAllMessageWithData:(id)data;

@end

@interface CommentAnswerListCell : UITableViewCell

@property (nonatomic, weak) id <CommentAnswerListCellDelegate> delegate;

@property (nonatomic, weak) id data;

- (void)loadContent;

@end
