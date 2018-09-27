//
//  HomePageBulletinCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/11/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomAdapterTypeTableViewCell.h"

@class HomePageBulletinCell;

@protocol HomePageBulletinCellDelegate <NSObject,CustomAdapterTypeTableViewCellDelegate>

- (void) clickChankBulletinDetailsWithData:(id)data;

@end

@interface HomePageBulletinCell : CustomAdapterTypeTableViewCell

@property (nonatomic, weak) id<CustomAdapterTypeTableViewCellDelegate,HomePageBulletinCellDelegate> delegate;

- (void) loadContent;

@end
