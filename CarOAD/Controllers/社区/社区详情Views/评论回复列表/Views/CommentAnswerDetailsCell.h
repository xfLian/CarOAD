//
//  CommentAnswerDetailsCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/16.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentAnswerDetailsCellDelegate <NSObject>

- (void) clickDetailsLikeButton;
- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag;

@end

@interface CommentAnswerDetailsCell : UITableViewCell

@property (nonatomic, weak) id <CommentAnswerDetailsCellDelegate> delegate;

@property (nonatomic, weak) id data;

- (void)loadContent;

@end
