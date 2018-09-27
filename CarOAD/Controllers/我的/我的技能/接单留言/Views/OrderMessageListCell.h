//
//  OrderMessageListCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/21.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

typedef enum : NSUInteger {
    
    kOrderMessageListCellNoDataType,
    kOrderMessageListCellNormalType,
    
} EOrderMessageListCellType;

@protocol OrderMessageListCellDelegate <NSObject, CustomAdapterTypeTableViewCellDelegate>

- (void) clickCellButtonWithType:(NSInteger)type data:(id)data;

@end

@interface OrderMessageListCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id <CustomAdapterTypeTableViewCellDelegate, OrderMessageListCellDelegate> delegate;

@end
