//
//  MessageDetailsCell.h
//  CarOAD
//
//  Created by xf_Lian on 2018/1/5.
//  Copyright © 2018年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@protocol MessageDetailsCellDelegate <NSObject>

- (void) clickChankDetailsWithData:(id)data;

@end

@interface MessageDetailsCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id <MessageDetailsCellDelegate> cellSubDelegate;

@end
