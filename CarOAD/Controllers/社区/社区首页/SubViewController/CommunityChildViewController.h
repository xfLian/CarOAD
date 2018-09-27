//
//  CommunityChildViewController.h
//  CarOAD
//
//  Created by xf_Lian on 2017/10/7.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommunityMainViewModel.h"

@protocol CommunityChildViewControllerDelegate <NSObject>

- (void) getNetWorkingDataSuccessWithTag:(NSInteger)type;

@end

@interface CommunityChildViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <CommunityChildViewControllerDelegate> delegate;

@property (nonatomic, assign) BOOL         isMyPublishVC;
@property (nonatomic, strong) NSString    *userId;
@property (nonatomic, strong) UITableView *tableView;

- (void) buildSubView;
- (void) loadNewData;
- (void) loadMoreData;
- (void) startNetworking;

@end
