//
//  OADMyPublishViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/12/12.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADMyPublishViewController.h"

#import "MyPublishMainView.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

#import "CommunityMainViewModel.h"

@interface OADMyPublishViewController ()<MyPublishMainViewDelegate, CommunityChildViewControllerDelegate>
{

    BOOL isGetFirstData;
    BOOL isGetSecondData;
    BOOL isGetThirdData;

    BOOL isPlayVideo;

}
@property (nonatomic, strong) MyPublishMainView *subView;

@property (nonatomic, strong) FirstViewController  *firstVC;
@property (nonatomic, strong) SecondViewController *secondVC;
@property (nonatomic, strong) ThirdViewController  *thirdVC;

@end

@implementation OADMyPublishViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;

    if (isGetFirstData == NO) {

        [self.firstVC.tableView.mj_header beginRefreshing];

        isGetFirstData = YES;

    }

}

- (void) viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    //  创建保存点赞项的plist文件
    [[PreserveLikeData initPreserveLikeData] creatSqlite];

}

- (void)setNavigationController {

    self.navTitle = @"我的发布";
    self.leftItemText = @"返回";

    [super setNavigationController];

}

- (void)buildSubView {

    [super buildSubView];
    
    NSString *userId = nil;
    if ([OADLogInOrNo logInIsSuccessOrNoDelegate:self]) {

        OADAccountInfo *accountInfo = [OADSaveAccountInfoTool accountInfo];

        userId = accountInfo.user_id;

    }

    FirstViewController *firstVC = [[FirstViewController alloc] init];
    firstVC.userId               = userId;
    firstVC.isMyPublishVC        = YES;
    [self addChildViewController:firstVC];
    firstVC.delegate = self;
    self.firstVC = firstVC;

    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.userId                = userId;
    secondVC.isMyPublishVC         = YES;
    [self addChildViewController:secondVC];
    secondVC.delegate = self;
    self.secondVC = secondVC;

    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    thirdVC.userId               = userId;
    thirdVC.isMyPublishVC        = YES;
    [self addChildViewController:thirdVC];
    thirdVC.delegate = self;
    self.thirdVC = thirdVC;

    MyPublishMainView *subView = [[MyPublishMainView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    subView.viewsArray = @[firstVC.view,secondVC.view,thirdVC.view];
    [subView buildSubView];
    subView.delegate   = self;
    [self.contentView addSubview:subView];

    self.subView = subView;

    [firstVC didMoveToParentViewController:self];
    [secondVC didMoveToParentViewController:self];
    [thirdVC didMoveToParentViewController:self];

}

- (void) clickChooseCardButton:(NSInteger)tag; {

    if (tag == 0) {

        if (isGetFirstData == NO) {

            [self.firstVC.tableView.mj_header beginRefreshing];

            isGetFirstData = YES;

        }

    } else if (tag == 1) {

        if (isGetSecondData == NO) {

            [self.secondVC.tableView.mj_header beginRefreshing];

            isGetSecondData = YES;

        }

    } else if (tag == 2) {

        if (isGetThirdData == NO) {

            [self.thirdVC getTagType];

            isGetThirdData = YES;

        }

    }

}

- (void) getNetWorkingDataSuccessWithTag:(NSInteger)type; {

    if (type == 0) {

        isGetFirstData = YES;

    } else if (type == 1) {

        isGetSecondData = YES;

    } else if (type == 2) {

        isGetThirdData = YES;

    }

}

@end
