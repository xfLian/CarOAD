//
//  QADetailsCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QADetailsCellDelegate <NSObject>

- (void) clickChankImageWithImageArray:(NSArray *)array tag:(NSInteger)tag;
- (void) clickDetailsLikeButton;

@end

@interface QADetailsCell : UITableViewCell

@property (nonatomic, weak) id <QADetailsCellDelegate> delegate;

@property (nonatomic, weak) id data;

- (void)loadContent;

@end
