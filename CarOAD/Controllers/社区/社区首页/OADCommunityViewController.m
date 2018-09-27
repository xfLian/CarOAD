//
//  OADCommunityViewController.m
//  CarOAD
//
//  Created by xf_Lian on 2017/9/29.
//  Copyright © 2017年 xf_Lian. All rights reserved.
//

#import "OADCommunityViewController.h"

#import "CommunityMainView.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"

#import "OADPublishQuestionAndAnswerViewController.h"
//#import "OADPublishMovieViewController.h"
#import "OADPublishArticleViewController.h"

#import "CommunityMainViewModel.h"

@interface OADCommunityViewController ()<CommunityMainViewDelegate, CommunityChildViewControllerDelegate>
{
    
    BOOL isGetFirstData;
    BOOL isGetSecondData;
    BOOL isGetThirdData;
    BOOL isGetFourthData;
    BOOL isGetFifthData;

    BOOL isPlayVideo;
    
}
@property (nonatomic, strong) CommunityMainView *subView;

@property (nonatomic, strong) FirstViewController  *firstVC;
@property (nonatomic, strong) SecondViewController *secondVC;
@property (nonatomic, strong) ThirdViewController  *thirdVC;
@property (nonatomic, strong) FourthViewController *fourthVC;
@property (nonatomic, strong) FifthViewController  *fifthVC;

@end

@implementation OADCommunityViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    if (isGetFirstData == NO) {
        
        [self.firstVC.tableView.mj_header beginRefreshing];
        
        isGetFirstData = YES;
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.subView hideButtonBackView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  创建保存点赞项的plist文件
    [[PreserveLikeData initPreserveLikeData] creatSqlite];
    
}

- (void)setNavigationController {
    
    self.navTitle = @"社区";
    
    [super setNavigationController];
    
}

- (void)buildSubView {
    
    [super buildSubView];
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    [self addChildViewController:firstVC];
    firstVC.delegate = self;
    self.firstVC = firstVC;
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self addChildViewController:secondVC];
    secondVC.delegate = self;
    self.secondVC = secondVC;
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    [self addChildViewController:thirdVC];
    thirdVC.delegate = self;
    self.thirdVC = thirdVC;
    
    FourthViewController *fourthVC = [[FourthViewController alloc] init];
    [self addChildViewController:fourthVC];
    fourthVC.delegate = self;
    self.fourthVC = fourthVC;
    
    FifthViewController *fifthVC = [[FifthViewController alloc] init];
    [self addChildViewController:fifthVC];
    fifthVC.delegate = self;
    self.fifthVC = fifthVC;
    
    self.contentView.frame = CGRectMake(0, SafeAreaTopHeight, self.view.width, self.view.height - SafeAreaTopHeight - 49 - SafeAreaBottomHeight);
    
    CommunityMainView *subView = [[CommunityMainView alloc] initWithFrame:self.contentView.bounds];
    subView.viewsArray = @[firstVC.view,secondVC.view,thirdVC.view,fourthVC.view,fifthVC.view];
    [subView buildSubView];
    subView.delegate   = self;
    [self.contentView addSubview:subView];
    
    self.subView = subView;
    
    [firstVC didMoveToParentViewController:self];
    [secondVC didMoveToParentViewController:self];
    [thirdVC didMoveToParentViewController:self];
    [fourthVC didMoveToParentViewController:self];
    [fifthVC didMoveToParentViewController:self];
    
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
        
    } else if (tag == 3) {
        
        if (isGetFourthData == NO) {
            
            [self.fourthVC getTagType];
            isGetFourthData = YES;
            
        }
        
    } else if (tag == 4) {
        
        if (isGetFifthData == NO) {
            
            [self.fifthVC getTagType];
            isGetFifthData = YES;
            
        } 
        
    }
    
}

- (void) clickAddMessageButtonWithTag:(NSInteger)tag; {
    
    if (tag == 1) {
        
        OADPublishQuestionAndAnswerViewController *viewController = [[OADPublishQuestionAndAnswerViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if (tag == 2) {
        
//        OADPublishMovieViewController *viewController = [[OADPublishMovieViewController alloc] init];
//        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if (tag == 3) {

        OADPublishArticleViewController *viewController = [[OADPublishArticleViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];

    }
    
}

- (void) getNetWorkingDataSuccessWithTag:(NSInteger)type; {
    
    if (type == 0) {
        
        isGetFirstData = YES;
        
    } else if (type == 1) {
        
        isGetSecondData = YES;
        
    } else if (type == 2) {
        
        isGetThirdData = YES;
        
    } else if (type == 3) {
        
        isGetFourthData = YES;
        
    } else if (type == 4) {

        isGetFifthData = YES;
        
    }
    
}

@end
