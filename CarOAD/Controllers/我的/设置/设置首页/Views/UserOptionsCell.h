//
//  UserOptionsCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/12/9.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@interface UserOptionsCell : CustomAdapterTypeTableViewCell

@property (nonatomic, strong) id data;

- (void) loadContent;

@end
