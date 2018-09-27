//
//  CommunityDetailsView.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/9.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CustomView.h"

@interface CommunityDetailsView : CustomView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView         *contentBackView;
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray *datasArray;

@end
