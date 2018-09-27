//
//  CommunityArticleCell.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/27.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityArticleCell : UITableViewCell

@property (nonatomic, weak) id data;

- (void)loadContent;

@end
