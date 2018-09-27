//
//  ChooseNeedInfomationCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/30.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseNeedInfomationCellDelegate <NSObject>

- (void) selectedItemsWithItem:(NSInteger)item cell_tag:(NSInteger)cell_tag;

@end

@interface ChooseNeedInfomationCell : UITableViewCell

@property (nonatomic, weak) id <ChooseNeedInfomationCellDelegate> delegate;

@property (nonatomic, strong) id data;

- (void) loadContent;

@end
