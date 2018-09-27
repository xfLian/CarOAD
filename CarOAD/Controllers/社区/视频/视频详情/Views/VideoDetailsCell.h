//
//  VideoDetailsCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/25.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoDetailsCellDelegate <NSObject>

- (void) clickDetailsLikeButton;

@end

@interface VideoDetailsCell : UITableViewCell

@property (nonatomic, weak) id <VideoDetailsCellDelegate> delegate;

@property (nonatomic, weak)   id data;

- (void) initSubViews;
- (void) loadContent;

@end
