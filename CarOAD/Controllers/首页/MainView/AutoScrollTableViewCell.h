//
//  AutoScrollTableViewCell.h
//  CM-v1.0
//
//  Created by xf_Lian on 2017/11/10.
//  Copyright © 2017年 caroad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AutoScrollTableViewCellDelegate <NSObject>

//  点击投诉处理
- (void) clickChankDetailsWithData:(id)data;

@end

@interface AutoScrollTableViewCell : UITableViewCell

@property (nonatomic, weak) id<AutoScrollTableViewCellDelegate> delegate;

@property (nonatomic, weak) id data;

- (void)loadContent;

@end
