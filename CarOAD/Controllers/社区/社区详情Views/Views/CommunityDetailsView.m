//
//  CommunityDetailsView.m
//  CarOAD
//
//  Created by xf_Lian on 2017/10/9.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "CommunityDetailsView.h"

@interface CommunityDetailsView()

@property (nonatomic, strong) UILabel *allNumberLabel;

@end

@implementation CommunityDetailsView

- (void)buildSubview {
    
    UITableView *tableView    = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    
    tableView.delegate       = self;
    tableView.dataSource     = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;  //隐藏tableview分割线
    
    [self addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark -
//  有多少个分区
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

//  每个分区有多少个cell
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
        
    } else {
        
        return self.datasArray.count;
        
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 0.01;
        
    } else {
        
        return 30 *Scale_Height;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectZero];
    
    headerView.backgroundColor = [UIColor whiteColor];
    
    if (section == 0) {
        
        headerView.frame = CGRectMake(0, 0, tableView.width, 0);
        
    } else {
        
        headerView.frame = CGRectMake(0, 0, tableView.width, 30 *Scale_Height);
        
        if (headerView.subviews) {
            
            for (UIView *subView in headerView.subviews) {
                
                [subView removeFromSuperview];
                
            }
            
        }
        
        UILabel *label = [UILabel createLabelWithFrame:CGRectZero
                                             labelType:kLabelNormal
                                                  text:@"全部评论(0)"
                                                  font:UIFont_15
                                             textColor:MainColor
                                         textAlignment:NSTextAlignmentCenter
                                                   tag:100];
        [headerView addSubview:label];
        [label sizeToFit];
        label.frame = CGRectMake((headerView.width - label.width) / 2, (headerView.height - label.height) / 2 - 0.5f, label.width, 20 *Scale_Height);
        self.allNumberLabel = label;
        
        UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectMake(12 *Scale_Width, headerView.height / 2, (headerView.width - label.width) / 2 - 22 *Scale_Width, 1.f)];
        leftLineView.backgroundColor = TextGrayColor;
        [headerView addSubview:leftLineView];
        
        UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectMake((headerView.width + label.width) / 2 + 10 *Scale_Width, headerView.height / 2 - 0.5f, leftLineView.width, 1.f)];
        rightLineView.backgroundColor = TextGrayColor;
        [headerView addSubview:rightLineView];
        
    }
    
    return headerView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    
    return cell;
    
}

@end
